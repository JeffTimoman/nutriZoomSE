from webdata import app
def createuser():
    from flask import Flask
    from flask_sqlalchemy import SQLAlchemy
    from flask_migrate import Migrate
    from flask_jwt_extended import JWTManager
    from flask_bcrypt import Bcrypt
    from flask_cors import CORS

    from webdata.config import Config
    # import sleep
    from time import sleep
    config = Config()
    app = Flask(__name__)
    app.config['SECRET_KEY'] = config.SECRET_KEY
    app.config['SQLALCHEMY_DATABASE_URI'] = config.DB_URI
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['JWT_SECRET_KEY'] = config.SECRET_KEY
    
    db = SQLAlchemy(app)
    bcrypt = Bcrypt(app)
    from webdata.models import User
    
    with app.app_context():
        user_name = input('Enter your name: ')
        user_email = input('Enter your email: ')
        user_password = input('Enter your password: ')
        
        user = User(name=user_name, email=user_email, password=bcrypt.generate_password_hash(user_password).decode('utf-8'))
        db.session.add(user)
        db.session.commit()
        sleep(1)
        print('User created successfully')

def runserver():

    app.run(debug=True)

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('command', help='the command to run', choices=['createuser', 'runserver'])
    args = parser.parse_args()

    if args.command == 'createuser':
        createuser()
    elif args.command == 'runserver':
        runserver()

