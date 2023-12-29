// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, non_constant_identifier_names, unnecessary_import, avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cg_hostel/MessPages/S_mess_editFood.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Utils/SizeConfig.dart';

class S_mess_foodMenu extends StatefulWidget {
  final userToken;
  S_mess_foodMenu({super.key, required this.userToken});

  @override
  State<S_mess_foodMenu> createState() => _S_mess_foodMenuState();
}

class _S_mess_foodMenuState extends State<S_mess_foodMenu> {

  var userToken;
  var breakfast = "...";
  var breakfast_drink = "...";
  var lunch= "...";
  var dinner= "...";
  var messRef = FirebaseDatabase.instance.ref('Mess');
  var messFoodRef;
  var dayOfWeek;

  @override
  void initState() {
    super.initState();
    userToken = widget.userToken;
    messFoodRef = FirebaseDatabase.instance.ref('Mess').child("tM6JqT7SvUfTJHrPqNTEMP8gbI52");
    DateTime now = DateTime.now();
    dayOfWeek = DateFormat('EEEE').format(now);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Menu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            //color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>S_mess_editFood(userToken: userToken,)));
            },
            icon: const Icon(Icons.edit,size: 30,
            ),
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                child:Text( dayOfWeek, style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),),
              SizedBox(height: 37,),
              Container(
                  height: 800,
                  child:FirebaseAnimatedList(
                    defaultChild:
                    Column(
                      children: [
                        Icon(Icons.incomplete_circle)
                        ,Text('Loading')],
                    ),
                    query: messFoodRef,
                    itemBuilder: (context, snapshot, animation, index) {
                      return Column(
                        children: [
                          SizedBox(height: 2*h,),
                          Container(
                              width : 80*w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0,5),
                                    color: Colors.deepOrange.withOpacity(.2),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child:Padding(
                                padding:EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      Text('Breakfast:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),softWrap: true,),
                                      SizedBox(height: 10,),
                                      Text(snapshot.child('breakfast').value.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),softWrap: true),
                                      Text(snapshot.child('breakfast_drink').value.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),softWrap: true),
                                    ],
                                  ),

                                ),
                              )
                          ),
                          SizedBox(height: 4*h,),
                          Container(
                              width : 80*w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0,5),
                                    color: Colors.deepOrange.withOpacity(.2),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                  )
                                ],


                              ),
                              child:
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child:Column(
                                    children: [
                                      Text('Lunch',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),softWrap: true,),
                                      SizedBox(height: 10,),
                                      Text(snapshot.child('lunch').value.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),softWrap: true),
                                    ],
                                  ),
                                ),
                              )
                          ),
                          SizedBox(height: 20,),
                          Container(
                              width : 80*w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0,5),
                                    color: Colors.deepOrange.withOpacity(.2),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child:Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child:SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child:Column(
                                      children: [
                                        Text('Dinner:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),softWrap: true,),
                                        Text(snapshot.child('dinner').value.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),softWrap: true),
                                      ],
                                    ),
                                  )
                              )
                          ),

                        ],
                      );
                    },

                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
