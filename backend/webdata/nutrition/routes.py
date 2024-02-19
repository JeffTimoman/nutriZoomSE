from flask import request, jsonify, Blueprint, flash
from flask_restx import Api, Resource, fields, reqparse

from webdata.models import User, Nutrition, NutritionDetail, Ingredient
from webdata import jwt, bcrypt
from flask_jwt_extended import create_access_token, create_refresh_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_cors import CORS



nutrition = Blueprint('nutrition', __name__)
api = Api(nutrition, doc = '/docs')

authorization_header = reqparse.RequestParser()
authorization_header.add_argument('Authorization', location='headers',  required=True, help='Bearer <access_token>')

@api.route('/get_nutrition')
@api.route('/get_nutrition?page=<int:page>')
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
        if not name1:
            return {'message': 'Please input at least 1 nutrition!'}, 404
        nutritions =  Nutrition.query.filter_by(name = name1).all()
        if not nutritions:
            return {'message': f'There are no nutritions with name "{name1}" found!'}, 404
        response = []
        for nutrition in nutritions:
            if nutrition.name.lower() == name1.lower():
                nutritionDetail = []
                ingredient = []
                
                nutritionDetails = NutritionDetail.query.filter_by(nutrition_id = nutrition.id).all()

                if not nutritionDetails:
                    return {'message': f'There are no nutrition details with nutrition "{nutrition.name}" found!'}, 404

                for detail in nutritionDetails:
                    nutritionDetail.append({
                        'ingredient_id': detail.ingredient_id,
                        'amount': detail.amount
                    })

                    ingredients = Ingredient.query.join(NutritionDetail).filter(NutritionDetail.nutrition_id == nutrition.id, NutritionDetail.amount > 0).order_by(NutritionDetail.amount.desc()).all()

                    if not ingredients:  
                        return {'message': f'There are no ingredients with nutrition: {nutrition.name} found!'}, 404

                for ing in ingredients:
                    ingredient.append({
                        'name': ing.name,
                        'description': ing.description,
                        'id' : ing.id,
                        'image' : ing.image,
                        'amount' : [detail['amount'] for detail in nutritionDetail if detail['ingredient_id'] == ing.id][0]
                    })
                
                response.append({
                    'name': nutrition.name,
                    'description': nutrition.description,
                    'id': nutrition.id,
                    'ingredient': [{'id': ing['id'], 'name': ing['name'], 'image' : ing['image'], 'amount':ing['amount']} for ing in ingredient]
                })
        return response, 200
    
