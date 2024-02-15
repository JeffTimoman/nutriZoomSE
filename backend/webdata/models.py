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
    image = db.Column(db.String(200))
    name = db.Column(db.String(100))
    steps = db.Column(db.String(300))
    favorite_count = db.Column(db.Integer)
    cooktime = db.Column(db.Integer)
    portion = db.Column(db.Float)


class Nutrition(db.Model):
    __tablename__ = 'nutritions'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True)
    description = db.Column(db.String(200))
    
    @property
    def used_by_length(self):
        return len(NutritionDetail.query.filter_by(nutrition_id=self.id).all())

class NutritionDetail(db.Model):
    __tablename__ = 'nutritiondetails'
    nutrition_id = db.Column(db.Integer, db.ForeignKey('nutritions.id'), primary_key=True)
    ingredient_id = db.Column(db.Integer, db.ForeignKey('ingredients.id'), primary_key=True)
    amount = db.Column(db.Integer) #per 100 gr

    @property
    def info(self):
        return f'<NutritionDetail: {self.nutrition_id} - {self.ingredient_id}>'

class RecipeDetail(db.Model):
    __tablename__ = 'recipedetails'
    id = db.Column(db.Integer, primary_key=True)
    recipe_id = db.Column(db.Integer, db.ForeignKey('recipes.id'))
    ingredients_id = db.Column(db.Integer, db.ForeignKey('ingredients.id'))
    amount = db.Column(db.Float)
    unit = db.Column(db.String(50))


class Article(db.Model):
    __tablename__ = 'article'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(150), unique=True)
    detail = db.Column(db.String(1000))
    author = db.Column(db.String(100))
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