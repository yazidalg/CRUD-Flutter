class Model{
  int _id;
  String _name;
  String _phone;
  String _email;

  Model(this._name, this._phone, this._email);

  Model.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._name = map['name'];
    this._email = map['email'];
    this._phone = map['phone'];
  }

  int get id => _id;

  String get name => _name;

  String get email => _email;

  String get phone => _phone;

  set name(String value){
    _name = value;
  }

  set email(String value){
    _email = value;
  }

  set phone(String value){
    _phone = value;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }
}