// ignore_for_file: must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously, file_names

import 'dart:ui';
import 'package:cg_hostel/MessPages/S_mess_foodMenu.dart';
import 'package:cg_hostel/LoginPages/Y_newLogin.dart';
import 'package:cg_hostel/MessPages/S_mess_girlsCount.dart';
import 'package:cg_hostel/MessPages/S_mess_girlsCount.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class S_mess_Home extends StatelessWidget {
  final userToken;
  S_mess_Home({super.key, required this.userToken});
  double fem = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(//backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Home',style: TextStyle(fontWeight: FontWeight.bold,//color: Colors.black87, ),
          )),
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  showDialog(context: context, builder:(context){
                    return AlertDialog(
                      title: const Text('Log out'),
                      content: Text("Are you sure to logout?"),
                      actions: [
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: const Text("Cancel",style: TextStyle(color: Colors.black),)),
                        TextButton(onPressed: () async{
                          var pref = await SharedPreferences.getInstance();
                          pref.setBool('LogIn', false);
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Y_newLogin(),), (route) => false);
                        }, child: const Text("Confirm",style: TextStyle(color: Colors.red),))
                      ],
                    );
                  });
                  // Add your action code here
                },
                icon: Transform.rotate(
                  angle: 3.14159265359, // 180 degrees in radians
                  child: const Icon(Icons.logout_rounded),
                ),
              )          ],
          ),
          centerTitle: true,
        ),

        body:
        SingleChildScrollView(
          child:
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [

                //food card
                InkWell(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => S_mess_foodMenu(userToken: userToken),));
                  },
                  child:SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.brown.shade100,
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 6,sigmaY: 6),
                          child: const Padding(
                            padding:  EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                //const SizedBox(height: 15),
                                CircleAvatar(
                                  backgroundColor: Colors.greenAccent,
                                  backgroundImage:
                                  AssetImage('assets/food1.png'),
                                  radius: 70,
                                ),
                                Text('Food Menu',
                                  style: TextStyle(
                                    fontSize: 29,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),),
                const SizedBox(height: 15),
                InkWell(
                  onTap:(){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => S_mess_girlsCount(userToken: userToken),));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => S_mess_girlsCount(userToken: userToken),));

                  },
                  child:SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.brown.shade100,
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: 6,sigmaY: 6),
                          child: const Padding(
                            padding:  EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                //const SizedBox(height: 15),
                                CircleAvatar(
                                  backgroundColor: Colors.greenAccent,
                                  backgroundImage:
                                  AssetImage('assets/attendance1.jpeg'),
                                  radius: 70,
                                ),
                                Text('Girls Count',
                                  style: TextStyle(
                                    fontSize: 29,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),),





              ],
            ),
          ),)

    );

  }

}

