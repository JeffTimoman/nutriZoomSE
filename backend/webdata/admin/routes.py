from flask import Blueprint, render_template, request, flash, redirect, url_for, jsonify
from werkzeug.utils import secure_filename
from webdata import db, jwt, bcrypt, config, app
from webdata.models import User, Article, Nutrition, Ingredient, NutritionDetail, Recipe, RecipeDetail

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
@login_required
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
@login_required
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
@login_required
def articles():
    articles = Article.query.all()
    return render_template('admin/articles.html', articles=articles)

@admin.route('/add_article', methods=['GET', 'POST'])
@login_required
def add_article():
    if request.method == 'POST':
        title = request.form.get('title')
        detail = request.form.get('detail')
        author = request.form.get('author')
        date = request.form.get('date')
        time = request.form.get('time')
        filename = ""
        
        if 'image' not in request.files:
            flash('No image included.', 'danger')
            return redirect(url_for('admin.add_article'))
        
        if 'image' in request.files:
            file = request.files['image']
            if file.filename != '':
                if not allowed_file(file.filename):
                    flash('Invalid file type', 'danger')
                    return redirect(url_for('admin.add_article'))
                
                filename = secure_filename(str(uuid.uuid4()) + '.' + file.filename.rsplit('.', 1)[1].lower())
                file.save(os.path.join(config.UPLOAD_FOLDER, filename))

        
        
        
        if time == '':
            time = datetime.now().strftime('%H:%M:%S')
        
        if date == '':
            date = datetime.now().strftime('%Y-%m-%d')
        
        date = f"{date} {time}"
            
        article = Article(title=title, detail=detail, author=author, publishdate=date, created_by=current_user.id, image=filename)
        db.session.add(article)
        db.session.commit()
        flash('Article has been added', 'success')
        return redirect(url_for('admin.add_article'))
    return render_template('admin/add_article.html')

@admin.route('/edit_article/<int:id>', methods=['GET', 'POST'])
@login_required
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
        
        if 'image' in request.files:
            file = request.files['image']
            if file.filename != '':
                if not allowed_file(file.filename):
                    flash('Invalid file type', 'danger')
                    return redirect(url_for('admin.edit_article', id=id))
                
                filename = secure_filename(str(uuid.uuid4()) + '.' + file.filename.rsplit('.', 1)[1].lower())
                file.save(os.path.join(config.UPLOAD_FOLDER, filename))
                # delete old image
                if article.image:
                    try : 
                        os.remove(os.path.join(config.UPLOAD_FOLDER, article.image))
                    except Exception as e:
                        print(e)
                        pass
                article.image = filename
        
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
@login_required
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
@login_required
def nutritions():
    nutritions = Nutrition.query.all()
    return render_template('admin/nutritions.html', nutritions=nutritions)

@admin.route('/add_nutrition', methods=['GET', 'POST'])
@login_required
def add_nutrition():
    if request.method == 'POST':
        name = request.form.get('name')
        unit = request.form.get('unit')
        
        nutrition = Nutrition(name=name, unit=unit)
        
        db.session.add(nutrition)
        db.session.commit()
        
        flash('Nutrition has been added', 'success')
        return redirect(url_for('admin.add_nutrition'))
    return render_template('admin/add_nutrition.html')

@admin.route('/edit_nutrition/<int:id>', methods=['GET', 'POST'])
@login_required
def edit_nutrition(id):
    
    if request.method == 'POST':
        
        nutrition = Nutrition.query.filter_by(id=id).first()  
        
        if not nutrition:
            flash('Nutrition not found', 'danger')
            return redirect(url_for('admin.nutritions'))
        
        name = request.form.get('name')
        unit = request.form.get('unit')
        
        if nutrition.name == name and nutrition.unit == unit:
            flash('No changes has been made', 'info')
            return redirect(url_for('admin.edit_nutrition', id=id))
        
        nutrition.name = name
        nutrition.unit = unit
        
        db.session.commit()
        flash('Nutrition has been updated', 'success')
        return redirect(url_for('admin.edit_nutrition', id=id))
    
    nutrition = Nutrition.query.filter_by(id=id).first()
    
    if not nutrition:
        flash('Nutrition not found.', 'danger')
        return redirect(url_for('admin.nutritions'))
    
    return render_template('admin/edit_nutrition.html', nutrition=nutrition)

@admin.route('/delete_nutrition', methods=['POST'])
@login_required
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
@login_required
def ingredients():
    ingredients = Ingredient.query.all()
    return render_template('admin/ingredients.html', ingredients=ingredients)

@admin.route('/add_ingredient', methods=['GET', 'POST'])
@login_required
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

        filename = secure_filename(str(uuid.uuid4()) + '.' + file.filename.rsplit('.', 1)[1].lower())
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
            temp = NutritionDetail(nutrition_id=key, ingredient_id=ingredient.id, amount=nutritions[key])
            print(temp.info)
            db.session.add(temp)
            db.session.commit()
        
        flash('Ingredient has been added', 'success')
        return redirect(url_for('admin.add_ingredient'))

    nutritions = Nutrition.query.all()
    return render_template('admin/add_ingredient.html', nutritions=nutritions)


@admin.route('/delete_ingredient', methods=['POST'])
@login_required
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
    if ingredient.image :
        try : 
            os.remove(os.path.join(config.UPLOAD_FOLDER, ingredient.image))
        except Exception as e:
            print(e)
            pass
    # nutrition_details = NutritionDetail.query.filter_by(ingredient_id=ingredient.id).all()
    # print(nutrition_details)
    
    # for detail in nutrition_details:
    #     db.session.delete(detail)
    db.session.delete(ingredient)
    db.session.commit()
    
    flash('Ingredient has been deleted', 'success')
    return redirect(url_for('admin.ingredients'))

@admin.route('/edit_ingredient/<int:id>', methods=['GET', 'POST'])
@login_required
def edit_ingredient(id):
    
    if request.method == 'POST':
        ingredient = Ingredient.query.filter_by(id=id).first()
        
        if not ingredient:
            flash('Ingredient not found', 'danger')
            return redirect(url_for('admin.ingredients'))
        
        name = request.form.get('name')
        description = request.form.get('description')
        
        nutritions = json.loads(request.form.get('nutritions'))

        if name == '' or description == '':
            flash('Name and description cannot be empty', 'danger')
            return redirect(url_for('admin.edit_ingredient', id=id))
        
        ingredient.name = name
        ingredient.description = description
        
        if 'image' in request.files:
            file = request.files['image']
            if file.filename != '':
                if not allowed_file(file.filename):
                    flash('Invalid file type', 'danger')
                    return redirect(url_for('admin.edit_ingredient', id=id))
                
                filename = secure_filename(str(uuid.uuid4()) + '.' + file.filename.rsplit('.', 1)[1].lower())
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
                # delete old image
                if ingredient.image:
                    try : 
                        os.remove(os.path.join(config.UPLOAD_FOLDER, ingredient.image))
                    except Exception as e:
                        print(e)
                        pass
                ingredient.image = filename
        
        
        
        db.session.commit()
        
        nutrition_key = list(nutritions.keys())
        
        for key in nutrition_key:
            temp = NutritionDetail.query.filter_by(nutrition_id=int(key), ingredient_id=ingredient.id).first()
            temp.amount = nutritions[key]
            db.session.commit()
        
        flash('Ingredient has been updated', 'success')
        return redirect(url_for('admin.edit_ingredient', id=id))
    
    ingredient = Ingredient.query.filter_by(id=id).first()
    
    if not ingredient:
        flash('Ingredient not found', 'danger')
        return redirect(url_for('admin.ingredients'))
    
    nutritions = NutritionDetail.query.filter_by(ingredient_id=ingredient.id).all()
    return render_template('admin/edit_ingredient.html', ingredient=ingredient, nutritions=nutritions)


@admin.route('/recipes')
@login_required
def recipes():
    recipes = Recipe.query.all()
    return render_template('admin/recipes.html', recipes=recipes)

@admin.route('/delete_recipe', methods=['POST'])
def delete_recipe():
    recipe_id = request.form.get('id')
    recipe = Recipe.query.filter_by(id=recipe_id).first()
    
    if not recipe:
        flash('Recipe not found', 'danger')
        return redirect(url_for('admin.recipes'))
    
    db.session.delete(recipe)
    db.session.commit()
    
    flash('Recipe has been deleted', 'success')
    return redirect(url_for('admin.recipes'))

@admin.route('/add_recipe', methods=['GET', 'POST'])
@login_required
def add_recipe():
    
    if request.method == 'POST':
        name = request.form.get('name')
        steps = request.form.get('steps')
        cooktime = request.form.get('cooktime')
        portions = request.form.get('portions')
        ingredients = request.form.getlist('ingredients')
        
        if len(ingredients) == 0:
            flash('Ingredients cannot be empty', 'danger')
            return redirect(url_for('admin.add_recipe'))
        
        if 'image' not in request.files:
            flash('No file part', 'danger')
            return redirect(url_for('admin.add_recipe'))
        
        file = request.files['image']
        
        if file.filename == '':
            flash('No selected file', 'danger')
            return redirect(url_for('admin.add_recipe'))
        
        if not allowed_file(file.filename):
            flash('Invalid file type', 'danger')
            return redirect(url_for('admin.add_recipe'))
            
        
        if name == '' or steps == '' or cooktime == '' or portions == '':
            flash('Name, steps, cooktime, and portions cannot be empty', 'danger')
            return redirect(url_for('admin.add_recipe'))
        
        
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
        
        recipe = Recipe(name=name, steps=steps, cooktime=cooktime, portions=portions, image=filename)
        
        db.session.add(recipe)
        db.session.commit()
        
        for key in ingredients:
            temp = RecipeDetail(recipe_id=recipe.id, ingredients_id=key, amount=0)
            db.session.add(temp)
            db.session.commit()

        flash('Recipe has been added', 'success')
        return redirect(url_for('admin.edit_recipe', id=recipe.id))
    ingredients = Ingredient.query.all()
    return render_template('admin/add_recipe.html', ingredients=ingredients)

@admin.route('/edit_recipe/<int:id>', methods=['GET', 'POST'])
@login_required
def edit_recipe(id):
    
    if request.method == 'POST':
        # print(request.form)
        recipe = Recipe.query.filter_by(id=id).first()
        ingredients = RecipeDetail.query.filter_by(recipe_id=id).all()
        if not recipe:
            flash('Recipe not found', 'danger')
            return redirect(url_for('admin.recipes'))
        
        name = request.form.get('name')
        steps = request.form.get('steps')
        cooktime = request.form.get('cooktime')
        portions = request.form.get('portions')
        
        recipe.name = name
        recipe.steps = steps
        recipe.cooktime = cooktime
        recipe.portions = portions

        for ingredient in ingredients:
            # print(request.form)
            the_id = ingredient.ingredients_id
            # print(the_id)
            amount = request.form.get(f'{ingredient.ingredients_id}_ingredient')
            unit = request.form.get(f'{ingredient.ingredients_id}_unit')
            # print(ingredient, amount, unit)
            ingredient.amount = amount
            ingredient.unit = unit
            db.session.commit()
            
            
        if 'image' in request.files:
            file = request.files['image']
            if file.filename != '':
                if not allowed_file(file.filename):
                    flash('Invalid file type', 'danger')
                    return redirect(url_for('admin.edit_recipe', id=id))
                
                filename = secure_filename(str(uuid.uuid4()) + '.' + file.filename.rsplit('.', 1)[1].lower())
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
                # delete old image
                if recipe.image:
                    try : 
                        os.remove(os.path.join(config.UPLOAD_FOLDER, recipe.image))
                    except Exception as e:
                        print(e)
                        pass
                recipe.image = filename
                
        db.session.commit()
        
        flash('Recipe has been updated', 'success')
        return redirect(url_for('admin.edit_recipe', id=id))
    
    recipe = Recipe.query.filter_by(id=id).first()
    ingredients = RecipeDetail.query.filter_by(recipe_id=id).all()
    # print(ingredients)
    return render_template('admin/edit_recipe.html', recipe=recipe, ingredients=ingredients)

@admin.route('/view_image/<text>')
def view_image(text):
    return redirect(url_for('static', filename=f'{app.config["FOLDER_UPLOAD_NAME"]}/{text}'), code=301)
