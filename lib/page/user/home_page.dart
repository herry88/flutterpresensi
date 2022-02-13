import 'package:flutter/material.dart';
import 'package:flutteradm/model/databasehelper.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({Key key}) : super(key: key);

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  //iniliasisasi
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController _controllerOrder = TextEditingController();
  TextEditingController _controllerFile = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Data Presensi'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          ),
          Container(
            height: 50.0,
            child: TextField(
              controller: _controllerOrder,
              decoration: InputDecoration(
                labelText: 'Jam Masuk',
                hintText: 'Jam Masuk',
                icon: Icon(Icons.book),
              ),
            ),
          ),
          Container(
            height: 50.0,
            child: TextField(
              controller: _controllerFile,
              decoration: InputDecoration(
                labelText: 'Keterangan',
                hintText: 'Keterangan',
                icon: Icon(Icons.book),
              ),
            ),
          ),
          
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                databaseHelper.adddata(
                    _controllerOrder.text.trim(), _controllerFile.text.trim());
              },
              child: Text(
                'Simpan data',
              ),
            ),
          )
        ],
      ),
    );
  }
}
