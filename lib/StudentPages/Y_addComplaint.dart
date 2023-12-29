// ignore_for_file: duplicate_import, camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, non_constant_identifier_names, prefer_const_constructors, empty_catches, unused_catch_stack

import 'package:cg_hostel/Utils/AppConst.dart';
import 'package:cg_hostel/Utils/SizeConfig.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'P_studentHomePage.dart';
import '../Utils/AppConst.dart';
import '../Utils/OutlineBtn.dart';

class add_Complaint extends StatefulWidget {
  final userToken;
  add_Complaint({super.key, required this.userToken});

  @override
  State<add_Complaint> createState() => _add_ComplaintState();
}

class _add_ComplaintState extends State<add_Complaint> {
  String ProblemType = 'Problem';

  var complaintController =TextEditingController();
  List<String> items = [
    'Problem',
    'Other',
    'Plumbing',
    'Cleaning',
    'Wi-Fi',
    'Electric'
  ];
  var studentcomplaint ;
  var H1complaint ;
  var H2complaint ;
  var H3complaint ;
  var H4complaint ;
  var H5complaint ;
  var userToken ;
  var userRoomNo ;
  var userName = "...";
  var userHostel= "...";
  var girlsRef = FirebaseDatabase.instance.ref('Girls');
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userToken = widget.userToken;
    getUserData();
    studentcomplaint = FirebaseDatabase.instance.ref('Girls').child(userToken).child('complaint');
    H1complaint = FirebaseDatabase.instance.ref('Rector').child("6AJIxeNWFINGvYNG44IbLNDHMLC3").child('complaint');
    H2complaint = FirebaseDatabase.instance.ref('Rector').child("HLVHpHpdM5XQiuNp9NmR8dN0vGA3").child('complaint');
    H3complaint = FirebaseDatabase.instance.ref('Rector').child("Yit3cgMRveZPso9iu8GhFMWQkKX2").child('complaint');
    H4complaint = FirebaseDatabase.instance.ref('Rector').child("Ow2stbx0QvUKbUgnes3kthums5Q2").child('complaint');
    H5complaint = FirebaseDatabase.instance.ref('Rector').child("LgC0lekzzWT9AQAuyLNmtgFFl5M2").child('complaint');
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppConst.brown.shade50,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5*w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextField(
              controller: complaintController,
              maxLength: 30,
              minLines: 1,
              decoration: InputDecoration(
                labelText: 'Place your complaint',
                prefixIcon: const Icon(Icons.comment,color: AppConst.brown,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                //hintText: 'Place your Complaint',
              ),
            ),

            DropdownButton(
              value: ProblemType,
              icon: const Icon(Icons.keyboard_arrow_down,color: AppConst.brown,),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items,style: TextStyle(color: AppConst.brown),),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  ProblemType = newValue!;
                });
              },
            ),

            SizedBox(height: 5*h),

            CustomOtlnBtn(
                width: double.infinity,
                height: 5.5*h,
                buttonColor: AppConst.brown,
                buttonBorderColor: AppConst.white,
                buttonName: 'SUBMIT',
                buttonTextColor: AppConst.white,
                onPress: (){
                  if(ProblemType.toString() !="Problem" && ProblemType.toString().isNotEmpty && complaintController.text.toString().isNotEmpty)
                  {
                    DateTime currentDateTime = DateTime.now();
                    String formattedDate = DateFormat('yyyy-MM-dd').format(currentDateTime);

                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title:const Text('Submit ?') ,
                        actions: [
                          TextButton(
                            child: const Text('Close'),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },),
                          TextButton(
                            child:const Text('Confirm'),onPressed: ()
                          {
                            var s_complaint = studentcomplaint.push();
                            var r1_complaint = H1complaint.push();
                            var r2_complaint = H2complaint.push();
                            var r3_complaint = H3complaint.push();
                            var r4_complaint = H4complaint.push();
                            var r5_complaint = H5complaint.push();
                            String complaintId = s_complaint.key;
                            String r1_complaintId = r1_complaint.key;
                            String r2_complaintId = r2_complaint.key;
                            String r3_complaintId = r3_complaint.key;
                            String r4_complaintId = r4_complaint.key;
                            String r5_complaintId = r5_complaint.key;

                            if(userHostel =="H1"){
                              try{
                                s_complaint.set({
                                  'r_complaintId':r1_complaintId,
                                  'Complaint' : complaintController.text.toString(),
                                  'Type' : ProblemType.toString(),
                                  'Status':'Pending',
                                  'Date' : formattedDate,
                                });
                                r1_complaint.set({
                                  's_complaintId':complaintId,
                                  'Complaint' : complaintController.text.toString(),
                                  'Type' : ProblemType.toString(),
                                  'Status':'Pending',
                                  'Name':userName.toString(),
                                  'Room No':userRoomNo.toString(),
                                  'Date' : formattedDate,
                                  'girlUserToken':userToken.toString(),
                                });
                              }
                              catch (e,stackTrace){

                              }

                            }
                            else if(userHostel == "H2"){
                              s_complaint.set({
                                'r_complaintId':r2_complaintId,
                                'Complaint' : complaintController.text.toString(),
                                'Type' : ProblemType.toString(),
                                'Status':'Pending',
                                'Date' : formattedDate,
                              });
                              r2_complaint.set({
                                's_complaintId':complaintId,
                                'Complaint' : complaintController.text.toString(),
                                'Type' : ProblemType.toString(),
                                'Status':'Pending',
                                'Name':userName.toString(),
                                'Room No':userRoomNo.toString(),
                                'Date' : formattedDate,
                                'girlUserToken':userToken.toString(),

                              });
                            }
                            else if(userHostel == "H3"){
                              s_complaint.set({
                                'r_complaintId':r3_complaintId,
                                'Complaint' : complaintController.text.toString(),
                                'Type' : ProblemType.toString(),
                                'Status':'Pending',
                                'Date' : formattedDate,

                              });
                              r3_complaint.set({
                                's_complaintId':complaintId,
                                'Complaint' : complaintController.text.toString(),
                                'Type' : ProblemType.toString(),
                                'Status':'Pending',
                                'Name':userName.toString(),
                                'Room No':userRoomNo.toString(),
                                'Date' : formattedDate,
                                'girlUserToken':userToken.toString(),


                              });
                            }
                            else if(userHostel == "H4"){
                              s_complaint.set({
                                'r_complaintId':r4_complaintId,
                                'Complaint' : complaintController.text.toString(),
                                'Type' : ProblemType.toString(),
                                'Status':'Pending',
                                'Date' : formattedDate,

                              });
                              r4_complaint.set({
                                's_complaintId':complaintId,
                                'Complaint' : complaintController.text.toString(),
                                'Type' : ProblemType.toString(),
                                'Status':'Pending',
                                'Name':userName.toString(),
                                'Room No':userRoomNo.toString(),
                                'Date' : formattedDate,
                                'girlUserToken':userToken.toString(),


                              });
                            }
                            else if(userHostel == "H5"){
                              s_complaint.set({
                                'r_complaintId':r5_complaintId,
                                'Complaint' : complaintController.text.toString(),
                                'Type' : ProblemType.toString(),
                                'Status':'Pending',
                                'Date' : formattedDate,

                              });
                              r5_complaint.set({
                                's_complaintId':complaintId,
                                'Complaint' : complaintController.text.toString(),
                                'Type' : ProblemType.toString(),
                                'Status':'Pending',
                                'Name':userName.toString(),
                                'Room No':userRoomNo.toString(),
                                'Date' : formattedDate,
                                'girlUserToken':userToken.toString(),

                              });
                            }
                            else{
                              Fluttertoast.showToast(
                                  msg: "Something went wrong",
                                  backgroundColor: CupertinoColors.activeGreen,
                                  textColor: Colors.white);
                            }
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>studentHome(userToken:userToken)), (route) => false);
                            Fluttertoast.showToast(
                                msg: "complaint Requested",
                                backgroundColor: CupertinoColors.activeGreen,
                                textColor: Colors.white);
                          },
                          )
                        ],
                      );
                    },);
                  }
                  else{
                    Fluttertoast.showToast(msg: 'Fill all details',backgroundColor: Colors.red,textColor: Colors.white);
                  }
                },
               )
          ],
        ),


      ),
    );
  }
  void getUserData() async{
    final snapshot = await girlsRef.child(widget.userToken).get();
    if (snapshot.exists) {
      setState(() {
        userName = snapshot.child('userName').value.toString();
        userHostel = snapshot.child('hostelNo').value.toString();
        userRoomNo = snapshot.child('roomNo').value.toString();
      });
    }

  }
}