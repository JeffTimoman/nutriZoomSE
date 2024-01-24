from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_jwt_extended import JWTManager
from webdata.config import Config

config = Config()
app = Flask(__name__)
app.config['SECRET_KEY'] = config.SECRET_KEY
app.config['SQLALCHEMY_DATABASE_URI'] = config.DB_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = config.SECRET_KEY

db = SQLAlchemy(app)
migrate = Migrate(app, db)
jwt = JWTManager(app)

from webdata.authentication.routes import authenticator

app.register_blueprint(authenticator, url_prefix='/auth')