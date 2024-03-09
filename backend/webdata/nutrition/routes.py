from flask import request, jsonify, Blueprint, flash, url_for
from flask_restx import Api, Resource, fields, reqparse

from webdata.models import User, Nutrition, NutritionDetail, Ingredient
from webdata import jwt, bcrypt
from flask_jwt_extended import create_access_token, create_refresh_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_cors import CORS



nutrition = Blueprint('nutrition', __name__)
api = Api(nutrition, doc = '/docs')

CORS(nutrition, resources={r"/*": {"origins": "*"}})

authorization_header = reqparse.RequestParser()
authorization_header.add_argument('Authorization', location='headers',  required=True, help='Bearer <access_token>')

@api.route('/get_nutrition')
@api.route('/get_nutrition?page=<int:page>')
@api.route('/get_nutrition?page=<int:page>&per_page=<int:per_page>')
class GetNutrition(Resource):
    # @api.expect(authorization_header, validate=True)
    # @jwt_required()'
    def get(self):
        page = request.args.get('page', default=1, type=int)
        per_page = request.args.get('per_page', default=5, type=int)
        nutritions = Nutrition.query.paginate(page=page, per_page=per_page)
        response = dict()

        for nutrition in nutritions.items:
            response[nutrition.id]={
                'name' : nutrition.name,
                'unit' : nutrition.unit,
                'id' : nutrition.id
            }

        return {
            'data': response,
            'total_pages': nutritions.pages,
            'current_page': page,
            'per_page': per_page,
            'total_items': nutritions.total
        }, 200
    


# @api.route('/showingredients/<string:name1>')
# class ShowIngredient(Resource):
#     def get(self, name1):
#         if not name1:
#             return {'message': 'Please input nutrition!'}, 404
#         nutritions =  Nutrition.query.filter_by(name = name1).all()
#         if not nutritions:
#             return {'message': f'There are no nutritions with name "{name1}" found!'}, 404
#         response = {}
#         for nutrition in nutritions:
#             if nutrition.name.lower() == name1.lower():
#                 nutritionDetail = {}
#                 ingredient = {}
                
#                 nutritionDetails = NutritionDetail.query.filter_by(nutrition_id = nutrition.id).all()

#                 if not nutritionDetails:
#                     return {'message': f'There are no nutrition details with nutrition "{nutrition.name}" found!'}, 404

#                 for detail in nutritionDetails:
#                     nutritionDetail[detail.ingredient_id] = {
#                         'ingredient_id': detail.ingredient_id,
#                         'amount': detail.amount
#                     }

#                     ingredients = Ingredient.query.join(NutritionDetail).filter(NutritionDetail.nutrition_id == nutrition.id, NutritionDetail.amount > 0).order_by(NutritionDetail.amount.desc()).all()

#                     if not ingredients:  
#                         return {'message': f'There are no ingredients with nutrition: {nutrition.name} found!'}, 404

#                 for ing in ingredients:
#                     ingredient[ing.id] = {
#                         'name': ing.name,
#                         'description': ing.description,
#                         'id' : ing.id,
#                         'image' : url_for('main.view_image', filename=ing.image, _external=True),
#                         'amount' : nutritionDetail[ing.id]['amount']
#                     }
                
#                 response = {
#                     'name': nutrition.name,
#                     'unit': nutrition.unit,
#                     'id': nutrition.id,
#                     'ingredient': ingredient
#                 }
                
#         return response, 200
    
@api.route('/shownutrition/<string:name1>')
class ShowNutrition(Resource):
    def get(self, name1):
        if not name1:
            return {'message': 'Please input ingredient!'}, 404

        # Use the 'ilike' operator to search for similar names
        ingredient = Ingredient.query.filter(Ingredient.name.ilike(f"%{name1}%")).first()

        if not ingredient:
            return {'message': f'No ingredient with a similar name to "{name1}" found!'}, 404

        nutrition = dict()
        nutritionDetails = NutritionDetail.query.filter_by(ingredient_id=ingredient.id).all()

        for nutr_detail in nutritionDetails:
            nutrition_id = nutr_detail.nutrition_id
            nutr = Nutrition.query.filter_by(id=nutrition_id).first()
            nutrition[nutrition_id] = {
                'id': nutr.id,
                'name': nutr.name,
                'amount': nutr_detail.amount,
                'unit': nutr.unit
            }

        response = {
            'id': ingredient.id,
            'name': ingredient.name,
            'representation': f'Nutrition from {ingredient.name} per 100 gr',
            'description': ingredient.description,
            'nutrition': nutrition
        }

        return {'data': response}, 200