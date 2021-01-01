import 'package:flutter/material.dart';
import 'package:rg/constants/theme.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 2),
                        width: size.width /2,
                        height: size.height /5,
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
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Jerry Kamau',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Brand Ambassodor',
                        style: TextStyle(
                          color: KWhiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Kilimani, Nairobi',
                        style: TextStyle(
                          color: KWhiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: KWhiteColor
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Daily Sales',
                          style: TextStyle(
                            color: KBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'More than 400 + sales',
                          style: TextStyle(
                            color: KBlack,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: size.width / 2.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FlatButton(
                          color: Colors.red,
                          onPressed: () {},
                          child: Text(
                            'Sales Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
          ],
        ),
      )
    );
  }
}