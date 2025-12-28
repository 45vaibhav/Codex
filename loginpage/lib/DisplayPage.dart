import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Displaypage extends StatefulWidget {
  final List<QueryDocumentSnapshot> data;
   Displaypage({super.key, required this.data});

  @override
  State<Displaypage> createState() => _DisplaypageState();
}

class _DisplaypageState extends State<Displaypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display page"),
      ),
        body: ListView.builder(
          itemCount:widget. data.length,
          itemBuilder: (context,index){
            final user=widget.data[index];
              return ListTile( 
                title: Text("Name : ${user['name']}"),
               subtitle: Text("Name : ${user['email']}"),
              );
          }),
    );
  }
}