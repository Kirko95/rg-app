import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rg/constants/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Camera extends StatefulWidget {
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _image;
  final picker = ImagePicker();
  String base64Image;
  final _storage = FlutterSecureStorage();
  bool isLoading = true;
  final file = <http.MultipartFile>[];

  @override
  void initState(){
    super.initState();
    isLoading = false;
  }
  
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
      isLoading = false;
    });
  }

  void _uploadImage() {
    String path = _image.path;
    uploadImage(path).then((value){
      print("Success");
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(context, '/tasks');
    }).catchError((error){
      print(error);
      setState(() {
        isLoading = false;
      });
    });
  }


   Future<void> uploadImage(String path) async {
    try {
      String filename = path.split('/').last;
      var token = await _storage.read(key: "token");
      final dio = Dio();
      dio.options.headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token'
      };

      final file = await MultipartFile.fromFile(path, filename: filename);
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

      if(response.statusCode == 200){
        print("Successful");
      }
    } catch (err) {
      print('uploading error: $err');
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: isLoading
      ? 
        Center(child: CircularProgressIndicator())
      : Container(
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
                        _uploadImage();
                        setState(() {
                          isLoading = true;
                        });
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
