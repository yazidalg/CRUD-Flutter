import 'package:flutter/material.dart';
import 'package:flutter_sqfllite/db/crud.dart';
import 'package:flutter_sqfllite/model/class_model.dart';
import 'package:flutter_sqfllite/page/entry_form.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CRUD dbHelper = CRUD();
  Future<List<Model>> future;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  void updateListView() {
    setState(() {
      future = dbHelper.getContactList();
    });
  }

  Future<Model> navigateTo(BuildContext context, Model contact) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(contact);
    }));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: FutureBuilder<List<Model>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: snapshot.data.map((e) => cardo(e)).toList());
          } else {
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var contact = await navigateTo(context, null);
          if (contact != null) {
            int result = await dbHelper.insert(contact);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }

  Card cardo(Model contact) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.person_rounded,
            color: Colors.cyanAccent,
          ),
        ),
        title: Text(contact.name),
        subtitle: Text(contact.phone),
        trailing: GestureDetector(
          child: Icon(Icons.delete),
          onTap: () async {
            int result = await dbHelper.delete(contact);
            if (result > 0) {
              updateListView();
            }
          },
        ),
        onTap: () async {
          var contact2 = await navigateTo(context, contact);
          if (contact2 != null) {
            int result = await dbHelper.update(contact2);
            if (result < 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }
}
