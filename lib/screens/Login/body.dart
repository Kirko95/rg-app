import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rg/constants/theme.dart';
import 'package:rg/models/login_model.dart';
import 'package:rg/services/api_service.dart';
import 'package:rg/widget/background.dart';

class Body extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Body> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isLoading = true;

  LoginRequestModel requestModel;
  final _storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    isLoading = false;
    requestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: isLoading ? KWhiteColor : kPrimaryColor,
        key: scaffoldKey,
        body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Background(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: KWhiteColor),
                          onSaved: (input) => requestModel.phone = input,
                          validator: (input) => input.length < 3
                              ? "Phone number too short"
                              : null,
                          maxLength: 18,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            labelStyle: TextStyle(color: KWhiteColor),
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: KWhiteColor,
                                )),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              gapPadding: 8.0,
                              borderSide: BorderSide(
                                color: KWhiteColor,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: KWhiteColor,
                            ),
                            hintText: "Phone Number",
                            hintStyle: TextStyle(
                                fontSize: 15.0, color: KWhiteColor
                            )
                          ),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          obscureText: true,
                          style: TextStyle(color: KWhiteColor),
                          onSaved: (input) => requestModel.password = input,
                          validator: (input) =>
                              input.length < 3 ? "Password too short" : null,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(color: KWhiteColor),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: KWhiteColor,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: KWhiteColor,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: KWhiteColor,
                              ),
                              hintText: "********",
                              hintStyle: TextStyle(
                                  fontSize: 20.0, color: KWhiteColor)),
                        ),
                        SizedBox(height: 29.0),
                        Container(
                          width: size.width / 0.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              color: Colors.red,
                              onPressed: () {
                                setState(() {
                                  isLoading = true;
                                });
                                if (validateAndSave()) {
                                  APIService.login(requestModel)
                                    .then((value) async {

                                    if (value.access_token.isNotEmpty) {
                                      await _storage.write(
                                          key: "token",
                                          value: value.access_token);
                                      final snackBar = SnackBar(
                                        content: Text('Successful login',
                                            style: TextStyle(
                                                color: KWhiteColor)),
                                      );
                                      scaffoldKey.currentState
                                          .showSnackBar(snackBar);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      Navigator.pushNamed(context, '/tasks');
                                    } else {
                                      final snackBar = SnackBar(
                                        content: Text('Oops!! Invalid Credentials',
                                            style: TextStyle(
                                                color: KWhiteColor)),
                                      );
                                      scaffoldKey.currentState
                                          .showSnackBar(snackBar);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  });
                                }
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
