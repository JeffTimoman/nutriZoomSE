from flask import request, jsonify, Blueprint
from flask_restx import Api, Resource, fields

from webdata.models import User
from webdata import jwt, bcrypt
from flask_jwt_extended import create_access_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_cors import CORS

authenticator = Blueprint('authenticator', __name__)
api = Api(authenticator, doc='/docs')

cors = CORS(authenticator, resources={r"/auth/*": {"origins": "*"}})

user = api.model('User', {
    'name': fields.String,
    'email': fields.String,
    'password': fields.String
})

login = api.model('Login', {
    'email': fields.String,
    'password': fields.String
})

logout = api.model('Logout', {  
    'headers': {
      'Authorization': "Bearer <access_token>",
    }
})

protected_test = api.model('ProtectedTest', {
    'headers': {
        'Authorization': fields.String(description='Bearer token', required=True),
    }
})
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
                return {'access_token': access_token}, 200
            else:
                return {'message': 'User not found or invalid credentials'}, 401
        else:
            return {'message': 'User not found or invalid credentials'}, 401
        
@api.route('/logout')
class Logout(Resource):
    @api.expect(logout)
    @jwt_required()
    def post(self):
        return {'message': 'User logged out successfully'}, 200