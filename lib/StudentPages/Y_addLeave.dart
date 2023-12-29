// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_local_variable, unused_catch_stack, empty_catches
import 'package:cg_hostel/Utils/AppConst.dart';
import 'package:cg_hostel/Utils/SizeConfig.dart';
import 'package:cg_hostel/Utils/reusable_text.dart';
import 'package:cg_hostel/StudentPages/P_studentHomePage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_calender_picker/custom_calender_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../Utils/AppStyle.dart';
import '../Utils/OutlineBtn.dart';

class AddLeave extends StatefulWidget {
  final userToken;
  const AddLeave({super.key, required this.userToken});

  @override
  State<AddLeave> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<AddLeave> {

  DateTimeRange? rangeDateTime;
  var placeController =TextEditingController();
  var reasonController =TextEditingController();
  var studentLeave ;
  var H1Leave ;
  var H2Leave ;
  var H3Leave ;
  var H4Leave ;
  var H5Leave ;
  var userToken ;
  var userRoomNo ;
  var userName = "...";
  var userHostel= "...";
  var girlsRef = FirebaseDatabase.instance.ref('Girls');
  String selectedType = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userToken = widget.userToken;
    getUserData();
    studentLeave = FirebaseDatabase.instance.ref('Girls').child(userToken).child('Leave');
    H1Leave = FirebaseDatabase.instance.ref('Rector').child("6AJIxeNWFINGvYNG44IbLNDHMLC3").child('Leave');
    H2Leave = FirebaseDatabase.instance.ref('Rector').child("HLVHpHpdM5XQiuNp9NmR8dN0vGA3").child('Leave');
    H3Leave = FirebaseDatabase.instance.ref('Rector').child("Yit3cgMRveZPso9iu8GhFMWQkKX2").child('Leave');
    H4Leave = FirebaseDatabase.instance.ref('Rector').child("Ow2stbx0QvUKbUgnes3kthums5Q2").child('Leave');
    H5Leave = FirebaseDatabase.instance.ref('Rector').child("LgC0lekzzWT9AQAuyLNmtgFFl5M2").child('Leave');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.brown.shade50,

      body:
     Center(child:
     SingleChildScrollView(
        child:
      Column(
        // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Padding(
        padding: EdgeInsets.symmetric(horizontal: 5*w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: placeController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.place,color: AppConst.brown,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Place',
              ),
            ),
            SizedBox(
              height: 2*h,
            ),

            TextField(
              controller: reasonController,
              maxLength: 30,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.question_mark,color: AppConst.brown,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Reason',
              ),
            ),
            SizedBox(
              height: 5*h,
            ),
            Column(
              children: [
                const Text(
                  'Type: ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: 100*w,
                    height: 8*h,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //home
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Home',
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() {
                                  selectedType = value!;
                                });
                              },
                            ),
                            const Text('Home',style: TextStyle(fontSize: 11)),
                          ],
                        ),
                        //Sunday
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Sunday',
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() {
                                  selectedType = value!;
                                });
                              },
                            ),
                            const Text('Sunday',style: TextStyle(fontSize: 11)),
                          ],
                        ),
                        //Thursday
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Thurday',
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() {
                                  selectedType = value!;
                                });
                              },
                            ),
                            const Text('Thurday',style: TextStyle(fontSize: 11)),
                          ],
                        ),
                        //other
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Other',
                              groupValue: selectedType,
                              onChanged: (value) {
                                setState(() {
                                  selectedType = value!;
                                });
                              },
                            ),
                            const Text('Other',style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ],),
                  ),
                )

                    ],
            ),

            SizedBox(
              height: 5*h,
            ),

            CustomOtlnBtn(
                onPress: () async {
                  var result = await showModalBottomSheet(
                    isScrollControlled: true,

                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.zero,
                      ),
                    ),
                    context: context,
                    builder: (context) => CustomCalenderPicker(
                      returnDateType: ReturnDateType.range,
                      initialDateRange: rangeDateTime,
                      calenderThema: CalenderThema.white,
                      rangeColor: Colors.brown.shade50,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.zero,
                      ),
                    ),
                  );
                  if (result != null) {
                    if (result is DateTimeRange) {
                      setState(() {
                        rangeDateTime = result;

                      });
                    }
                  }
               },
                width: 50*w,
                height: 5.5*h,
                buttonColor: AppConst.brown,
                buttonBorderColor: AppConst.white,
                buttonName: 'Select Date Range',
                buttonTextColor: AppConst.white
            ),
            SizedBox(height: 2*h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ReusableText(
                        text: 'From Date:',
                        style: appStyle(17, AppConst.black, FontWeight.bold)),

                    ReusableText(
                      text: rangeDateTime == null
                          ? ''
                          : DateFormat('dd-MM-yyyy').format(rangeDateTime!.start),
                      style: appStyle(17, AppConst.black, FontWeight.normal),
                    )
                  ],
                ),

                Column(
                  children: [

                    ReusableText(
                      text: 'To Date:',
                      style: appStyle(17, AppConst.black, FontWeight.bold),
                    ),

                    ReusableText(
                      text: rangeDateTime == null
                          ? ''
                          : DateFormat('dd-MM-yyyy').format(rangeDateTime!.end),
                      style: appStyle(17, AppConst.black, FontWeight.normal),
                    )

                  ],
                )
              ],
            ),
            SizedBox(
              height: 5*h,
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: CustomOtlnBtn(
                width: double.infinity,
                height: 5.5*h,
                buttonColor: AppConst.brown,
                buttonBorderColor: AppConst.white,
                buttonName: 'SUBMIT',
                buttonTextColor: AppConst.white,
                onPress: () {
                  if(placeController.text.toString().isNotEmpty &&
                      reasonController.text.toString().isNotEmpty &&
                      rangeDateTime != null &&
                      selectedType.isNotEmpty)
                      {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title:const Text('Request Leave?') ,
                        actions: [
                          TextButton(
                          child: const Text('Close'),
                          onPressed: (){
                            DateTime today = DateTime.now();
                            DateTime dateOnly = DateTime(today.year, today.month, today.day);
                            Navigator.of(context).pop();
                          },),
                          TextButton(
                            child:const Text('Confirm'),onPressed: ()
                          {
                            var s_leave = studentLeave.push();
                            var r1_leave = H1Leave.push();
                            var r2_leave = H2Leave.push();
                            var r3_leave = H3Leave.push();
                            var r4_leave = H4Leave.push();
                            var r5_leave = H5Leave.push();
                            String leaveId = s_leave.key;
                            String r1_leaveId = r1_leave.key;
                            String r2_leaveId = r2_leave.key;
                            String r3_leaveId = r3_leave.key;
                            String r4_leaveId = r4_leave.key;
                            String r5_leaveId = r5_leave.key;

                            String FromDateString = DateFormat('dd-MM-yyyy').format(rangeDateTime!.start);
                            String toDateString = DateFormat('dd-MM-yyyy').format(rangeDateTime!.end);

                              if(userHostel =="H1"){
                                try{
                                  s_leave.set({
                                    'r_leaveId':r1_leaveId,
                                    'Place' : placeController.text.toString(),
                                    'Reason' : reasonController.text.toString(),
                                    'Type' : selectedType.toString(),
                                    'From': FromDateString,
                                    'To': toDateString,
                                    'Status':'Pending',
                                  });
                                  r1_leave.set({
                                    's_leaveId':leaveId,
                                    'Place' : placeController.text.toString(),
                                    'Reason' : reasonController.text.toString(),
                                    'Type' : selectedType.toString(),
                                    'From': FromDateString.toString(),
                                    'To': toDateString.toString(),
                                    'Name':userName.toString(),
                                    'Room No':userRoomNo.toString(),
                                    'Status':'Pending',
                                    'girlUserToken':userToken.toString(),
                                  });
                                }
                                catch (e,stackTrace){
                                }
                              }
                              else if(userHostel == "H2"){
                                s_leave.set({
                                  'r_leaveId':r2_leaveId,
                                  'Place' : placeController.text.toString(),
                                  'Reason' : reasonController.text.toString(),
                                  'Type' : selectedType.toString(),
                                  'From': FromDateString.toString(),
                                  'To': toDateString.toString(),
                                  'Status':'Pending',

                                });
                                r2_leave.set({
                                  's_leaveId':s_leave,
                                  'Place' : placeController.text.toString(),
                                  'Reason' : reasonController.text.toString(),
                                  'Type' : selectedType.toString(),
                                  'From': FromDateString.toString(),
                                  'To': toDateString.toString(),
                                  'Name':userName.toString(),
                                  'Room No':userRoomNo.toString(),
                                  'girlUserToken':userToken.toString(),
                                  'Status':'Pending',


                                });
                              }
                              else if(userHostel == "H3"){
                                s_leave.set({
                                  'r_leaveId':r3_leaveId,
                                  'Place' : placeController.text.toString(),
                                  'Reason' : reasonController.text.toString(),
                                  'Type' : selectedType.toString(),
                                  'From': FromDateString.toString(),
                                  'To': toDateString.toString(),
                                  'Status':'Pending',


                                });
                                r3_leave.set({
                                  's_leaveId':s_leave,
                                  'Place' : placeController.text.toString(),
                                  'Reason' : reasonController.text.toString(),
                                  'Type' : selectedType.toString(),
                                  'From': FromDateString.toString(),
                                  'To': toDateString.toString(),
                                  'Name':userName.toString(),
                                  'Room No':userRoomNo.toString(),
                                  'girlUserToken':userToken.toString(),
                                  'Status':'Pending',


                                });
                              }
                              else if(userHostel == "H4"){
                                s_leave.set({
                                  'r_leaveId':r4_leaveId,
                                  'Place' : placeController.text.toString(),
                                  'Reason' : reasonController.text.toString(),
                                  'Type' : selectedType.toString(),
                                  'From': FromDateString.toString(),
                                  'To': toDateString.toString(),
                                  'Status':'Pending',

                                });
                                r4_leave.set({
                                  's_leaveId':s_leave,
                                  'Place' : placeController.text.toString(),
                                  'Reason' : reasonController.text.toString(),
                                  'Type' : selectedType.toString(),
                                  'From': FromDateString.toString(),
                                  'To': toDateString.toString(),
                                  'Name':userName.toString(),
                                  'Room No':userRoomNo.toString(),
                                  'girlUserToken':userToken.toString(),
                                  'Status':'Pending',

                                });
                              }
                              else if(userHostel == "H5"){
                                s_leave.set({
                                  'r_leaveId':r5_leaveId,
                                  'Place' : placeController.text.toString(),
                                  'Reason' : reasonController.text.toString(),
                                  'Type' : selectedType.toString(),
                                  'From': FromDateString.toString(),
                                  'To': toDateString.toString(),
                                  'Status':'Pending',

                                });
                                r5_leave.set({
                                  's_leaveId':s_leave,
                                  'Place' : placeController.text.toString(),
                                  'Reason' : reasonController.text.toString(),
                                  'Type' : selectedType.toString(),
                                  'From': FromDateString.toString(),
                                  'To': toDateString.toString(),
                                  'Name':userName.toString(),
                                  'Room No':userRoomNo.toString(),
                                  'girlUserToken':userToken.toString(),
                                  'Status':'Pending',


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
                                msg: "Leave Requested",
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
                },),
            )

          ],
        ),
      ),
      ]),
    ),),
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