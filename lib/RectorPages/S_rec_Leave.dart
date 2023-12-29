// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, non_constant_identifier_names, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';

class S_rec_Leave extends StatefulWidget {
  final userToken;
  S_rec_Leave({super.key, required this.userToken});

  @override
  State<S_rec_Leave> createState() => _S_rec_LeaveState();
}

class _S_rec_LeaveState extends State<S_rec_Leave> {
  var userRef = FirebaseDatabase.instance.ref('Rectors');
  var userToken;
  var leaveRef;
  bool aceept= false;
  var Rec_StatusUpdate ;
  var Stu_StatusUpdate ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userToken = widget.userToken;
    leaveRef = FirebaseDatabase.instance
        .ref('Rector')
        .child(userToken)
        .child('Leave');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
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
                  bool rowFlag = "Pending" == snapshot.child('Status').value.toString();
                  return Column(
                    children:[
                      Container(
                        decoration: BoxDecoration(
                          color: snapshot.child('Status').value.toString() == "Pending" ? Colors.yellow.shade200 : snapshot.child('Status').value.toString() == "Accepted" ? Colors.green : Colors.red ,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //type
                                Row(
                                  children: [
                                    Text('  Type: ',style: appStyle(18, AppConst.black, FontWeight.bold),),
                                    Text(snapshot.child("Type").value.toString(),style: appStyle(16, AppConst.black, FontWeight.normal),softWrap: true,),
                                  ],
                                ),
                                //iconButtons
                                rowFlag ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(onPressed: (){
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
                                    }, icon: Icon(Icons.check_circle_outline, size: 30,)),
                                    IconButton(onPressed: (){
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
                                    }, icon: Icon(Icons.cancel_outlined, size: 30)),
                                  ],
                                ): SizedBox(),
                              ],
                            ),
                            //place
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text('  Place: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                Text(snapshot.child("Place").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),                              ],
                             ),
                            //reason
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('  Reason: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                Text(snapshot.child("Reason").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                              ],),
                            //name room from to
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Row(children: [
                                      Text('Name: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("Name").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],),
                                    Row(children: [
                                      Text('Room No: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("Room No").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text('From: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("From").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],),
                                    Row(children: [
                                      Text('To: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("To").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],),

                                  ],
                                ),

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
