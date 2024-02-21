from flask import Blueprint, request, jsonify, url_for, redirect

from webdata import app

main = Blueprint('main', __name__)

@main.route('/view_image/<filename>')
def view_image(filename):
    # return url_for('static', filename=f'{app.config["FOLDER_UPLOAD_NAME"]}/{filename}')
    return redirect(url_for('static', filename=f'{app.config["FOLDER_UPLOAD_NAME"]}/{filename}'), code=301)
@main.route('/')
def index():
    return redirect(url_for('admin.login'))