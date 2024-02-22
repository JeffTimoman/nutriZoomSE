from flask import Blueprint, request, jsonify, url_for, redirect

from webdata import app
from flask import url_for, redirect, request

main = Blueprint('main', __name__)

@main.route('/view_image')
@main.route('/view_image/<filename>')
def view_image(filename="default.jpg"):
    return redirect(url_for('static', filename=f'{app.config["FOLDER_UPLOAD_NAME"]}/{filename}'), code=301)

@main.route('/')
def index():
    return redirect(url_for('admin.login'))