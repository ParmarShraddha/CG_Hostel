// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';
import '../Utils/reusable_text.dart';
import 'Y_addLeave.dart';

class S_stu_leave extends StatefulWidget {
  final userToken;
  const S_stu_leave({super.key, required this.userToken});

  @override
  State<S_stu_leave> createState() => _S_stu_leaveState();
}

class _S_stu_leaveState extends State<S_stu_leave> {
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
        .child('Leave');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        automaticallyImplyLeading: false,
        backgroundColor: AppConst.brown.shade50,
        title:  ReusableText(
            text: "Leaves",
            style:appStyle(30, AppConst.brown, FontWeight.bold)),
      ),

      bottomNavigationBar: BottomAppBar(

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Align the Row to the end (right side)
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddLeave(userToken: userToken)));
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Status: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                Text(snapshot.child("Status").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                              Column(
                                  children: [
                                    Row(children: [
                                      Text('Type: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("Type").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],),
                                    Row(children: [
                                      Text('Place: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                                      Text(snapshot.child("Place").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                                    ],)
                                  ],
                                ),
                                Column(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Text('Reason: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                              Text(snapshot.child("Reason").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,),
                            ],),
                          ],
                        ),

                  //     Column(
                  //       children: [
                  //         Row(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text('Type: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                  //             Flexible(child:Text(snapshot.child("Type").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,)),
                  //           ],
                  //         ),
                  //
                  //         Column(
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Text('From: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                  //                 Flexible(child:Text(snapshot.child("From").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,)),
                  //
                  //               ],
                  //             ),
                  //             Row(
                  //              children: [
                  //                Text('start date',style: appStyle(16, AppConst.black, FontWeight.bold)),
                  //                Flexible(child:Text(snapshot.child("To").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,)),
                  //              ],
                  //            ),
                  //             Row(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text('Reason: ',style: appStyle(16, AppConst.black, FontWeight.bold),),
                  //                 Flexible(child:Text(snapshot.child("Reason").value.toString(),style: appStyle(14, AppConst.black, FontWeight.normal),softWrap: true,)),
                  //               ],
                  //             ),
                  //            ],
                  //         ),
                  //
                  //     Row(
                  //       children: [
                  //         Text('To: ',style: appStyle(14, AppConst.black, FontWeight.bold),),
                  //         Text('end date',style: appStyle(14, AppConst.black, FontWeight.normal)),
                  //           ],
                  //         )
                  //   // Column(
                  //   //   children: [
                  //   //     Text("Type: ${snapshot.child("Type").value.toString()}",style: TextStyle(fontSize: 20)),
                  //   //     Text("Place: ${snapshot.child("Place").value.toString()}"),
                  //   //     Text("Reason: ${snapshot.child("Reason").value.toString()}"),
                  //   //     Text("From: ${snapshot.child("From").value.toString()}"),
                  //   //     Text("To: ${snapshot.child("To").value.toString()}"),
                  //   //   ],
                  //   // )
                  // ]
                  //     ),
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
