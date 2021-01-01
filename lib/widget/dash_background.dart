import 'package:flutter/material.dart';

class DashBackground extends StatelessWidget {
  final Widget child;
  const DashBackground({
    Key key,
    @required this.child,
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Positioned(
          //   left: 0,
          //   top: 0,
          //   child: Image.asset(
          //     'assets/images/header.png',
          //     width: size.width * 0.9,
          //   ),
          // ),
          child,
        ],
      ),
    );
  }
}