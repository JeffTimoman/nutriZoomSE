from flask import request, jsonify, Blueprint
from flask_restx import Api, Resource, fields, reqparse
from datetime import timedelta, datetime

from webdata.models import User 
from webdata import jwt, bcrypt
from flask_jwt_extended import create_access_token, create_refresh_token
from flask_jwt_extended import get_jwt_identity, get_jwt
from flask_jwt_extended import jwt_required
from flask_cors import CORS

from webdata import db

import redis
import re
from flask import request
from flask_restx import Resource
from flask_jwt_extended import jwt_required, get_jwt_identity
from werkzeug.security import generate_password_hash, check_password_hash

#Setup block token
# jwt_redis_blocklist = redis.StrictRedis(
#     host="127.0.0.1", port=6379, db=0, decode_responses=True
# )

# @jwt.token_in_blocklist_loader
# def check_if_token_is_revoked(jwt_header, jwt_payload: dict):
#     jti = jwt_payload["jti"]
#     token_in_redis = jwt_redis_blocklist.get(jti)
#     return token_in_redis is not None

authenticator = Blueprint('authenticator', __name__)
api = Api(authenticator, doc='/docs')

cors = CORS(authenticator, resources={r"/auth/*": {"origins": "*"}})
login = api.model('Login', {
    'email': fields.String,
    'password': fields.String
})

register = api.model('Register', {
    'name': fields.String,
    'email': fields.String,
    'password': fields.String,
    'username': fields.String,
    'birth': fields.Date
})



authorization_header = reqparse.RequestParser()
authorization_header.add_argument('Authorization', location='headers', required=True, help='Bearer <access_token>')

change_password = reqparse.RequestParser()
change_password.add_argument('Authorization', location='headers', required=True, help='Bearer <access_token>')
change_password.add_argument('old_password', location='json', required=True, help='Old password')
change_password.add_argument('password', location='json', required=True, help='New password')

update_user_data = reqparse.RequestParser()
update_user_data.add_argument('Authorization', location='headers', required=True, help='Bearer <access_token>')
update_user_data.add_argument('name', location='json', required=False, help='New name')
update_user_data.add_argument('email', location='json', required=False, help='New email')
update_user_data.add_argument('username', location='json', required=False, help='New username')
update_user_data.add_argument('birth', location='json', required=False, help='New birth')


login_model = api.model('Login', {
    'email': fields.String(required=True, description='User email address'),
    'password': fields.String(required=True, description='User password')
})
@api.route('/login')
class Login(Resource):
    @api.expect(login_model)
    def post(self):
        data = request.get_json()
        email = data['email']
        password = data['password']
        user = User.query.filter_by(email=email).first()
        if user:
            if bcrypt.check_password_hash(user.password, password):
                access_token = create_access_token(identity=user.id)
                refresh_token = create_refresh_token(identity=user.id)
                return {'access_token': access_token, 'refresh_token': refresh_token}, 200
            else:
                return {'message': 'User not found or invalid credentials'}, 401
        else:
            return {'message': 'User not found or invalid credentials'}, 401


@api.route('/protected')
class ProtectedResource(Resource):
    @api.expect(authorization_header, validate=True)
    @jwt_required()
    
    def get(self):
        user_id = get_jwt_identity()
        user = User.query.filter_by(id=user_id).first()
        return {'message': f'Hello {user.name}'}, 200
    
@api.route('/refresh')
class RefreshToken(Resource):
    @api.expect(authorization_header, validate=True)
    @jwt_required(refresh=True)
    def post(self):
        user_id = get_jwt_identity()
        access_token = create_access_token(identity=user_id)
        return {'access_token': access_token}, 200
    
@api.route('/logout')
class Logout(Resource):
    @api.expect(authorization_header, validate=True)
    
    @jwt_required()
    def post(self):
        # jti = get_jwt()["jti"]
        # jwt_redis_blocklist.set(jti, "", ex=timedelta(hours=1))

        return {'message': 'Access token revoked succesfully.'}, 200
    
@api.route('/register')
class Register(Resource):
    @api.expect(register)
    def post(self):
        data = request.get_json()
        name = data['name']
        email = data['email']
        # validate email
        if not re.match(r"[^@]+@[^@]+\.[^@]+", email):
            return {'message': 'Invalid email format'}, 400
        
        if User.query.filter_by(email=email).first():
            return {'message': 'Email already registered'}, 400
        
        if User.query.filter_by(username=data['username']).first():
            return {'message': 'Username already taken'}, 400
        
        password = data['password']
        username = data['username']
        birth = data['birth']
        print(birth)
        user = User(name=name, email=email, password=bcrypt.generate_password_hash(password).decode('utf-8'), username=username, birth=birth)
        db.session.add(user)
        db.session.commit()
        
        return {'message': 'User created successfully'}, 201
    
@api.route('/get_user_data')
class GetUserData(Resource):
    @api.expect(authorization_header, validate=True)
    @jwt_required()
    def get(self):
        user_id = get_jwt_identity()
        user = User.query.filter_by(id=user_id).first()
        return {
            'name': user.name,
            'email': user.email,
            'username': user.username,
            'birth': datetime.strftime(user.birth, '%Y-%m-%d')
        }, 200
        
@api.route('/update_user_data')
class UpdateUserData(Resource):
    @api.expect(update_user_data)
    @jwt_required()
    def post(self):
        user_id = get_jwt_identity()
        user = User.query.filter_by(id=user_id).first()
        data = request.get_json()
        name = data['name']
        email = data['email']
        username = data['username']
        birth = data['birth']
        
        if re.match(r"[^@]+@[^@]+\.[^@]+", email) == None and email != '' and email != None:
            return {'message': 'Invalid email format'}, 400
        
        if User.query.filter_by(email=email).first() and email != user.email and email != '' and email != None:
            return {'message': 'Failed to change email.'}, 400
        
        if User.query.filter_by(username=username).first() and username != user.username and username != '' and username != None:
            return {'message': 'Failed to change username.'}, 400
        
        if username != '':
            user.username = username
        
        if email != '':
            user.email = email
        
        if name != '':
            user.name = name
        
        if birth != '':
            user.birth = birth
            
        print(username, email, name, birth)
        
        db.session.commit()
        return {'message': 'User data updated successfully'}, 200
    
@api.route('/change_password')
class UpdatePassword(Resource):
    
    @api.expect(change_password)
    @jwt_required()
    def post(self):
        user_id = get_jwt_identity()
        user = User.query.filter_by(id=user_id).first()
        data = request.get_json()
        old_password = data['old_password']
        new_password = data['password']
        
        if not bcrypt.check_password_hash(user.password, old_password):
            return {'message': 'Failed to change password.'}, 400
        
        user.password = bcrypt.generate_password_hash(new_password).decode('utf-8')
        db.session.commit()
        return {'message': 'Password updated successfully'}, 200
    
@api.route('/is_logged')
class IsLogged(Resource):
    @api.expect(authorization_header, validate=True)
    @jwt_required()
    def get(self):
        return {'message': 'User is logged in'}, 200