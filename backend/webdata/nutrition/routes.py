from flask import request, jsonify, Blueprint, flash
from flask_restx import Api, Resource, fields, reqparse

from webdata.models import User, Nutrition, NutritionDetail, Ingredient
from webdata import jwt, bcrypt
from flask_jwt_extended import create_access_token, create_refresh_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_cors import CORS
from flask import request
from flask import request



nutrition = Blueprint('nutrition', __name__)
api = Api(nutrition, doc = '/docs')

authorization_header = reqparse.RequestParser()
authorization_header.add_argument('Authorization', location='headers',  required=True, help='Bearer <access_token>')

@api.route('/get_nutrition')
@api.route('/get_nutrition?page=<int:page>')
class GetNutrition(Resource):
    # @api.expect(authorization_header, validate=True)
    # @jwt_required()
    def get(self):
        page = request.args.get('page', default=1, type=int)
        per_page = request.args.get('per_page', default=3, type=int)
         
        nutritions = Nutrition.query.paginate(page=page, per_page=per_page)
        response = dict()

        for nutrition in nutritions.items:
            response[nutrition.id]={
                'name' : nutrition.name,
                'description' : nutrition.description,
                'id' : nutrition.id
            }

        return {
            'data': response,
            'total_pages': nutritions.pages,
            'current_page': page,
            'per_page': per_page,
            'total_items': nutritions.total
        }, 200
    


@api.route('/showingredients/<string:name1>')
class ShowIngredient(Resource):
    def get(self, name1):
        nutritions =  Nutrition.query.all()
        response = []
        if not name1:
            return {'message': 'Please input at least 1 nutrition!'}, 404
        for nutrition in nutritions:
            if nutrition.name.lower() == name1.lower():
                nutritionDetail = []
                ingredient = []
                
                nutritionDetails = NutritionDetail.query.filter_by(nutrition_id = nutrition.id).all()

                if not nutritionDetails:
                    return {'message': f'There are no nutrition details with nutrition: {nutrition.name} found!'}, 404

                for detail in nutritionDetails:
                    nutritionDetail.append({
                        'ingredient_id': detail.ingredient_id,
                        'amount': detail.amount
                    })

                    ingredients = Ingredient.query.filter_by(id=detail.ingredient_id).order_by(Ingredient.name.desc()).all()

                    if not ingredients:
                        return {'message': f'There are no ingredients with nutrition: {nutrition.name} found!'}, 404

                    for ing in ingredients:
                        ingredient.append({
                            'name': ing.name,
                            'description': ing.description
                        })
                
                response.append({
                    'name': nutrition.name,
                    'description': nutrition.description,
                    'id': nutrition.id,
                    'ingredient': [ing['name'] for ing in ingredient],
                })
        return response, 200
    

# @api.route('/showingredients/<string:name1>/<string:name2>')
# @api.route('/showingredients/<string:name1>/<string:name2>/<string:name3>')
# class ShowIngredient(Resource):
#     def get(self, name1, name2, name3):
#         response = []
#         if not name1:
#             flash('You must be input at least 1 nutrition!', 'error')
#             return response, 404
#         nutritions = Nutrition.query.all()
#         counter = 1
#         if name2:
#             if name3:
#                 counter = counter + 1
#             counter = counter + 1 

#         for ntr in nutritions:
#             if ntr.name == name1 or name2 or name3:
#                 nutritionDetail = []
#                 ingredient = []
#                 nutritionDetails = NutritionDetail.query.filter_by(nutrition_id = ntr.id).all()
#                 for i in range(counter):
#                     for detail in nutritionDetails:
#                         nutritionDetail.append({
#                             'ingredient_id': detail.ingredient_id,
#                             'amount': detail.amount
#                         })

#                         ingredients = Ingredient.query.filter_by(id=detail.ingredient_id).all()

#                         for ing in ingredients:
#                             ingredient.append({
#                                 'name': ing.name,
#                                 'description': ing.description
#                             })
#         response.append({
#             'name': ntr.name,
#             'description': ntr.description,
#             'id': ntr.id,
#             'ingredient': [ing['name'] for ing in ingredient],
#         })
#         return response, 200


