import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
   Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void addData() async {
    var user = {
      "name": nameController.text,
      "email": emailController.text
    };
    await FirebaseFirestore.instance.collection("user").add(user);
    print("data added");
    nameController.clear();
    emailController.clear();
  }
  void deleteData(String docId) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(docId)
        .delete();
        print("data deleted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding:EdgeInsets.all(10.0),
            child: TextField(
              controller: nameController,
              decoration:InputDecoration(
                labelText: "Enter name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.all(10.0),
            child: TextField(
              controller: emailController,
              decoration:InputDecoration(
                labelText: "Enter email",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: addData,
            child:  Text("Add"),
          ),
         SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("user").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return  CircularProgressIndicator();
                }
                else{
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return ListTile(
                        title: Text(doc['name']),
                        subtitle: Text(doc['email']),
                        trailing: ElevatedButton(  onPressed: () => deleteData(doc.id), child: Text("delete user"))     
                        );
                  }).toList(),
                );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
