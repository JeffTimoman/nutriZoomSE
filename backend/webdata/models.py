from webdata import db, app, auth
from webdata import jwt
from flask_login import UserMixin
from datetime import datetime
from pytz import timezone
# Table List:
# - User
# - BahanMakanan
# - ResepMakanan
# - Nutrisi
# - DetailNutrisi
# - ResepMakananDetail
# - Artikel

@auth.user_loader
def load_user(id):
    return User.query.get(int(id))

class User(db.Model, UserMixin):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    password = db.Column(db.String(100))
    email = db.Column(db.String(100), unique=True)
    username = db.Column(db.String(100), unique=True)
    birth = db.Column(db.Date)
    is_admin = db.Column(db.Boolean, default=False)

    def __repr__(self):
        return f'<User: {self.name}>'


class FavoriteRecipe(db.Model):
    __tablename__ = 'favoriterecipe'
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), primary_key=True)
    recipe_id = db.Column(db.Integer, db.ForeignKey('recipes.id'), primary_key=True)


class Ingredient(db.Model):
    __tablename__ = 'ingredients'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True)
    description = db.Column(db.String(200))
    image = db.Column(db.String(200))
    
    @property
    def used_by_length(self):
        return len(RecipeDetail.query.filter_by(ingredients_id=self.id).all())
    
    @property
    def nutrition_length(self):
        return len(NutritionDetail.query.filter_by(ingredient_id=self.id).all())
    


# untuk resep:
# - image
# - name
# - favorites count
# - cooktime
# - portion
# - steps
# - steps count
    
# - ingredients picture
# - ingredients
# - ingredientcount

class Recipe(db.Model):
    __tablename__ = 'recipes'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    steps = db.Column(db.String(300))
    cooktime = db.Column(db.Integer)
    portions = db.Column(db.Float)
    image = db.Column(db.String(200))
    
    @property
    def favorited_by(self):
        return len(FavoriteRecipe.query.filter_by(recipe_id=self.id).all())
    
    @property
    def total_ingr(self):
        return len(RecipeDetail.query.filter_by(recipe_id=self.id).all())
    

class Nutrition(db.Model):
    __tablename__ = 'nutritions'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True)
    unit = db.Column(db.String(200), default="g")
    
    @property
    def used_by_length(self):
        return len(NutritionDetail.query.filter_by(nutrition_id=self.id).all())

class NutritionDetail(db.Model):
    __tablename__ = 'nutritiondetails'
    nutrition_id = db.Column(db.Integer, db.ForeignKey('nutritions.id'), primary_key=True)
    ingredient_id = db.Column(db.Integer, db.ForeignKey('ingredients.id', ondelete='CASCADE'), primary_key=True)
    amount = db.Column(db.Float) #per 100 gr

    @property
    def info(self):
        return f'<NutritionDetail: {self.nutrition_id} - {self.ingredient_id}>'
    
    @property
    def name(self):
        return Nutrition.query.filter_by(id=self.nutrition_id).first().name

    
class RecipeDetail(db.Model):
    __tablename__ = 'recipedetails'
    recipe_id = db.Column(db.Integer, db.ForeignKey('recipes.id', ondelete='CASCADE'), primary_key=True)
    ingredients_id = db.Column(db.Integer, db.ForeignKey('ingredients.id', ondelete='CASCADE'), primary_key=True)
    amount = db.Column(db.Float, default=0)
    unit = db.Column(db.String(50), default="g")
    
    @property
    def name(self):
        return Ingredient.query.filter_by(id=self.ingredients_id).first().name
    
    @property
    def turn_to_hundred_gram(self):
        options = {
            "g" : 1,
            "ml" : 1,
            "kg" : 1000,
            "l" : 1000,
            "tbsp": 15,
            "tsp": 5,
        }
        
        return self.amount * options[self.unit]
    
class Article(db.Model):
    __tablename__ = 'article'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(150), unique=True)
    detail = db.Column(db.String(1000))
    author = db.Column(db.String(100))
    image = db.Column(db.String(200))
    publishdate = db.Column(db.DateTime, default=datetime.now(timezone('Asia/Jakarta')))
    created_by = db.Column(db.Integer, db.ForeignKey("user.id"))

    @property
    def formatted_tanggal_terbit(self):
        return self.publishdate.strftime("%d-%m-%Y %H:%M")
    
    @property
    def created_by_username(self):
        temp = User.query.filter_by(id=self.created_by).first().username
        if temp : return temp
        else : return "N/A"