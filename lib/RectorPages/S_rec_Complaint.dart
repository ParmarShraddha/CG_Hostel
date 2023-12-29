// ignore_for_file: must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors, use_build_context_synchronously, prefer_const_constructors_in_immutables, unnecessary_import, non_constant_identifier_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';
import '../Utils/OutlineBtn.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/reusable_text.dart';

class S_rec_Complaint extends StatefulWidget {
  final userToken;
  S_rec_Complaint({super.key, required this.userToken});

  @override
  State<S_rec_Complaint> createState() => _S_rec_ComplaintState();
}

class _S_rec_ComplaintState extends State<S_rec_Complaint> {
  var userRef = FirebaseDatabase.instance.ref('Rectors');
  var userToken;
  var complaintRef;
  String Status = 'Pending';
  List<String> items = [
    'Soon',
    'Pending',
    'Solved'
  ];
  var Rec_StatusUpdate ;
  var Stu_StatusUpdate ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userToken = widget.userToken;
    complaintRef = FirebaseDatabase.instance
        .ref('Rector')
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 30,
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
                query: complaintRef,
                itemBuilder: (context, snapshot, animation, index) {
                  int rowFlag = snapshot.child('Status').value.toString() == "Pending" ? 2: snapshot.child('Status').value.toString() == "Soon" ? 1 :0;
                  return Column(
                    children:[
                      Container(
                        decoration: BoxDecoration(
                          color: snapshot.child('Status').value.toString() == "Pending" ? Colors.yellow.shade200 : snapshot.child('Status').value.toString() == "Solved" ? Colors.green
                              : Colors.green.shade100 ,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Row(children: [
                                      Text('Type: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("Type").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],),
                                    Row(children: [
                                      Text('Date: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("Date").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],)
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(children: [
                                      Text('Name: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("Name").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],),
                                    Row(children: [
                                      Text('Room No: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("Room No").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],),

                                  ],
                                ),

                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Problem: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                Text(snapshot.child("Complaint").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                              ],),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Status: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                Text(snapshot.child('Status').value.toString()),
                              ],
                            ),
                            Row(

                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                rowFlag == 2?
                                Row(
                                  children: [
                                    CustomOtlnBtn(
                                        width: 20*w,
                                        height: 3.3*h,
                                        buttonColor: AppConst.white,
                                        buttonBorderColor: AppConst.black,
                                        onPress: (){
                                          bool soonflag1 = false, soonflag2 = false;
                                          Rec_StatusUpdate =FirebaseDatabase.instance.ref('Rector').child(userToken).child('complaint').child(snapshot.key.toString());
                                          Rec_StatusUpdate.update({
                                            "Status" : "Soon"
                                          }).then((_){
                                            soonflag1 = true;
                                          }).catchError((error){
                                          });

                                          Stu_StatusUpdate = FirebaseDatabase.instance.ref("Girls").child(snapshot.child('girlUserToken').value.toString()).child("complaint").child(snapshot.child("s_leaveId").value.toString());
                                          Stu_StatusUpdate.update({
                                            "Status" : "Soon"
                                          }).then((_){
                                            soonflag2 = true;

                                          }).catchError((error){
                                          });
                                          setState(() {
                                            if(soonflag1 && soonflag2){
                                              rowFlag = 1;
                                            }
                                          });
                                        },
                                        buttonName: 'Soon',
                                        buttonTextColor: AppConst.black),
                                    SizedBox(width: 10,),
                                    CustomOtlnBtn(
                                        width: 20*w,
                                        height: 3.3*h,
                                        buttonColor: AppConst.white,
                                        buttonBorderColor: AppConst.black,
                                        onPress: (){
                                          bool solvedflag1 = false, solvedflag2 = false;
                                          Rec_StatusUpdate =FirebaseDatabase.instance.ref('Rector').child(userToken).child('complaint').child(snapshot.key.toString());
                                          Rec_StatusUpdate.update({
                                            "Status" : "Solved"
                                          }).then((_){
                                            solvedflag1 = true;
                                          }).catchError((error){
                                          });

                                          Stu_StatusUpdate = FirebaseDatabase.instance.ref("Girls").child(snapshot.child('girlUserToken').value.toString()).child("complaint").child(snapshot.child("s_leaveId").value.toString());
                                          Stu_StatusUpdate.update({
                                            "Status" : "Solved"
                                          }).then((_){
                                            solvedflag2 = true;

                                          }).catchError((error){

                                          });
                                          setState(() {
                                            if(solvedflag1 && solvedflag2){
                                              rowFlag = 0;
                                            }
                                          });
                                        },
                                        buttonName: 'Solved',
                                        buttonTextColor: AppConst.black),
                                  ],
                                ) : rowFlag == 1?
                                Row(
                                  children: [
                                    SizedBox(width: 10,),
                                    CustomOtlnBtn(
                                        width: 20*w,
                                        height: 3.3*h,
                                        buttonColor: AppConst.white,
                                        buttonBorderColor: AppConst.black,
                                        onPress: (){
                                          bool solvedflag1 = false, solvedflag2 = false;
                                          Rec_StatusUpdate =FirebaseDatabase.instance.ref('Rector').child(userToken).child('complaint').child(snapshot.key.toString());
                                          Rec_StatusUpdate.update({
                                            "Status" : "Solved"
                                          }).then((_){
                                            solvedflag1 = true;
                                          }).catchError((error){
                                          });

                                          Stu_StatusUpdate = FirebaseDatabase.instance.ref("Girls").child(snapshot.child('girlUserToken').value.toString()).child("complaint").child(snapshot.child("s_leaveId").value.toString());
                                          Stu_StatusUpdate.update({
                                            "Status" : "Solved"
                                          }).then((_){
                                            solvedflag2 = true;

                                          }).catchError((error){

                                          });
                                          setState(() {
                                            if(solvedflag1 && solvedflag2){
                                              rowFlag = 0;
                                            }
                                          });
                                        },
                                        buttonName: 'Solved',
                                        buttonTextColor: AppConst.black),
                                  ],
                                ): SizedBox(height: 2,),
                                SizedBox(width:10),

                                ],
                            ),
                            SizedBox(height: 10,)
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
