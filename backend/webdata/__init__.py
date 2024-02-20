from datetime import timedelta

from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_jwt_extended import JWTManager 
from flask_bcrypt import Bcrypt
from flask_cors import CORS
from flask_login import LoginManager

from webdata.config import Config

config = Config()
app = Flask(__name__)
app.config['SECRET_KEY'] = config.SECRET_KEY
app.config['SQLALCHEMY_DATABASE_URI'] = config.DB_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = config.SECRET_KEY
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(hours=config.ACCESS_TOKEN_DURATION)
app.config["JWT_REFRESH_TOKEN_EXPIRES"] = timedelta(days=config.REFRESH_TOKEN_DURATION)

app.config['UPLOAD_FOLDER'] = config.UPLOAD_FOLDER
app.config['FOLDER_UPLOAD_NAME'] = config.FOLDER_UPLOAD_NAME

db = SQLAlchemy(app)
migrate = Migrate(app, db)
jwt = JWTManager(app)
bcrypt = Bcrypt(app)
auth = LoginManager(app)
auth.login_view = 'admin.login'
auth.login_message_category = 'info'
auth.login_message = 'Please log in to access this page.'

from webdata.authentication.routes import authenticator
from webdata.admin.routes import admin
from webdata.article.routes import article
from webdata.nutrition.routes import nutrition
from webdata.ingredient.routes import ingredient
from webdata.recipe.routes import recipe
from webdata.main.routes import main
app.register_blueprint(authenticator, url_prefix='/api/auth')
app.register_blueprint(admin, url_prefix='/admin')
app.register_blueprint(article, url_prefix='/api/article')
app.register_blueprint(nutrition, url_prefix='/api/nutrition')
app.register_blueprint(ingredient, url_prefix='/api/ingredient')
app.register_blueprint(recipe, url_prefix='/api/recipe')
app.register_blueprint(main, url_prefix='')