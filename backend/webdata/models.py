from webdata import db, app
from webdata import jwt

#Table List:
# - User
# - BahanMakanan
# - ResepMakanan
# - Nutrisi
# - DetailNutrisi
# - ResepMakananDetail
# - Artikel

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    password = db.Column(db.String(100))
    email = db.Column(db.String(100), unique=True)
    username = db.Column(db.String(100), unique=True)
    tanggallahir = db.Column(db.DateTime)

    @property
    def formatted_tanggal_lahir(self):
        return self.tanggallahir.strftime("%d%m%Y")

    def __repr__(self):
        return f'<User: {self.name}>'

class ResepFavorit(db.Model):
    __tablename__ = 'resepfavorite'
    id_user = db.Column(db.Integer, db.ForeignKey('user.id'))
    id_resepfavorit = db.Column(db.Integer, db.ForeignKey('resepmakanan.id_resep'), primary_key=True)


class BahanMakanan(db.Model):
    __tablename__ = 'bahanmakanan'
    id_bahan = db.Column(db.Integer, primary_key=True)
    id_nutrisi = db.Column(db.Integer, db.ForeignKey('nutrisi.id_nutrisi'))
    namabahan = db.Column(db.String(100))
    deskripsibahan = db.Column(db.String(200))

class ResepMakanan(db.Model):
    __tablename__ = 'resepmakanan'
    id_resep = db.Column(db.Integer, primary_key=True)
    namamakanan = db.Column(db.String(100), unique=True)
    langkahpembuatan = db.Column(db.String(200))
    jumlahporsi = db.Column(db.Integer)
    waktumemasak = db.Column(db.Integer) #Integer karena waktu memasak dalam menit sehingga perlu memasukkan waktu memasak dalam menit

class Nutrisi(db.Model):
    __tablename__ = 'nutrisi'
    id_nutrisi = db.Column(db.Integer, primary_key=True)
    id_detailnutrisi = db.Column(db.Integer, db.ForeignKey('detailnutrisi.id_detailnutrisi'))
    nama = db.Column(db.String(100), unique=True)

class DetailNutrisi(db.Model):
    __tablename__ = 'detailnutrisi'
    id_detailnutrisi = db.Column(db.Integer, primary_key=True)
    jumlahnutrisi = db.Column(db.Integer)

class ResepMakananDetail(db.Model):
    __tablename__ = 'resepmakanandetail'
    id_resepdetail = db.Column(db.Integer, primary_key=True)
    #Disini gw nambahin idResepDetail karena dari class diagram cuma ada idResep ama id, sedangkan perlu ada PK untuk tiap tabel
    id_resep = db.Column(db.Integer, db.ForeignKey('resepmakanan.id_resep'))
    id_bahan = db.Column(db.Integer, db.ForeignKey('bahanmakanan.id_bahan'))
    jumlahbahan = db.Column(db.Float)
    satuanjumlah = db.Column(db.String(50))

class Artikel(db.Model):
    __tablename__ = 'artikel'
    idartikel = db.Column(db.Integer, primary_key = True)
    judulartikel = db.Column(db.String(150), unique = True)
    detailartikel = db.Column(db.String(1000))
    namaaenulis = db.Column(db.String(100))
    tanggalterbit = db.Column(db.DateTime)

    @property
    def formatted_tanggal_terbit(self):
        return self.tanggalterbit.strftime("%d%m%Y")
