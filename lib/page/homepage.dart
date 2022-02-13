import 'package:flutter/material.dart';
import 'package:flutteradm/page/pegawai/navbar_pegawai.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user/navbar_user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //function get ref
  var value, role;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      role = preferences.getString("role");
    });
  }

  // ignore: missing_return
  Widget homeui() {
    if (role == 'pegawai')
      return NavBarPegawa();
    else
      return NavBarUser();
  }

  @override
  void initState() {
    // getData();
    getPref();
    print(value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(role);
    return homeui();
  }
}
