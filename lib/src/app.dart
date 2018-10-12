import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'dart:convert';
import 'widgets/image_list.dart';

class App extends StatelessWidget  {

//function to fetch data from API / Internet
  Future<List<ImageModel>>  fetchImage() async{
    var response = await get('https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=English%20Premier%20League');
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON

     return parsePosts(response.body);
     
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }  
  }

  List<ImageModel> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody)['teams'].cast<Map<String, dynamic>>();
 
  return parsed.map<ImageModel>((json) => ImageModel.fromJson(json)).toList();
}

  Widget build(context){
     return MaterialApp (
      home: Scaffold(
        body:  Center(
          child:FutureBuilder<List<ImageModel>>(
            future: fetchImage(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ImageModel> images = snapshot.data;
                print(images);
                return ImageList(images);

              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
        appBar: AppBar(
          title: Text('English premier league'),
        ),
      )
  );

  }
}