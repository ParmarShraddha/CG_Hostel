// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_unnecessary_containers, prefer_const_constructors, dead_code, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';
import '../Utils/OutlineBtn.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/reusable_text.dart';


class Y_rec_Leave extends StatefulWidget {
  final userToken;
  const Y_rec_Leave({super.key, this.userToken});

  @override
  State<Y_rec_Leave> createState() => _Y_rec_LeaveState();
}

class _Y_rec_LeaveState extends State<Y_rec_Leave> {

  var userToken;
  var leaveRef;
  var Rec_StatusUpdate ;
  var Stu_StatusUpdate ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userToken = widget.userToken;
    leaveRef = FirebaseDatabase.instance.ref('Rector').child(userToken).child('Leave').orderByChild("timestamp");
    leaveRef.onChildAdded.listen((event){});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: AppConst.brown.shade50,
        appBar: AppBar(
          elevation: 0.1,
          automaticallyImplyLeading: false,
          backgroundColor: AppConst.brown.shade50,
          title:  ReusableText(
              text: "Leave Requests",
              style:appStyle(30, AppConst.brown, FontWeight.bold)),
        ),

        body:Container(
          child: FirebaseAnimatedList(
              defaultChild:
              Column(
                children: [
                  Icon(Icons.incomplete_circle)
                  ,Text('Loading')],
              ),
              query: leaveRef,
              reverse: true,
              itemBuilder: (context, snapshot, animation, index){
                bool rowFlag = "Pending" == snapshot.child("Status").value.toString();
                return Padding(
                  padding: EdgeInsets.all(10),
                    child:Container(
                  decoration:BoxDecoration(
                    color: snapshot.child('Status').value.toString() == "Pending" ? Colors.yellow.shade200 : snapshot.child('Status').value.toString() == "Accepted" ? Colors.green
                        : Colors.redAccent ,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppConst.brown,
                      width: 0.5,
                    ),
                  ),
                  child:  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //type
                              Row(
                                children: [
                                  SizedBox(height: 50,),
                                  ReusableText(text:"Type: ", style: appStyle(20, AppConst.black, FontWeight.bold)),
                                  ReusableText(text: snapshot.child("Type").value.toString(), style: appStyle(20, AppConst.black, FontWeight.w500)),
                                ],
                              ),
                              //from & to
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      ReusableText(text:"From:", style: appStyle(17, AppConst.black, FontWeight.bold)),
                                      ReusableText(text: snapshot.child("From").value.toString(), style: appStyle(15, AppConst.black, FontWeight.normal)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ReusableText(text:"              To:", style: appStyle(17, AppConst.black, FontWeight.bold)),
                                      ReusableText(text: snapshot.child("To").value.toString(), style: appStyle(15, AppConst.black, FontWeight.normal)),
                                    ],
                                  )
                                ],
                              ),

                          ],
                        ),

                      ],),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                      ),
                      ListTile(
                        //name
                        title: Row(
                          children: [
                            ReusableText(text:"  Name:", style: appStyle(20, AppConst.black, FontWeight.bold)),
                            ReusableText(text: snapshot.child("Name").value.toString(), style: appStyle(16, AppConst.black,FontWeight.w700)),
                          ],
                        ),
                        subtitle:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //reason
                            Row(
                              children: [
                                ReusableText(text:"  Reason:", style: appStyle(16, AppConst.black, FontWeight.bold)),
                                ReusableText(text: snapshot.child("Reason").value.toString(), style: appStyle(14, AppConst.black,FontWeight.w500)),
                              ],
                            ),
                            //place
                            Row(
                              children: [
                                ReusableText(text:"  Place:", style: appStyle(16, AppConst.black, FontWeight.bold)),
                                ReusableText(text: snapshot.child("Place").value.toString(), style: appStyle(14, AppConst.black,FontWeight.w500)),
                              ],
                            ),
                          ],
                        )
                      ),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                      ),
                      rowFlag? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 2*h,right: 2*w),
                            child: CustomOtlnBtn(
                                width: 20*w,
                                height: 5*h,
                                buttonColor: AppConst.white,
                                buttonBorderColor: AppConst.black,
                                onPress: (){
                                  bool flag1 = false, flag2 = false;
                                  Rec_StatusUpdate =FirebaseDatabase.instance.ref('Rector').child(userToken).child('Leave').child(snapshot.key.toString());
                                  Rec_StatusUpdate.update({
                                    "Status" : "Rejected"
                                  }).then((_){
                                    flag1 = true;
                                  }).catchError((error){
                                    });

                                  Stu_StatusUpdate = FirebaseDatabase.instance.ref("Girls").child(snapshot.child('girlUserToken').value.toString()).child("Leave").child(snapshot.child("s_leaveId").value.toString());
                                  Stu_StatusUpdate.update({
                                    "Status" : "Rejected"
                                  }).then((_){
                                    }).catchError((error){
                                     });
                                  setState(() {
                                    if(flag1 && flag2){
                                      rowFlag = false;
                                    }
                                    else{
                                      rowFlag = true;
                                    }
                                  });
                                },
                                buttonName: 'Reject',
                                buttonTextColor: Colors.black),
                          ),

                          Padding(
                            padding:  EdgeInsets.only(bottom: 2*h,right: 2*w),
                            child: CustomOtlnBtn(
                                width: 20*w,
                                height: 5*h,
                                buttonColor: AppConst.white,
                                buttonBorderColor: AppConst.black,
                                onPress: (){
                                  bool flag1 = false, flag2 = false;
                                  Rec_StatusUpdate =FirebaseDatabase.instance.ref('Rector').child(userToken).child('Leave').child(snapshot.key.toString());
                                  Rec_StatusUpdate.update({
                                    "Status" : "Accepted"
                                  }).then((_){
                                    flag1 = true;
                                  }).catchError((error){
                                    });

                                  Stu_StatusUpdate = FirebaseDatabase.instance.ref("Girls").child(snapshot.child('girlUserToken').value.toString()).child("Leave").child(snapshot.child("s_leaveId").value.toString());
                                  Stu_StatusUpdate.update({
                                    "Status" : "Accepted"
                                  }).then((_){
                                    flag2 = true;
                                   }).catchError((error){
                                     });
                                  setState(() {
                                    if(flag1 && flag2){
                                      rowFlag = false;
                                    }
                                    else{
                                      rowFlag = true;
                                    }
                                  });
                                },
                                buttonName: 'Accept',
                                buttonTextColor: AppConst.black),
                          )
                        ],
                      ):Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ReusableText(text: "${snapshot.child("Status").value.toString()}  ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                          SizedBox(height: 30,)
                        ]
                      )

                    ],

                  ) ),);
              }
          ), //FirebaseAnimatedList
        )
    );
  }
}