import 'package:flutter/material.dart';
import 'package:flutter_sqfllite/model/class_model.dart';

class EntryForm extends StatefulWidget {
  final Model contact;

  EntryForm(this.contact);

  @override
  _EntryFormState createState() => _EntryFormState(this.contact);
}

class _EntryFormState extends State<EntryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();

  Model contact;

  _EntryFormState(this.contact);

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return "Enter valid email";
    }
    return null;
  }

  String validatePhone(String value){
    if(value.length < 12){
      return "Enter valid Phone Number";
    }
    return null;
  }

  String validateName(String value){
    if(value.length < 5){
      return "Enter more than 5 character";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (contact != null) {
      _name.text = contact.name;
      _email.text = contact.email;
      _phone.text = contact.phone;
    }
    return Scaffold(
      appBar: AppBar(
        title: contact == null ? Text("Tambah Data") : Text("Rubah Data"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.name,
                  validator: validateName,
                  decoration: InputDecoration(
                      labelText: "Nama",
                      hintText: "Your Name Here",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText:"yours12@gmail.com",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  validator: validatePhone,
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: "Phone",
                      hintText: "081212123434",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton.icon(
                    onPressed: () {
                      if(_formKey.currentState.validate() && contact == null){
                        contact = Model(_name.text, _phone.text, _email.text);
                      } else {
                        contact.name = _name.text;
                        contact.email = _email.text;
                        contact.phone = _phone.text;
                      }
                      Navigator.pop(context, contact);
                    },
                    icon: Icon(Icons.check),
                    label: Text("Save"),
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.pop(context, contact);
                    },
                    icon: Icon(Icons.close),
                    label: Text("Cancel"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
