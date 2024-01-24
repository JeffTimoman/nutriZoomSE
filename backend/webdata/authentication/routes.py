from flask import request, jsonify, Blueprint

from webdata.models import User
from flask_restx import Api, Resource, fields
from webdata import jwt

authenticator = Blueprint('authenticator', __name__)
api = Api(authenticator, doc='/docs')

user = api.model('User', {
    'name': fields.String,
    'email': fields.String,
    'password': fields.String
})

login = api.model('Login', {
    'email': fields.String,
    'password': fields.String
})

@api.route('/login')
class Login(Resource):
    @api.expect(login)
    def post(self):
        data = request.get_json()
        email = data.get('email')
        password = data.get('password')
        user = User.query.filter_by(email=email).first()
        if user and user.password == password:
            token = jwt.create_access_token(identity=user.id)
            return jsonify({'token': token})
        else:
            return jsonify({'message': 'Invalid credentials'}), 401
        
@api.route('/register')
class Register(Resource):
    @api.expect(user)
    def post(self):
        data = request.get_json()
        user = User(**data)
        user.save()
        return jsonify({'message': 'User created successfully'}), 201

