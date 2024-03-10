from flask import request, jsonify, Blueprint, flash, url_for
from flask_restx import Api, Resource, fields, reqparse

from webdata.models import User, Nutrition, NutritionDetail, Ingredient, Recipe, RecipeDetail, FavoriteRecipe
from webdata import jwt, bcrypt, db
from flask_jwt_extended import create_access_token, create_refresh_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_cors import CORS



recipe = Blueprint('recipe', __name__)
api = Api(recipe, doc = '/docs')

CORS(recipe, resources={r"/*": {"origins": "*"}})
authorization_header = reqparse.RequestParser()
authorization_header.add_argument('Authorization', location='headers',  required=True, help='Bearer <access_token>')

#GET RECIPE
@api.route('/get_recipe')
@api.route('/get_recipe?page=<int:page>')
@api.route('/get_recipe?page=<int:page>&per_page=<int:per_page>')
class GetRecipe(Resource):
    def get(self):
        page = request.args.get('page', default=1, type=int)
        per_page = request.args.get('per_page', default=4, type=int)
        recipes = Recipe.query.paginate(page=page, per_page=per_page)
        response = dict()
        difficult = ['easy', 'medium', 'hard', 'expert', 'nightmare']
        for recipe in recipes.items:
            temp = 1
            if recipe.cooktime > 30 and recipe.cooktime <= 45:
                temp = 2
            elif recipe.cooktime > 45 and recipe.cooktime <= 90:
                temp = 3
            elif recipe.cooktime > 90 and recipe.cooktime <= 120:
                temp = 4
            elif recipe.cooktime > 120:
                temp = 5
            ingredient = dict()
            nutrition_totals = dict()

            # for nutr in Nutrition.query.all():
            #     nutrition_totals[nutr.id] = 0
            #ini kalau mau nampilin semua informasi nutrisi (termasuk yang 0 nutrisinya). Aktifin sama comment diatas yang nutr in Nutrition.query.all()

            for detail in RecipeDetail.query.filter_by(recipe_id=recipe.id).all():
                ingredient_name = Ingredient.query.filter_by(id=detail.ingredients_id).first().name
                amount = detail.amount

                for nutr_detail in NutritionDetail.query.filter_by(ingredient_id=detail.ingredients_id).all():
                    nutr_id = Nutrition.query.filter_by(id=nutr_detail.nutrition_id).first().id

                    # nutrition_totals[nutr_id] += nutr_detail.amount * amount / 100
                    nutrition_totals[nutr_id] = nutrition_totals.get(nutr_id, 0) + nutr_detail.amount * amount / 100

                ingredient[detail.ingredients_id] = {
                    'name': ingredient_name,
                    'amount': amount,
                    'unit': detail.unit,
                }

            nutrition_list = dict()
            for nutr_id in nutrition_totals :
                nutrition = Nutrition.query.filter_by(id=nutr_id).first()
                nutrition_list[nutr_id] = {
                    'name': nutrition.name, 
                    'amount': nutrition_totals[nutr_id],
                    'unit': nutrition.unit
                    }

            response[recipe.id] = {
                'name': recipe.name,
                'steps': recipe.steps,
                'cooktime': recipe.cooktime,
                'portions': recipe.portions,
                'difficulty' : difficult[temp],
                'image': url_for('main.view_image', filename=recipe.image, _external=True),
                'ingredients': ingredient,
                'nutrition_list': nutrition_list
            }

        return {
            'data': response,
            'total_pages': recipes.pages,
            'current_page': page,
            'per_page': per_page,
            'total_items': recipes.total
        }, 200

#FIND RECIPE BY NAME
@api.route('/find_recipe/<string:name1>')
class FindRecipe(Resource):
    def get(self, name1):
        if not name1:
            return {'message': 'Please input recipe!'}, 404

        recipes = Recipe.query.filter(Recipe.name.ilike(f"%{name1}%")).all()

        if not recipes:
            
            return {'message': f'There are no recipes with name containing "{name1}" found!'}, 404
        response = dict()
        difficult = ['easy', 'medium', 'hard', 'expert', 'nightmare']
        for recipe in recipes:
            temp = 1
            total_calory = 0
            if recipe.cooktime > 30 and recipe.cooktime <= 45:
                temp = 2
            elif recipe.cooktime > 45 and recipe.cooktime <= 90:
                temp = 3
            elif recipe.cooktime > 90 and recipe.cooktime <= 120:
                temp = 4
            elif recipe.cooktime > 120:
                temp = 5
            ingredient = dict()
            nutrition_totals = dict()

            # for nutr in Nutrition.query.all():
            #     nutrition_totals[nutr.id] = 0

            for detail in RecipeDetail.query.filter_by(recipe_id=recipe.id).all():
                ingredient_name = Ingredient.query.filter_by(id=detail.ingredients_id).first().name
                amount = detail.amount

                for nutr_detail in NutritionDetail.query.filter_by(ingredient_id=detail.ingredients_id).all():
                    nutr_id = Nutrition.query.filter_by(id=nutr_detail.nutrition_id).first().id

                    # nutrition_totals[nutr_id] += nutr_detail.amount * amount / 100
                    #ini kalau mau nampilin semua informasi nutrisi (termasuk yang 0 nutrisinya). Aktifin sama comment diatas yang nutr in Nutrition.query.all()

                    nutrition_totals[nutr_id] = nutrition_totals.get(nutr_id, 0) + nutr_detail.amount * amount / 100

                ingredient[detail.ingredients_id] = {
                    'name': ingredient_name,
                    'amount': amount,
                    'unit': detail.unit,
                }
                

            nutrition_list = dict()
            for nutr_id in nutrition_totals :
                nutrition = Nutrition.query.filter_by(id=nutr_id).first()
                nutrition_list[nutr_id] = {
                    'name': nutrition.name, 
                    'amount': nutrition_totals[nutr_id],
                    'unit': nutrition.unit
                    }

            response[recipe.id] = {
                'name': recipe.name,
                'steps': recipe.steps,
                'cooktime': recipe.cooktime,
                'portions': recipe.portions,
                'difficulty' : difficult[temp],
                'image': url_for('main.view_image', filename=recipe.image, _external=True),
                'ingredients': ingredient,
                'nutrition_list': nutrition_list
            }

        return {
            'data': response
        }, 200



#FIND RECIPE BY ID
@api.route('/find_recipe_id/<int:id1>')
class FindRecipeId(Resource):
    def get(self, id1):
        if not id1:
            return {'message': 'Please input recipe id!'}, 404

        recipe = Recipe.query.filter_by(id=id1).first()

        if not recipe:
            return {'message': f'There are no recipes with id "{id1}" found!'}, 404
        temp = 1
        if recipe.cooktime > 30 and recipe.cooktime <= 45:
            temp = 2
        elif recipe.cooktime > 45 and recipe.cooktime <= 90:
            temp = 3
        elif recipe.cooktime > 90 and recipe.cooktime <= 120:
            temp = 4
        elif recipe.cooktime > 120:
            temp = 5
        difficult = ['easy', 'medium', 'hard', 'expert', 'nightmare']
        response = dict()
        ingredient = dict()
        nutrition_totals = dict()

        for detail in RecipeDetail.query.filter_by(recipe_id=recipe.id).all():
            ingredient_name = Ingredient.query.filter_by(id=detail.ingredients_id).first().name
            amount = detail.amount

            for nutr_detail in NutritionDetail.query.filter_by(ingredient_id=detail.ingredients_id).all():
                nutr_id = Nutrition.query.filter_by(id=nutr_detail.nutrition_id).first().id

                # nutrition_totals[nutr_id] += nutr_detail.amount * amount / 100
                #ini kalau mau nampilin semua informasi nutrisi (termasuk yang 0 nutrisinya). Aktifin sama comment diatas yang nutr in Nutrition.query.all()

                nutrition_totals[nutr_id] = nutrition_totals.get(nutr_id, 0) + nutr_detail.amount * amount / 100

            ingredient[detail.ingredients_id] = {
                'name': ingredient_name,
                'amount': amount,
                'image': url_for('main.view_image', filename=Ingredient.query.filter_by(id=detail.ingredients_id).first().image, _external=True),
                'unit': detail.unit,
                'id': detail.ingredients_id,
            }

        nutrition_list = dict()
        for nutr_id in nutrition_totals :
            nutrition = Nutrition.query.filter_by(id=nutr_id).first()
            nutrition_list[nutr_id] = {
                'name': nutrition.name, 
                'amount': nutrition_totals[nutr_id],
                'unit': nutrition.unit,
                'id': nutrition.id,
                }

        response = {
            'id': recipe.id,
            'name': recipe.name,
            'steps': recipe.steps,
            'cooktime': recipe.cooktime,
            'portions': recipe.portions,
            'difficulty' : difficult[temp],
            'image': url_for('main.view_image', filename=recipe.image, _external=True),
            'ingredients': ingredient,
            'nutrition_list': nutrition_list
        }

        return {
            'data': response
        }, 200

    
#FIND RECIPE BY INGREDIENT
@api.route('/find_recipe_ingredient/<string:ingredient1>')
class FindRecipeIngredient(Resource):
    def get(self, ingredient1):
        if not ingredient1:
            return {'message': 'Please input ingredient!'}, 404
    
        ingredient = Ingredient.query.filter(Ingredient.name.ilike(f"%{ingredient1}%")).first()
        total_calory = 0
        if not ingredient:
            return {'message': f'There are no ingredients with name "{ingredient1}" found!'}, 404

        response = dict()
        recipeDetails = RecipeDetail.query.filter_by(ingredients_id=ingredient.id).all()

        for detail in recipeDetails:
            recipe = Recipe.query.filter_by(id=detail.recipe_id).first()
            difficult = ['easy', 'medium', 'hard', 'expert', 'nightmare']
            temp = 1
            if recipe.cooktime > 30 and recipe.cooktime <= 45:
                temp = 2
            elif recipe.cooktime > 45 and recipe.cooktime <= 90:
                temp = 3
            elif recipe.cooktime > 90 and recipe.cooktime <= 120:
                temp = 4
            elif recipe.cooktime > 120:
                temp = 5
            
            all_recipe_detail = RecipeDetail.query.filter_by(recipe_id=recipe.id).all()
            for detail in all_recipe_detail:
                omg = NutritionDetail.query.filter_by(ingredient_id=detail.ingredients_id).all()
                for nutr_detail in omg:
                    # print(nutr_detail.id)
                    nutr = Nutrition.query.filter_by(id=nutr_detail.nutrition_id).first()
                    if nutr.name.lower() != 'kalori':
                        continue
                    if nutr.unit == 'kcal':
                        print(nutr.name)
                        total_calory += detail.turn_to_hundred_gram * nutr_detail.amount * detail.amount * 100
                        continue
                    if nutr.unit == 'cal':
                        print(nutr.name, detail.turn_to_hundred_gram, nutr_detail.amount, detail.amount)
                        total_calory += detail.turn_to_hundred_gram * nutr_detail.amount * detail.amount
                        continue
                    

            for nutr_detail in NutritionDetail.query.filter_by(ingredient_id=ingredient.id).all():
                nutr_name = Nutrition.query.filter_by(id=nutr_detail.nutrition_id).first().name
            response[detail.recipe_id] = {
                'recipe_id': recipe.id,
                'recipe_name': recipe.name,
                'cooktime': recipe.cooktime,
                'steps': len(recipe.steps.split('\n')),
                'portions': recipe.portions,
                'difficulty': difficult[temp], 
                'image': url_for('main.view_image', filename=recipe.image, _external=True),
                'amount': detail.amount,
                'unit': detail.unit,
                'total_calory': total_calory
            }

        return {
            'data': response
        }, 200

# INI UNTUK BAGIAN YANG KAITAN AMA USER GA NGERTI< TAPI KURLEB GINI, SOALNYA MAIN JWT, GW GA NGERTI
#ADD TO FAVORITE RECIPE
@api.route('/add_favorite_recipe/<int:id1>')
class AddFavoriteRecipe(Resource):
    @jwt_required()
    @api.expect(authorization_header)
    def post(self, id1):
        current_user = get_jwt_identity()
        user = User.query.filter_by(username = current_user).first()
        recipe = Recipe.query.filter_by(id = id1).first()
        if not recipe:
            return {'message': f'There are no recipes with id "{id1}" found!'}, 404
        favorite = FavoriteRecipe.query.filter_by(user_id = user.id, recipe_id = recipe.id).first()
        if favorite:
            return {'message': f'You already added this recipe to favorite!'}, 404
        favorite = FavoriteRecipe(user_id = user.id, recipe_id = recipe.id)
        db.session.add(favorite)
        db.session.commit()
        return {'message': f'You added {recipe.name} to favorite!'}, 200

#REMOVE FROM FAVORITE RECIPES
@api.route("/remove_from_favourites/<int:id1>")
class RemoveFromFavourites(Resource):
    @jwt_required()
    @api.expect(authorization_header)

    def delete(self, id1):
        current_user = get_jwt_identity()
        user = User.query.filter_by(id = current_user).first()
        recipe = Recipe.query.filter_by(id = id1).first()
        if not recipe:
            return {'message': f'There are no recipes with id "{id1}" found!'}, 404
        favorite = FavoriteRecipe.query.filter_by(user_id = user.id, recipe_id = recipe.id).first()
        if not favorite:
            return {'message': f'You have not added this recipe to favorite!'}, 404

        favorite.delete()

        db.session.delete(favorite)
        db.session.commit()

        return {'message': f'You removed {recipe.name} from favorite!'}, 200

#SHOW USER FAVORITE RECIPE
@api.route('/show_favorite_recipe')
class ShowFavoriteRecipe(Resource):
    
    @jwt_required()
    @api.expect(authorization_header)
    def get(self):
        current_user = get_jwt_identity()
        user = User.query.filter_by(id=current_user).first()
        if not user:
            return {'message': f'There are no user with id "{current_user}" found!'}, 404
        response = dict({})
        fav = dict({})
        favorite_recipes = FavoriteRecipe.query.filter_by(user_id = user.id).all()
        
        for favorite_recipe in favorite_recipes:
            recipe = Recipe.query.filter_by(id = favorite_recipe.recipe_id).first()
            fav[recipe.id] = {
                'name' : recipe.name,
                'steps' : recipe.steps,
                'cooktime' : recipe.cooktime,
                'portions' : recipe.portions,
                'image' : url_for('main.view_image', filename=recipe.image, _external=True)
            }
            
        response['user'] = user.username
        response['favorite_recipes'] = fav
        
        return response, 200
