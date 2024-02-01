from datetime import timedelta

from flask import Flask, request
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_jwt_extended import JWTManager 
from flask_bcrypt import Bcrypt
from flask_cors import CORS

from webdata.config import Config

config = Config()
app = Flask(__name__)
app.config['SECRET_KEY'] = config.SECRET_KEY
app.config['SQLALCHEMY_DATABASE_URI'] = config.DB_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = config.SECRET_KEY
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(hours=config.ACCESS_TOKEN_DURATION)
app.config["JWT_REFRESH_TOKEN_EXPIRES"] = timedelta(days=config.REFRESH_TOKEN_DURATION)

db = SQLAlchemy(app)
migrate = Migrate(app, db)
jwt = JWTManager(app)
bcrypt = Bcrypt(app)

from webdata.authentication.routes import authenticator
from webdata.admin.routes import admin
app.register_blueprint(authenticator, url_prefix='/auth')
app.register_blueprint(admin, url_prefix='/admin')