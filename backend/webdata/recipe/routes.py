from flask import request, jsonify, Blueprint, flash
from flask_restx import Api, Resource, fields, reqparse

from webdata.models import User, Nutrition, NutritionDetail, Ingredient, Recipe, RecipeDetail, FavoriteRecipe
from webdata import jwt, bcrypt
from flask_jwt_extended import create_access_token, create_refresh_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_cors import CORS



recipe = Blueprint('recipe', __name__)
api = Api(recipe, doc = '/docs')

authorization_header = reqparse.RequestParser()
authorization_header.add_argument('Authorization', location='headers',  required=True, help='Bearer <access_token>')

@api.route('get_recipe')
@api.route('get_recipe/<int:page>')
class GetRecipe(Resource):
    def get(self):
        page = request.args.get('page', default=1, type=int)
        per_page = request.args.get('per_page', default=5, type=int)
        recipes = Recipe.query.paginate(page=page, per_page=per_page)
        response = []

        for recipe in recipes.items:
            response.append({
                'id' : recipe.id,
                'name' : recipe.name,
                'steps' : recipe.steps,
                'cooktime' : recipe.cooktime,
                'portions' : recipe.portions,
            })
        return response, 200