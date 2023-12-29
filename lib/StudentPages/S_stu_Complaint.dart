// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';
import '../Utils/reusable_text.dart';
import 'Y_addComplaint.dart';

class S_stu_Complaint extends StatefulWidget {
  final userToken;
  const S_stu_Complaint({super.key, required this.userToken});

  @override
  State<S_stu_Complaint> createState() => _S_stu_ComplaintState();
}

class _S_stu_ComplaintState extends State<S_stu_Complaint> {
  var userRef = FirebaseDatabase.instance.ref('Girls');
  var userToken;
  var leaveRef;
  bool set = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userToken = widget.userToken;
    leaveRef = FirebaseDatabase.instance
        .ref('Girls')
        .child(userToken)
        .child('complaint');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: AppConst.brown.shade50,
        title:  ReusableText(
            text: "Complaints",
            style:appStyle(30, AppConst.brown, FontWeight.bold)),
      ),

      bottomNavigationBar: BottomAppBar(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Align the Row to the end (right side)
          children: [
            // Spacer(), // This will push the FloatingActionButton to the right
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => add_Complaint(userToken: userToken)));
              },
              child: Icon(Icons.add,size: 35),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 10,
            ),
            Container(
              height: 800,
              width: 350,// Set a fixed height for the FirebaseAnimatedList
              child: FirebaseAnimatedList(
                defaultChild:
                Column(
                  children: [
                    Icon(Icons.incomplete_circle)
                    ,Text('Loading')],
                ),
                query: leaveRef,
                itemBuilder: (context, snapshot, animation, index) {
                  return Column(
                    children:[
                      Container(
                        decoration: BoxDecoration(
                          color: snapshot.child('Status').value.toString() =="Pending"? Colors.yellow.shade100 : snapshot.child('Status').value.toString() =="Soon"? Colors.green.shade200 :Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0,5),
                              color: Colors.brown.withOpacity(.2),
                              spreadRadius: 2,
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child:
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Status: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                Text(snapshot.child('Status').value.toString()),
                              ],
                            ),
                            Column(
                              children: [
                                    Row(children: [
                                      Text('  Type: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("Type").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],),
                                    Row(children: [
                                      Text('  Date: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("Date").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('  Problem: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                        Text(snapshot.child("Complaint").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                      ],),

                              ],
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  );
                },
              ),
            ),
            // Other widgets in your Column
          ],
        ),
      ),
    );
  }
}
