import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rg/constants/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
/////////////IMPORT DIO
class Camera extends StatefulWidget {
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _image;
  final picker = ImagePicker();
  String base64Image;
  final _storage = FlutterSecureStorage();
  bool isLoading = true;


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
      
    });
  }
 String path = _image.path;
 String filename = path.split('/').last;
  //////////////////////////////////////REMOVE/COMMENT OUT THIS////////////////
  void _uploadImage(_image) async {
    var accessToken = await _storage.read(key: "token");    
    String base64image = base64Encode(_image.readAsBytesSync());
    print(filename);
    http.post('http://campaign.redgiant.co.ke/api/shelf', body: {
      'photo': base64image,
      'name': filename
    }, headers: {
      'Authorization': "Bearer $accessToken",
    }).then((response) {
      print(response.statusCode);
    }).catchError((error) {
      print(error);
    });
  }  
 ////////////////////////////////////TRY USING THIS///////////////////////////// 
  Future<void> _uploadFileAsFormData(String path) async {
  try {
    final dio = Dio();
    dio.options.headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

    final file =
      await MultipartFile.fromFile(path, filename: filename);
    final formData = FormData.fromMap(
      {
       'photo': file,
      'name': filename
      }
    ); // 'file' - this is an api key, can be different

    final response = await dio.post( // or dio.post
      'http://campaign.redgiant.co.ke/api/shelf',
      data: formData,
    );
  } catch (err) {
    print('uploading error: $err');
  }
}
//////////////////////////////////////////////////
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
