from flask import request, jsonify, Blueprint, flash
from flask_restx import Api, Resource, fields, reqparse

from webdata.models import User, Nutrition, NutritionDetail, Ingredient
from webdata import jwt, bcrypt
from flask_jwt_extended import create_access_token, create_refresh_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_cors import CORS



ingredient = Blueprint('ingredient', __name__)
api = Api(ingredient, doc = '/docs')

CORS(ingredient, resources={r"/*": {"origins": "*"}})

authorization_header = reqparse.RequestParser()
authorization_header.add_argument('Authorization', location='headers',  required=True, help='Bearer <access_token>')

@api.route('/get_ingredient')
@api.route('/get_ingredient?page=<int:page>')
@api.route('/get_ingredient?page=<int:page>&per_page=<int:per_page>')
class GetIngredient(Resource):
    # @api.expect(authorization_header, validate=True)
    # @jwt_required()
    def get(self):
        page = request.args.get('page', default=1, type=int)
        per_page = request.args.get('per_page', default=5, type=int)
        ingredients = Ingredient.query.paginate(page=page, per_page=per_page)
        response = dict()
                
        for ingredient in ingredients.items:
            nutrition = dict()
            nutritionDetails = NutritionDetail.query.filter_by(ingredient_id=ingredient.id).all()
            for nutr_detail in nutritionDetails:
                nutrition_id = nutr_detail.nutrition_id
                nutr = Nutrition.query.filter_by(id=nutrition_id).first()
                
                nutrition[nutr.id] = {
                    'id': nutr.id,
                    'name': nutr.name,
                    'amount': nutr_detail.amount,
                    'unit' : nutr.unit,
                }

            response[ingredient.id] = {
                'id': ingredient.id,
                'name': ingredient.name,
                'representation' : f'Nutrition from {ingredient.name} per 100 gr',
                'description': ingredient.description,
                'nutrition': list(nutrition.values())  
            }

        return {
            'data': response,
            'total_pages': ingredients.pages,
            'current_page': page,
            'per_page': per_page,
            'total_items': ingredients.total
        }, 200

@api.route('/shownutrition/<string:name1>')
class ShowNutrition(Resource):
    def get(self, name1):
        if not name1:
            return {'message': 'Please input ingredient!'}, 404
        ingredients =  Ingredient.query.filter_by(name = name1).all()
        if not ingredients:
            return {'message': f'There are no ingredients with name "{name1}" found!'}, 404
        response = dict()
        for ingredient in ingredients:
            if ingredient.name.lower() == name1.lower():
                nutritionDetail = []
                nutrition = dict()
                
                nutritionDetails = NutritionDetail.query.filter_by(ingredient_id = ingredient.id).all()
                for nutr_detail in nutritionDetails:
                    nutrition_id = nutr_detail.nutrition_id
                    nutr = Nutrition.query.filter_by(id=nutrition_id).first()
                    nutrition[nutr.id] ={
                        'id': nutr.id,
                        'name': nutr.name,
                        'amount': nutr_detail.amount,
                        'unit': nutr.unit
                    }
                response[ingredient.id]={
                    'id': ingredient.id,
                    'name': ingredient.name,
                    'representation' : f'Nutrition from {ingredient.name} per 100 gr',
                    'description': ingredient.description,
                    'nutrition': list(nutrition.values())
                }
        return {'data': response}, 200
    
