import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rg/constants/theme.dart';
import 'package:rg/screens/dashboard/dashboard.dart';
import 'package:rg/screens/intro/welcome.dart';
import 'package:rg/screens/tasks/list/camera.dart';
import 'package:rg/screens/tasks/tasks.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/tasks':
        return MaterialPageRoute(builder: (_) => TaskScreen());
      case '/camera':
        return MaterialPageRoute(builder: (_) => Camera());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Oops!',
                  style: TextStyle(
                    color: KWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0
                  ),
                ),
              ),
              SizedBox(height: 39),
              SvgPicture.asset(
                "assets/icons/error.svg",
                height: 60,
                width: 60,
                color: KWhiteColor,
              ),
              SizedBox(height: 39),
              Center(
                child: Text(
                  'PAGE NOT FOUND!',
                  style: TextStyle(
                    color: KWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
