import 'package:flutter/material.dart';
import 'package:rg/constants/theme.dart';
import 'package:rg/screens/dashboard/body.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}