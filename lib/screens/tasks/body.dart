import 'package:flutter/material.dart';
import 'package:rg/constants/theme.dart';
import 'package:rg/screens/tasks/list.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 70.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: KWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                      offset: Offset(0, 10),
                      blurRadius:20
                    ),
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 2),
                      width: size.width / 2,
                      height: size.height / 5,
                      decoration: BoxDecoration(
                        border: Border.all(color: kPrimaryColor, width: 5.0),
                        shape: BoxShape.circle,
                        color: Colors.black,
                        image: new DecorationImage(
                          image: AssetImage('assets/images/profile.png'),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        'Jeremy Kamau',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                        ),
                      ),
                    ),
                    SizedBox(height: 3.0),
                    Center(
                      child: Text(
                        'Brand Ambassador',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: Text(
                        'You need to complete 100% to start your shift',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [KGradientStart, KGradientEnd],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight
                        )
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                          onPressed: () {},
                          child: Text(
                            'You are 0% complete',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TaskList(),
                    SizedBox(height: size.height * 0.1)
                  ],
                ),
              )
            ]
          )
        ],
      )
    );
  }
}