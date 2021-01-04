import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size  size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 40,
            child: Image.asset(
              'assets/images/white-logo.png',
              width: size.width * 0.2,
            ),
          ),
          child,
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              'assets/images/footer.png',
              width: size.width * 0.9,
            ),
          )
        ],
      ),
    );
  }
}