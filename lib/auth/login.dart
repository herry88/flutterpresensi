import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutteradm/page/homepage.dart';
import 'package:flutteradm/urlapi.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  //variabel global
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //membuat variabel umum pada form
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password;
  String roleAdmin = 'admin';
  String roleUser = 'user';
  //variabel global pada form
  final _key = GlobalKey<FormState>();
  bool _securityText = true; //password show hide

  //show hide password
  showHide() {
    setState(
      () {
        _securityText = !_securityText;
      },
    );
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  //function login
  login() async {
    final response = await http.post(Uri.parse(LoginUrl.login),
        body: {"email": email, "password": password});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String roleApi = data['role'];
    String id = data['id'];

    //kondisi login
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
      });
      print(message);
      print('Iniadalah Role' + roleApi);
      print('Ini adalah ID'+id);
    } else {
      print('fail');
      print(message);
    }
  }

  savePref(int value, String id, String username, String api_key,
      String role) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("username", username);
      preferences.setString("api_key", api_key);
      preferences.setString("role", role);
      preferences.setString("id", id);
      // ignore: deprecated_member_use
      preferences.commit();
      // preferences.commit();
    });
  }

  var value, role;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      role = preferences.getString("role");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          key: _scaffoldKey,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 13.0,
                ),
                child: Column(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 508,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 140.0,
                                    top: 20.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Login Page',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.blueGrey,
                                          fontFamily: 'Times New Roman',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30.0,
                                    right: 30.0,
                                    top: 40.0,
                                  ),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        //validator disini
                                        // ignore: missing_return
                                        validator: (e) {
                                          if (e.isEmpty) {
                                            return 'isi email anda';
                                          }
                                        },
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        onSaved: (e) => email = e,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black12,
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black12,
                                            ),
                                          ),
                                          labelText: 'Email',
                                          labelStyle: TextStyle(
                                            color: Colors.black12,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30.0,
                                    right: 30.0,
                                    top: 40.0,
                                  ),
                                  child: Column(children: [
                                    TextFormField(
                                      //validator disini
                                      // ignore: missing_return
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'isikan password';
                                        }
                                      },
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      obscureText: _securityText,
                                      onSaved: (value) => password = value,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black12,
                                          ),
                                        ),
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                          color: Colors.black12,
                                        ),
                                        suffixIcon: IconButton(
                                          color: Colors.black,
                                          onPressed: showHide,
                                          icon: Icon(
                                            _securityText
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 60.0),
                                  width: 260.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      check();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.0,
                                        ),
                                      ),
                                    ),
                                    child: Text('Login'),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()),
                                    );
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top: 20.0),
                                      width: 200.0,
                                      child: Center(
                                        child: Text('Doesnt have account'),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        break;
      case LoginStatus.signIn:
        return MyHomePage();
        break;
    }
  }
}
