import 'package:flutter/material.dart';
import 'package:rg/constants/theme.dart';
import 'package:rg/screens/intro/body.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}