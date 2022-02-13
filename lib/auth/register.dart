import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // final LoginStatus _loginStatus = LoginStatus.notSignIn;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final _key = GlobalKey<FormState>();
  String email, name, password;

  //function register
  register() async {
    showDialog(context: context, builder: (context) => _loading(context));
    var url = "https://admweb-heroku.herokuapp.com/api/register";
    final response = await http.post(Uri.parse(url), body: {
      "email": email,
      "name": name,
      "password": password,
      "role": 'user'
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    //kondisi
    if (value == 1) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
      print(message);
    } else if (value == 2) {
      print(message);
      Navigator.pop(context);
      _showToast(message);
    } else {
      print(message);
      _showToast(message);
    }
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      register();
    }
  }

  _showToast(String toast) {
    final snackBar = SnackBar(
      content: Text(toast),
      backgroundColor: Colors.red,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget _loading(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: Opacity(
        opacity: 1,
        child: CupertinoAlertDialog(
            title: Text('Please wait...'),
            content: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )),
      ),
    );
  }

  //show password
  bool _secureText = true;
  bool _secureTextConfirm = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  showHideConfirm() {
    setState(() {
      _secureTextConfirm = !_secureTextConfirm;
    });
  }

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _key,
      body: SafeArea(
        child: ListView(
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
                                      'Register Page',
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
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return 'Email Tidak Boleh Kosong';
                                        return null;
                                      },
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      //onsave
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
                                      keyboardType: TextInputType.emailAddress,
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
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return 'Nama Tidak Boleh Kosong';
                                        return null;
                                      },
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      //onsave
                                      onSaved: (e) => name = e,
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
                                        labelText: 'Nama',
                                        labelStyle: TextStyle(
                                          color: Colors.black12,
                                        ),
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
                                      controller: _pass,
                                      //validator disini
                                      validator: (val) {
                                        if (val.isEmpty)
                                          return 'Password Tidak Boleh Kosong';
                                        return null;
                                      },
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      //onsave
                                      onSaved: (e) => password = e,
                                      obscureText: _secureText,
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
                                          onPressed: () {
                                            showHide();
                                          },
                                          icon: Icon(
                                            _secureText
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                        ),
                                        focusColor: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(
                              //     left: 30.0,
                              //     right: 30.0,
                              //     top: 20.0,
                              //   ),
                              //   child: Column(
                              //     children: [
                              //       TextFormField(
                              //         onSaved: (e) => password = e,
                              //         controller: _confirmPass,
                              //         validator: (val) {
                              //           if (val.isEmpty)
                              //             return 'Password not match';
                              //           return null;
                              //         },
                              //         obscureText: _secureTextConfirm,
                              //         style: TextStyle(
                              //           color: Colors.redAccent,
                              //         ),
                              //         decoration: InputDecoration(
                              //           focusedBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //               color: Colors.black12,
                              //             ),
                              //           ),
                              //           enabledBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //               color: Colors.black12,
                              //               width: 1.0,
                              //             ),
                              //           ),
                              //           labelText: 'Confirmation Password',
                              //           labelStyle: TextStyle(
                              //             color: Colors.black12,
                              //           ),
                              //           suffixIcon: IconButton(
                              //             onPressed: () {
                              //               showHideConfirm();
                              //             },
                              //             icon: Icon(
                              //               _secureTextConfirm
                              //                   ? Icons.visibility_off
                              //                   : Icons.visibility,
                              //             ),
                              //           ),
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),
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
                                  child: Text('Register'),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  width: 200.0,
                                  child: Center(
                                    child: Text(
                                      'Already Have Account !',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
