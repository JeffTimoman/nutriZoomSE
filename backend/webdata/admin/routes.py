from flask import Blueprint, render_template, request, flash, redirect, url_for, jsonify

from webdata import db, jwt, bcrypt, config
from webdata.models import User, Article, Nutrition, Ingredient, NutritionDetail

from datetime import datetime

from flask_login import login_user, current_user, logout_user, login_required

import json
import os
import uuid

admin = Blueprint('admin', __name__)

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in config.ALLOWED_EXTENSIONS

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
    flash('This feature is currently disabled.', 'info')
    return redirect(url_for('admin.users'))
    user_id = request.form.get('id')
    user = User.query.filter_by(id=user_id).first()
    
    if not user:
        flash('User not found', 'danger')
        return redirect(url_for('admin.users'))
    
    db.session.delete(user)
    db.session.commit()
    
    flash('User has been deleted', 'success')
    return redirect(url_for('admin.users'))

@admin.route('/articles')
def articles():
    articles = Article.query.all()
    return render_template('admin/articles.html', articles=articles)

@admin.route('/add_article', methods=['GET', 'POST'])
def add_article():
    if request.method == 'POST':
        title = request.form.get('title')
        detail = request.form.get('detail')
        author = request.form.get('author')
        date = request.form.get('date')
        time = request.form.get('time')
        if time == '':
            time = datetime.now().strftime('%H:%M:%S')
        if date == '':
            date = datetime.now().strftime('%Y-%m-%d')
        
        date = f"{date} {time}"
            
        article = Article(title=title, detail=detail, author=author, publishdate=date, created_by=current_user.id)
        
        db.session.add(article)
        db.session.commit()
        flash('Article has been added', 'success')
        return redirect(url_for('admin.add_article'))
    return render_template('admin/add_article.html')

@admin.route('/edit_article/<int:id>', methods=['GET', 'POST'])
def edit_article(id):
    
    if request.method == 'POST':
        
        article = Article.query.filter_by(id=id).first()  
        
        if not article:
            flash('Article not found', 'danger')
            return redirect(url_for('admin.articles'))
        
        title = request.form.get('title')
        detail = request.form.get('detail')
        author = request.form.get('author')
        date = request.form.get('date')
        time = request.form.get('time')
        if time == '':
            time = datetime.now().strftime('%H:%M:%S')
        
        if date == '':
            date = datetime.now().strftime('%Y-%m-%d')
        
        date = f"{date} {time}"
      

        
        article.title = title
        article.detail = detail
        article.author = author
        article.publishdate = date
        
        db.session.commit()
        flash('Article has been updated', 'success')
        return redirect(url_for('admin.edit_article', id=id))
    
    article = Article.query.filter_by(id=id).first()
    
    if not article:
        flash('Article not found', 'danger')
        return redirect(url_for('admin.articles'))
    
    return render_template('admin/edit_article.html', article=article)


@admin.route('/delete_article', methods=['POST'])
def delete_article():
    
    article_id = request.form.get('id')
    article = Article.query.filter_by(id=article_id).first()
    
    if not article:
        flash('Article not found', 'danger')
        return redirect(url_for('admin.articles'))
    
    db.session.delete(article)
    db.session.commit()
    
    flash('Article has been deleted', 'success')
    return redirect(url_for('admin.articles'))

@admin.route('/nutritions')
def nutritions():
    nutritions = Nutrition.query.all()
    return render_template('admin/nutritions.html', nutritions=nutritions)

@admin.route('/add_nutrition', methods=['GET', 'POST'])
def add_nutrition():
    if request.method == 'POST':
        name = request.form.get('name')
        description = request.form.get('description')
        
        nutrition = Nutrition(name=name, description=description)
        
        db.session.add(nutrition)
        db.session.commit()
        
        flash('Nutrition has been added', 'success')
        return redirect(url_for('admin.add_nutrition'))
    return render_template('admin/add_nutrition.html')

@admin.route('/edit_nutrition/<int:id>', methods=['GET', 'POST'])
def edit_nutrition(id):
    
    if request.method == 'POST':
        
        nutrition = Nutrition.query.filter_by(id=id).first()  
        
        if not nutrition:
            flash('Nutrition not found', 'danger')
            return redirect(url_for('admin.nutritions'))
        
        name = request.form.get('name')
        description = request.form.get('description')
        
        if nutrition.name == name and nutrition.description == description:
            flash('No changes has been made', 'info')
            return redirect(url_for('admin.edit_nutrition', id=id))
        
        nutrition.name = name
        nutrition.description = description
        
        db.session.commit()
        flash('Nutrition has been updated', 'success')
        return redirect(url_for('admin.edit_nutrition', id=id))
    
    nutrition = Nutrition.query.filter_by(id=id).first()
    
    if not nutrition:
        flash('Nutrition not found.', 'danger')
        return redirect(url_for('admin.nutritions'))
    
    return render_template('admin/edit_nutrition.html', nutrition=nutrition)

@admin.route('/delete_nutrition', methods=['POST'])
def delete_nutrition():
    nutrition_id = request.form.get('id')
    nutrition = Nutrition.query.filter_by(id=nutrition_id).first()
    
    if not nutrition:
        flash('Nutrition not found', 'danger')
        return redirect(url_for('admin.nutritions'))
    
    if nutrition.used_by_length > 0:
        flash('Nutrition is currently used by some ingredients', 'danger')
        return redirect(url_for('admin.nutritions'))
    
    db.session.delete(nutrition)
    db.session.commit()
    
    flash('Nutrition has been deleted', 'success')
    return redirect(url_for('admin.nutritions'))

@admin.route('/ingredients')
def ingredients():
    ingredients = Ingredient.query.all()
    return render_template('admin/ingredients.html', ingredients=ingredients)

@admin.route('/add_ingredient', methods=['GET', 'POST'])
def add_ingredient():
    
    if request.method == "POST":
        data = request.form
        print(data)
        name = request.form.get('name')
        description = request.form.get('description')
        nutritions = json.loads(request.form.get('nutritions'))
        
        if 'image' not in request.files:
            flash('No file part', 'danger')
            return redirect(url_for('admin.add_ingredient'))
        
        file = request.files['image']
        
        if file.filename == '':
            flash('No selected file', 'danger')
            return redirect(url_for('admin.add_ingredient'))
        
        if not allowed_file(file.filename):
            flash('Invalid file type', 'danger')
            return redirect(url_for('admin.add_ingredient'))
            
        
        if name == '' or description == '':
            flash('Name and description cannot be empty', 'danger')
            return redirect(url_for('admin.add_ingredient'))
        
        
        print(name, description)
        check = Ingredient.query.filter_by(name=name).first()
        
        if check:
            flash('Ingredient already exists', 'danger')
            return redirect(url_for('admin.add_ingredient'))
        
        filename = str(uuid.uuid4()) + '.' + file.filename.rsplit('.', 1)[1].lower()
        file.save(os.path.join(config.UPLOAD_FOLDER, filename))
        # resize image to 500x500
        
        from PIL import Image

        image = Image.open(os.path.join(config.UPLOAD_FOLDER, filename))
        width, height = image.size

        if width > height:
            left = (width - height) // 2
            right = left + height
            top = 0
            bottom = height
        else:
            top = (height - width) // 2
            bottom = top + width
            left = 0
            right = width

        image = image.crop((left, top, right, bottom))
        image = image.resize((500, 500))
        image.save(os.path.join(config.UPLOAD_FOLDER, filename))
        
        
        ingredient = Ingredient(name=name, description=description, image=filename)
        db.session.add(ingredient)
        db.session.commit()
        
        nutrition_key = list(nutritions.keys())
        print(nutritions, nutrition_key)
        
        for key in nutrition_key:
            temp = NutritionDetail(nutrition_id=int(key), ingredient_id=ingredient.id, amount=int(nutritions[key]))
            print(temp.info)
            db.session.add(temp)
            db.session.commit()
        
        flash('Ingredient has been added', 'success')
        return redirect(url_for('admin.add_ingredient'))

    nutritions = Nutrition.query.all()
    return render_template('admin/add_ingredient.html', nutritions=nutritions)




@admin.route('/delete_ingredient', methods=['POST'])
def delete_ingredient():
    ingredient_id = request.form.get('id')
    ingredient = Ingredient.query.filter_by(id=ingredient_id).first()
    
    if not ingredient:
        flash('Ingredient not found', 'danger')
        return redirect(url_for('admin.ingredients'))
    
    if ingredient.used_by_length > 0:
        flash('Ingredient is currently used by some recipes', 'danger')
        return redirect(url_for('admin.ingredients'))
    
    # delete the image file
    os.remove(os.path.join(config.UPLOAD_FOLDER, ingredient.image))
    
    db.session.delete(ingredient)
    db.session.commit()
    
    flash('Ingredient has been deleted', 'success')
    return redirect(url_for('admin.ingredients'))




@admin.route('/view_image/<text>')
def view_image(text):
    return redirect(url_for('static', filename=f'uploaded_images/{text}'), code=301)