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
    tanggalLahir = db.Column(db.DateTime)

    @property
    def formatted_tanggal_lahir(self):
        return self.tanggalLahir.strftime("%d%m%Y")

    def __repr__(self):
        return f'<User: {self.name}>'
    
class BahanMakanan(db.Model):
    idBahan = db.Column(db.Integer, primary_key=True)
    namaBahan = db.Column(db.String(100))
    deskripsiBahan = db.Column(db.String(200))

class ResepMakanan(db.Model):
    idResep = db.Column(db.Integer, primary_key=True)
    idBahan = db.Column(db.Integer, db.ForeignKey('DetailNutrisi.idDetailNutrisi'))#disini gw jadiin FK karena menurut gw resepmakanan ngambil data dari detailnutrisi, bukan sebaliknya
    namaMakanan = db.Column(db.String(100), unique=True)
    langkahPembuatan = db.Column(db.String(200))
    jumlahPorsi = db.Column(db.Integer)
    waktuMemasak = db.Column(db.Integer) #Integer karena waktu memasak dalam menit sehingga perlu memasukkan waktu memasak dalam menit

class Nutrisi(db.Model):
    idNutrisi = db.Column(db.Integer, primary_key=True)
    nama = db.Column(db.String(100), unique=True)

class DetailNutrisi(db.Model):
    idDetailNutrisi = db.Column(db.Integer, primary_key=True)
    # idBahan = db.Column(db.Integer, db.ForeignKey('BahanMakanan.idBahan'), default = None)
    jumlahNutrisi = db.Column(db.Integer)

class ResepMakananDetail(db.Model):
    idResepDetail = db.Column(db.Integer, primary_key=True)
    #Disini gw nambahin idResepDetail karena dari class diagram cuma ada idResep ama idBahan, sedangkan perlu ada PK untuk tiap tabel
    idResep = db.Column(db.Integer, db.ForeignKey('ResepMakanan.idResep'))
    idBahan = db.Column(db.Integer, db.ForeignKey('BahanMakanan.idBahan'))
    jumlahBahan = db.Column(db.Float)
    satuanJumlah = db.Column(db.String(50))

class Artikel(db.Model):
    idArtikel = db.Column(db.Integer, primary_key = True)
    judulArtikel = db.Column(db.String(150), unique = True)
    detailArtikel = db.Column(db.String(1000))
    namaPenulis = db.Column(db.String(100))
    tanggalTerbit = db.Column(db.DateTime)

    @property
    def formatted_tanggal_terbit(self):
        return self.tanggalTerbit.strftime("%d%m%Y")
