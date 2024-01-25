from webdata import db, app
#Table List:
# - User
# - BahanMakanan
# - Nutrisi
# - DetailNutrisi
# - ResepMakananDetail
# - ResepMakanan
# - Artikel

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    password = db.Column(db.String(100))
    email = db.Column(db.String(100), unique=True)
    
    def __repr__(self):
        return f'<User: {self.name}>'
    
class BahanMakanan(db.Model):
    idBahan = db.Column(db.Integer, primary_key=True)
    namaBahan = db.Column(db.String(100))
    deskripsiBahan = db.Column(db.String(200))

