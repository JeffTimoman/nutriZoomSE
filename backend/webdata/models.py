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
    nutrition_id = db.Column(db.Integer, db.ForeignKey('nutritions.id'))
    name = db.Column(db.String(100))
    description = db.Column(db.String(200))


class Recipe(db.Model):
    __tablename__ = 'recipes'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    steps = db.Column(db.String(200))
    portions = db.Column(db.Integer)
    cooktime = db.Column(db.Integer)


class Nutrition(db.Model):
    __tablename__ = 'nutritions'
    id = db.Column(db.Integer, primary_key=True)
    nutritiondetail_id = db.Column(db.Integer, db.ForeignKey('nutritiondetails.id'))
    nama = db.Column(db.String(100), unique=True)


class NutritionDetail(db.Model):
    __tablename__ = 'nutritiondetails'
    id = db.Column(db.Integer, primary_key=True)
    nutritionamount = db.Column(db.Integer)


class RecipeDetail(db.Model):
    __tablename__ = 'recipedetails'
    id = db.Column(db.Integer, primary_key=True)
    recipe_id = db.Column(db.Integer, db.ForeignKey('recipes.id'))
    ingredients_id = db.Column(db.Integer, db.ForeignKey('ingredients.id'))
    ingredientamount = db.Column(db.Float)
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
        return self.publishdate.strftime("%d%m%Y")
    
    @property
    def created_by_username(self):
        return User.query.filter_by(id=self.created_by).first().username