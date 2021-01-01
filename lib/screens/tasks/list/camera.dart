import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rg/constants/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Camera extends StatefulWidget {
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _image;
  final picker = ImagePicker();
  String base64Image;
  final _storage = FlutterSecureStorage();

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void _uploadImage(_image) async {
    var accessToken = await _storage.read(key: "token");
    dynamic filename = basename(_image.path);
    String base64image = base64Encode(_image.readAsBytesSync());

    http.post('http://campaign.redgiant.co.ke/api/shelf', body: {
      'photo': base64image,
      'name': filename
    }, headers: {
      'Authorization':
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWQ1M2Q0YmY0NjcxMGZlMGEzZWM4OTgwYTMxNGRiZTE0ZDdlOTc3ZTcyNzY4MWUxZDBkY2JiMmI2NzkyMGY1OGZmMDE0Nzc0NGIxNThkYjMiLCJpYXQiOiIxNjA5MTUxNzE4LjcxNjQ3MCIsIm5iZiI6IjE2MDkxNTE3MTguNzE2NDc1IiwiZXhwIjoiMTY0MDY4NzcxOC43MTE5ODIiLCJzdWIiOiI4Iiwic2NvcGVzIjpbXX0.ZBMfoq5hv0JB11VJiwVPE6lRG-hFfkje6aHExaR52sonEuebcvyDPoBDX9gJYs-V_Zr8GNC0WzD8DXfzjZTgKdzoczJIqGki8PDRt8y7VjM5YIYmyfkWpUqf9rtyRUsLDy1HZTdZVYBJHtWalCF05gkYEddK6Cl6YAtcVU0yw-Q9FW4YBLMuYrdMnmAaY91pX5QM1xPmXKz3cmcdpjJA-my5zGBXxMCkY6SuK9VIQPEZL0-gxgIhBe6FOoYy4pFUf13RZwT7WeLxAVv2rFy-A8NpB2l0V55vjWZuEziQI2yuywJAOykGpwBjN11zxnUu6O28KKAvLSZXAPwshOzHdvwbajurTvJbKN_qAGv6QxC6sJ67bG65EEKXT3TxhsGQ1t9oWImS4vXapsVHfDap6KT0FPDpYcsF0F916Oqi8vnfQHy3jrGUu3qn6lI5k0U4EAtrPfOvtCPtkLoMaGwPVIC8IpbwI_l4X2_QD3UMcTrggrF7iWSxsSo8VjJ3bMYSNLPKl2BxUV0LbYuAZiNPsZ-Vh1uMuyapWhnCUpsPdbSSNjRq3SfEaoN1DJUQ_spToGlVUEte6gE1AjjOOWamMVZ-xRLnOS68s7fBacnQ4Bo5ZZvrZKyd_0d8bFJJ5RURYbWDU3gNztwG1bZ6vkmeMkhBzgrfDSC9iaYRfK56ACA",
    }).then((response) {
      print(response.statusCode);
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        child: _image == null
            ? Center(
                child: Text(
                'Take a photo of the shelve..',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ))
            : Container(
                padding: EdgeInsets.all(19.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Please ensure its a photo of shelve',
                      style: TextStyle(
                          color: KWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    SizedBox(height: 18.0),
                    Container(
                      child: Image.file(_image),
                    ),
                    SizedBox(height: 18.0),
                    Container(
                      width: size.width / 0.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          color: Colors.red,
                          onPressed: () {
                            _uploadImage(_image);
                          },
                          child: Text(
                            'UPLOAD',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Take Photo',
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.red,
      ),
    );
  }
}
