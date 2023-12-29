// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class S_rector_Profile extends StatefulWidget {
  final userToken;
  const S_rector_Profile({super.key, this.userToken});

  @override
  State<S_rector_Profile> createState() => _S_rector_ProfileState();
}

class _S_rector_ProfileState extends State<S_rector_Profile> {

  var userRef;
  var userToken;
  var userName = "...";
  var userEmail= "...";
  var userHostel= "...";
  var userMobile= "...";
  var rectorRef = FirebaseDatabase.instance.ref('Rector');
  bool set = true;

  @override
  void initState() {
    super.initState();
    userToken = widget.userToken;
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            //color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.menu,size: 30,
            ),
          ),

        ],
      ),
      body:
      Padding(
          padding: const EdgeInsets.all(20.0),
          child:Column(
            children:[
              itemProfile('Name', userName, Icons.person),
              const SizedBox(height: 20),
              itemProfile('Hostel', userHostel, Icons.home),
              const SizedBox(height: 20),
              itemProfile('Mobile Number', userMobile, Icons.phone),
              const SizedBox(height: 20),
              itemProfile('Email', userEmail, Icons.email_outlined),

            ],)
      ),
    );
  }
  itemProfile(String title, String subtitle, IconData iconData){
    subtitle ??= "N/A"; // Provide a default value if subtitle is null
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0,5),
            color: Colors.deepOrange.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        title:  Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
      ),
    );
  }

  void getUserData() async{
    final snapshot = await rectorRef.child(widget.userToken).get();
    if (snapshot.exists) {
      setState(() {
        userName = snapshot.child('Name').value.toString();
        userEmail = snapshot.child('Email').value.toString();
        userHostel = snapshot.child('Hostel').value.toString();
        userMobile = snapshot.child('Mobile Number').value.toString();
      });
    }

  }

}
