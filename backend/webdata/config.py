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
        