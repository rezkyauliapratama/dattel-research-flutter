import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'models/image_model.dart';
import 'dart:convert';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return AppState();
    }
}

class AppState extends State<App> {
  int counter = 0 ;
  List<ImageModel> images = [];

//function to fetch data from API / Internet
  void fetchImage() async{
    counter += 1;
    var response = await get("https://jsonplaceholder.typicode.com/photos/$counter");
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    
    setState(() {
    images.add(imageModel);          
        });
  }

  Widget build(context){
     return MaterialApp (
      home: Scaffold(
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          child: Icon(Icons.add), 
        ),
        appBar: AppBar(
          title: Text('Lets see some images!'),
        ),
      )
  );

  }
}