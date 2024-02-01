from flask import Blueprint, render_template, request, flash, redirect, url_for, jsonify

from webdata import db, jwt, bcrypt
from webdata.models import User

from flask_jwt_extended import create_access_token, create_refresh_token, get_jwt_identity, jwt_required, set_access_cookies, set_refresh_cookies, unset_jwt_cookies

admin = Blueprint('admin', __name__)

@admin.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')
        
        user = User.query.filter_by(email=email).first()
        
        if not user:
            flash('Invalid email or password', 'danger')
            return redirect(url_for('admin.login'))
        
        if not bcrypt.check_password_hash(user.password, password):
            flash('Invalid email or password', 'danger')
            return redirect(url_for('admin.login'))
        
        flash('You have successfully logged in', 'success')
        access_token = create_access_token(identity=user.id)
        response = jsonify({"msg": "login successful"})
        set_access_cookies(response, access_token)
        
        return redirect(url_for('admin.dashboard'))
        
    return render_template('admin/login.html')

@admin.route('/dashboard')
@jwt_required()
def dashboard():
    return "OKAY WORKING"
    # return render_template('admin/dashboard.html')