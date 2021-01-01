import 'package:flutter/material.dart';
import 'package:rg/constants/theme.dart';
import 'package:rg/screens/Login/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}