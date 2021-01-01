import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rg/constants/theme.dart';
import 'package:rg/models/timesheet.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TaskList extends StatefulWidget {
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  TimeSheetRequestModel requestModel;
  final _storage = FlutterSecureStorage();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String actionType = 'clockin';

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _submitData() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('hh:mm:ss');

    dynamic time = formatter.format(now);

    Map data = {
      'latitude': geoposition.latitude,
      'longitude': geoposition.longitude,
      'time': time,
      'type': actionType
    };
    var jsonResponse;
    var accessToken = await _storage.read(key: "token");
    try {
      var response = await http.post(
        "http://campaign.redgiant.co.ke/api/timesheet",
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (jsonResponse != null) {
         final snackBar = SnackBar(
           content: Text('Successful login'),
         );
        _scaffoldKey.currentState
            .showSnackBar(snackBar);
        }
      } else {
        setState(() {
          print(json.decode(response.body)['error']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                width: size.width * 0.3,
                height: size.height / 17,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: KGACTIVE,
                  ),
                  borderRadius: BorderRadius.circular(29),
                  color: Colors.blue,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    onPressed: () async {
                      _submitData();
                    },
                    color: KGACTIVE,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Clock In',
                          style: TextStyle(color: Colors.black),
                        ),
                        Container(
                          width: 29,
                          height: 21,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            shape: BoxShape.circle,
                            color: KGACTIVE,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                width: size.width * 0.3,
                height: size.height / 17,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: KGACTIVE,
                  ),
                  borderRadius: BorderRadius.circular(29),
                  color: Colors.blue,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/camera');
                    },
                    color: KGACTIVE,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Shelve Pic',
                          style: TextStyle(color: Colors.black),
                        ),
                        Container(
                          width: 29,
                          height: 21,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            shape: BoxShape.circle,
                            color: KGACTIVE,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                width: size.width * 0.3,
                height: size.height / 17,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: KGACTIVE,
                  ),
                  borderRadius: BorderRadius.circular(29),
                  color: Colors.blue,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    onPressed: () {},
                    color: KGACTIVE,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Stock Take',
                          style: TextStyle(color: Colors.black),
                        ),
                        Container(
                          width: 29,
                          height: 21,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            shape: BoxShape.circle,
                            color: KGACTIVE,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.0),
            Expanded(
              child: Container(
                width: size.width * 0.3,
                height: size.height / 17,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: KGACTIVE,
                  ),
                  borderRadius: BorderRadius.circular(29),
                  color: Colors.blue,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    onPressed: () {},
                    color: KGACTIVE,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Start Shift',
                          style: TextStyle(color: Colors.black),
                        ),
                        Container(
                          width: 29,
                          height: 21,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            shape: BoxShape.circle,
                            color: KGACTIVE,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
