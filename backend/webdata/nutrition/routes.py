from flask import request, jsonify, Blueprint
from flask_restx import Api, Resource, fields, reqparse

from webdata.models import User, Nutrition
from webdata import jwt, bcrypt
from flask_jwt_extended import create_access_token, create_refresh_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_cors import CORS
from flask import request



nutrition = Blueprint('nutrition', __name__)
api = Api(nutrition, doc = '/docs')

authorization_header = reqparse.RequestParser()
authorization_header.add_argument('Authorization', location='headers',  required=True, help='Bearer <access_token>')

@api.route('/get_nutrition')
@api.route('/get_nutrititon?page=<int:page>')
class GetNutrition(Resource):
    # @api.expect(authorization_header, validate=True)
    # @jwt_required()
    def get(self):
        page = request.args.get('page', default=1, type=int)
        per_page = request.args.get('per_page', default=5, type=int)
        
        nutritions = Nutrition.query.paginate(page=page, per_page=per_page)
        response = dict()

        for nutrition in nutritions.items:
            response[nutrition.id]={
                'name' : nutrition.name,
                'description' : nutrition.description,
                'id' : nutrition.id
            }

        return {
            'data': response,
            'total_pages': nutritions.pages,
            'current_page': page,
            'per_page': per_page,
            'total_items': nutritions.total
        }, 200

