import os

class Config():
    def __init__(self):
        self.DB_PLATFORM = 'mysql+pymysql'
        self.DB_SERVER = 'localhost'
        self.DB_NAME = 'nutrizoom'
        self.DB_USERNAME = 'root'
        self.DB_PASSWORD = ''
        self.DB_PORT = '3306'
        
        self.SECRET_KEY = 'secret'
        
        self.DB_URI = f'{self.DB_PLATFORM}://{self.DB_USERNAME}:{self.DB_PASSWORD}@{self.DB_SERVER}:{self.DB_PORT}/{self.DB_NAME}'
        
        self.UPLOAD_FOLDER = 'images'
        
        # create db_URI for linux
        # self.DB_URI = f'{self.DB_PLATFORM}://{self.DB_USERNAME}:{self.DB_PASSWORD}@{DB_SERVER}/{DB_NAME}'
        # self.DB_URL=f"{self.DB_PLATFORM}://{self.DB_SERVER}/{self.DB_NAME}"
        
        self.REFRESH_TOKEN_DURATION = 30 #Days
        self.ACCESS_TOKEN_DURATION = 1 #Hours
        
        