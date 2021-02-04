class Note {
  int _id;
  int _status;
  int _tipe;
  String _nama;
  String _jumlah;
  double _harga;
  String _date;

  Note(this._status, this._tipe, this._nama, this._jumlah, this._harga, this._date);

  Note.withId(this._id, this._status, this._tipe, this._nama, this._jumlah, this._harga, this._date);

  int get id => _id;
  int get status => _status;
  int get tipe => _tipe;
  String get nama => _nama;
  String get jumlah => _jumlah;
  double get harga => _harga;
  String get date => _date;

  set status(newStatus){
    if(newStatus >= 1 && newStatus <=2){
      this._status = newStatus;
    }
  }

  set tipe(newTipe){
    if(newTipe >= 1 && newTipe <=2){
      this._tipe = newTipe;
    }
  }

  set nama(String newNama) {
    this._nama = newNama;
  }

    set jumlah(String newJumlah) {
    this._jumlah = newJumlah;
  }

  set harga(double newHarga) {
    this._harga = newHarga;
  }

  set date(String newDate) {
    this._date = newDate;
  }

	// Convert Note object ke Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['status'] = _status;
		map['tipe'] = _tipe;
		map['nama'] = _nama;
    map['jumlah'] = _jumlah;
    map['harga'] = _harga;
		map['date'] = _date;

		return map;
	}

  // Extract Note object ke Map object
	Note.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._status = map['status'];
		this._tipe = map['tipe'];
		this._nama = map['nama'];
    this._jumlah = map['jumlah'];
    this._harga = map['harga'];
		this._date = map['date'];
	}
}