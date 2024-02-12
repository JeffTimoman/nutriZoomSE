from flask import request, jsonify, Blueprint
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
class GetNutrition(Resource):
    # @api.expect(authorization_header, validate=True)
    # @jwt_required()
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

@api.route('/showingredients?name1=<string:name1>')
@api.route('/showingredients?name1=<string:name1>&name2=<string:name2>')
@api.route('/showingredients?name1=<string:name1>&name2=<string:name2>&name3=<string:name3>')
class ShowIngredient(Resource):
    #ini belum di tst karena masih ada problem di admin add ingredient. Kalau ini bisa akan gw ganti ke post
    def get(self, name1, name2, name3):
        nutritions =  Nutrition.query.all()
        response = []
        if not name1:
            return {'message': 'Please input at least 1 nutrition!'}, 404
        for nutrition in nutritions:
            if nutrition.name == name1 or nutrition.name == name2 or nutrition.name == name3:
                nutritionDetail = []
                ingredient = []
                
                tempNutritionDetail = NutritionDetail.query.filter_by(nutrition_id = nutrition.id).all()

                if not tempNutritionDetail:
                    return {'message': f'There are no nutrition details with nutrition: {nutrition.name} found!'}, 404

                for detail in tempNutritionDetail:
                    nutritionDetail.append({
                        'ingredient_id': detail.ingredient_id,
                        'amount': detail.amount
                    })

                    tempIngredient = Ingredient.query.filter_by(id=detail.ingredient_id).all()

                    if not tempIngredient:
                        return {'message': f'There are no ingredients with nutrition: {nutrition.name} found!'}, 404

                    for ing in tempIngredient:
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

