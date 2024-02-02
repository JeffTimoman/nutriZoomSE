from flask import Blueprint, render_template, request, flash, redirect, url_for, jsonify

from webdata import db, jwt, bcrypt
from webdata.models import User

from flask_login import login_user, current_user, logout_user, login_required

admin = Blueprint('admin', __name__)

@admin.route('/', methods=['GET', 'POST'])
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
        login_user(user)
        
        return redirect(url_for('admin.dashboard'))
        
    return render_template('admin/login.html')

@admin.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('admin.login'))

@admin.route('/dashboard')
@login_required
def dashboard():
    return render_template('admin/dashboard.html')

@admin.route('/users')
@login_required
def users():
    users = User.query.all()
    return render_template('admin/users.html', users=users)
    
@admin.route('/users/add_user', methods=['GET', 'POST'])
@login_required
def add_user():
    if request.method == 'POST':
        email = request.form.get('email')
        username = request.form.get('username')
        password = request.form.get('password')
        name = request.form.get('name')
        birth = request.form.get('birth')
        
        print(birth)
        
        user = User.query.filter_by(email=email).first()
        if user:
            flash('Email already exists', 'danger')
            return redirect(url_for('admin.add_user'))
        
        user = User.query.filter_by(username=username).first()
        if user:
            flash('Username already exists', 'danger')
            return redirect(url_for('admin.add_user'))
        
        user = User(email=email, username=username, name=name, birth=birth, password=bcrypt.generate_password_hash(password).decode('utf-8'))
        
        db.session.add(user)
        db.session.commit()
        
        flash('User has been added', 'success')
        return redirect(url_for('admin.add_user'))
    return render_template('admin/add_user.html')

@admin.route('/edit_user', methods=['POST', 'GET'])
@login_required
def edit_user():
    user_id = request.form.get('id')
    user = User.query.filter_by(id=user_id).first()
    
    if not user:
        flash('User not found', 'danger')
        return redirect(url_for('admin.users'))
    
    name = request.form.get('name')
    email = request.form.get('email')
    username = request.form.get('username')
    birth = request.form.get('birth')
    
    if user.email == email and user.username == username and user.name == name and str(user.birth) == str(birth):
        flash('No changes has been made', 'info')
        return redirect(url_for('admin.users'))
    
    user.email = email
    user.username = username
    user.name = name
    user.birth = birth
    
    db.session.commit()
    flash('User has been updated', 'success')
    return redirect(url_for('admin.users'))

@admin.route("/reset_user_password", methods=["GET", "POST"])
def reset_user_password():
    if request.method == "POST":
        id = request.form.get("id")
        password = request.form.get("password")
        confirm = request.form.get("confirm")
        
        if password != confirm:
            flash("Password and Confirm Password does not match", "danger")
            return redirect(url_for("admin.users"))
        
        user = User.query.filter_by(id=id).first()
        user.password = bcrypt.generate_password_hash(password).decode("utf-8")
        
        db.session.commit()
        
        flash("Password has been reset succesfully.", "success")
        return redirect(url_for("admin.users"))
    flash("Invalid request", "danger")
    return redirect(url_for("admin.users"))

@admin.route('delete_user', methods=['POST'])
def delete_user():
    user_id = request.form.get('id')
    user = User.query.filter_by(id=user_id).first()
    
    if not user:
        flash('User not found', 'danger')
        return redirect(url_for('admin.users'))
    
    db.session.delete(user)
    db.session.commit()
    
    flash('User has been deleted', 'success')
    return redirect(url_for('admin.users'))