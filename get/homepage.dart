import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getget/model.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SamplePosts> sampleposts =[];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context,snapshot){
        if(snapshot.hasData) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                  height: 130,
                  color: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('User id: ${sampleposts[index].userId}', style: TextStyle(fontSize: 18),),
                      Text(' id: ${sampleposts[index].id}', style: TextStyle(fontSize: 18),),
                      Text('Title: ${sampleposts[index].title}', style: TextStyle(fontSize: 18),),
                      Text('Body: ${sampleposts[index].body}',maxLines: 1, style: TextStyle(fontSize: 18),),






                        ],
                  )
              );
            },

          );
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }

      }

    );
  }
  Future<List<SamplePosts>> getData()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data =jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map <String,dynamic>index in data){
        sampleposts.add(SamplePosts.fromJson(index));
      }
      return sampleposts;
    }else{
      return sampleposts;
    }

  }
}
