import 'package:flutter/material.dart';
import 'package:rg/constants/theme.dart';

class Body extends StatefulWidget {
  @override
  _StockTakeState createState() => _StockTakeState();
}

class _StockTakeState extends State<Body> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 70),
        child: Container(
          width: double.infinity,
          height: size.height * 1.5,
          padding: EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            ),
            color: KWhiteColor,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).hintColor.withOpacity(0.2),
                offset: Offset(0, 10),
                blurRadius: 20
              ),
            ]
          ),
          child: Column(
            key: globalFormKey,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                style: TextStyle(color: KWhiteColor),
                decoration: InputDecoration(
                  labelText: "Select Product",
                  labelStyle: TextStyle(color: Colors.black),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey
                    )
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
