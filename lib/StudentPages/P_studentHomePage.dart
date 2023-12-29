// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, use_build_context_synchronously, prefer_const_constructors, camel_case_types
import 'dart:ui';
import 'package:cg_hostel/StudentPages/S_stu_Complaint.dart';
import 'package:cg_hostel/StudentPages/S_stu_Leave.dart';
import 'package:cg_hostel/StudentPages/S_student_foodMenu.dart';
import 'package:cg_hostel/LoginPages/Y_newLogin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'S_student_Profile.dart';

class studentHome extends StatelessWidget {
  final userToken;
  studentHome({super.key, required this.userToken});
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
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => S_student_Profile(userToken:userToken)));
          }, icon: const Icon(Icons.account_circle))

        ],
      ),

      body:
      SingleChildScrollView(
        child:
          Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            //leave card
            InkWell(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => S_stu_leave(userToken:userToken),));
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
                              AssetImage('assets/leave1.png'),
                              radius: 70,
                            ),
                            Text('Leave',
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

            // complaint card
            InkWell(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => S_stu_Complaint(userToken: userToken),));

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
                              AssetImage('assets/complaint.png'),
                              radius: 70,
                            ),
                            Text('Complaint',
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


            //food card
            InkWell(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => S_stu_foodMenu(userToken: userToken),));
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
              ),)




          ],
        ),
      ),)

    );

  }

}

