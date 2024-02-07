from flask import request, jsonify, Blueprint
from flask_restx import Api, Resource, fields, reqparse

from webdata.models import User 
from webdata import jwt, bcrypt
from flask_jwt_extended import create_access_token, create_refresh_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_cors import CORS

article = Blueprint('article', __name__)
api = Api(article, doc = '/docs')