import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home:Scaffold(
        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed:(){
                  downloadFile();
                },
                child: const Text("upload File")),


            ],
          )
        ),
      )
    );
  }
  Future downloadFile()async {
    var dio =Dio();
    FilePickerResult? result =await FilePicker.platform.pickFiles(

    );
    if (result!=null) {
      File file = File(result.files.single.path ?? "");
      String filename = file.path
          .split('/')
          .last;
      String filepath=file.path;

      FormData data = FormData.fromMap({
        'key': '',
        'image': await MultipartFile.fromFile(filepath, filename: filename),
        'name':'abhi.jpg'
      });
      var response = await dio.post("https://api.imgbb.com/1/upload",
          data: data,
          onSendProgress: (int sent, int total) {
            print('$sent,$total');
          });
      print(response.data);
    }
    else{
      print("Resullt is null");
    }
  }

}

