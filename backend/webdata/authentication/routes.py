from flask import request, jsonify, Blueprint
from flask_restx import Api, Resource, fields, reqparse

from webdata.models import User 
from webdata import jwt, bcrypt
from flask_jwt_extended import create_access_token, create_refresh_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_cors import CORS


authenticator = Blueprint('authenticator', __name__)
api = Api(authenticator, doc='/docs')

cors = CORS(authenticator, resources={r"/auth/*": {"origins": "*"}})
login = api.model('Login', {
    'email': fields.String,
    'password': fields.String
})

authorization_header = reqparse.RequestParser()
authorization_header.add_argument('Authorization', location='headers', required=True, help='Bearer <access_token>')


@api.route('/login')
class Login(Resource):
    @api.expect(login)
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
        return {'message': 'Successfully logged out'}, 200