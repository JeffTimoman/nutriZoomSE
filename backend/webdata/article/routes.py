from flask import request, jsonify, Blueprint
from flask_restx import Api, Resource, fields, reqparse

from webdata.models import User, Article
from webdata import jwt, bcrypt
from flask_jwt_extended import create_access_token, create_refresh_token
from flask_jwt_extended import get_jwt_identity
from flask_jwt_extended import jwt_required
from flask_cors import CORS
from flask import request



article = Blueprint('article', __name__)
api = Api(article, doc = '/docs')

authorization_header = reqparse.RequestParser()
authorization_header.add_argument('Authorization', location='headers',  required=True, help='Bearer <access_token>')

@api.route('/get_articles')
@api.route('/get_articles?page=<int:page>')
class GetArticles(Resource):
    # @api.expect(authorization_header, validate=True)
    # @jwt_required()
    def get(self):
        page = request.args.get('page', default=1, type=int)
        per_page = request.args.get('per_page', default=10, type=int)

        articles = Article.query.paginate(page=page, per_page=per_page)
        response = dict()

        for article in articles.items:
            response[article.id] = {
                'title': article.title,
                'content': article.detail,
                'author': article.author
            }
        
        return {
            'data': response,
            'total_pages': articles.pages,
            'current_page': articles.page,
            'per_page': articles.per_page,
            'total_items': articles.total
        }, 200

@api.route('/show_article/<int:id>')
class ShowArticle(Resource):
    #ini unutk jwt 
    def get(self, id):
        article = Article.query.get(id)
        if not article:
            return {'message': 'Article not found!'}, 404

        return {
            'title': article.title,
            'content': article.detail,
            'author': article.author,
            'publishdate': article.formatted_tanggal_terbit,
            'createdby': article.created_by_username
        }, 200