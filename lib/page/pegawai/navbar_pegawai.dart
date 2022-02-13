import 'package:flutter/material.dart';

class NavBarPegawa extends StatefulWidget {
  const NavBarPegawa({ Key key }) : super(key: key);

  @override
  _NavBarPegawaState createState() => _NavBarPegawaState();
}

class _NavBarPegawaState extends State<NavBarPegawa> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Pegawai'),
    );
  }
}