// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types, non_constant_identifier_names, unnecessary_new

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class S_mess_editFood extends StatefulWidget {
  final userToken;
  const S_mess_editFood({super.key, this.userToken});

  @override
  State<S_mess_editFood> createState() => _S_mess_editFoodState();
}

class _S_mess_editFoodState extends State<S_mess_editFood> {

  var userRef;
  var userToken;
  var breakfast = "...";
  var breakfast_drink = "...";
  var lunch= "...";
  var dinner= "...";
  var messRef = FirebaseDatabase.instance.ref('Mess');
  var messFoodRef;
  FocusNode myFocusNode = FocusNode();
  TextEditingController breakfastController = new TextEditingController();
  TextEditingController breakfast_drinkController = new TextEditingController();
  TextEditingController lunch_Controller1 = new TextEditingController();
  TextEditingController lunch_Controller2 = new TextEditingController();
  TextEditingController dinner_controller1 = new TextEditingController();
  TextEditingController dinner_controller2 = new TextEditingController();

  bool set = true;

  @override
  void initState() {
    super.initState();
    userToken = widget.userToken;
    messFoodRef = FirebaseDatabase.instance.ref('Mess').child(userToken);

    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menu',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              //color: Colors.black87,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(child:
          Padding(
            padding: const EdgeInsets.all(20.0),
            child:Column(
              children:[
                SizedBox(
                  height: 500,
                  child: FirebaseAnimatedList(
                    query:messFoodRef ,
                    itemBuilder: (context, snapshot, animation, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Breakfast:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: TextFormField(
                                  autofocus: false,
                                  controller: breakfastController,
                                  decoration:  InputDecoration(
                                    hintText: snapshot.child('breakfast').value.toString(),hintStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),

                                  ),
                                ),
                              ),
                              IconButton(onPressed: () {
                                var tempRef = FirebaseDatabase.instance.ref('Mess').child(userToken).child('FoodMenu');
                                tempRef.update({
                                  "breakfast" : breakfastController.text.toString()
                                }).then((value) {
                                  myFocusNode.unfocus();
                                });}, icon: const Icon(Icons.done))
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: TextFormField(
                                  autofocus: false,
                                  controller: breakfast_drinkController,
                                  decoration:  InputDecoration(
                                    hintText: snapshot.child('breakfast_drink').value.toString(),hintStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),

                                  ),
                                ),
                              ),
                              IconButton(onPressed: () {
                                var tempRef = FirebaseDatabase.instance.ref('Mess').child(userToken).child('FoodMenu');
                                tempRef.update({
                                  "breakfast_drink" : breakfast_drinkController.text.toString()
                                }).then((value) {                            myFocusNode.unfocus();
                                });}, icon: const Icon(Icons.done))
                            ],
                          ),
                          const SizedBox(height: 40,),
                          const Text('Lunch:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: TextFormField(
                                  controller: lunch_Controller1,
                                  autofocus: false,
                                  maxLines:3,
                                  decoration:  InputDecoration(
                                    hintText: snapshot.child('lunch').value.toString(),hintStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),

                                  ),
                                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                                ),
                              ),
                              IconButton(onPressed: () {
                                var tempRef = FirebaseDatabase.instance.ref('Mess').child(userToken).child('FoodMenu');
                                tempRef.update({
                                  "lunch" : lunch_Controller1.text.toString()
                                }).then((value) {myFocusNode.unfocus();
                                });}, icon: const Icon(Icons.done))
                            ],
                          ),
                          const SizedBox(height: 40,),
                          const Text('Dinner:',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: TextFormField(
                                  focusNode: myFocusNode,
                                  autofocus: false,
                                  maxLines:3,
                                  controller: dinner_controller1,
                                  decoration:  InputDecoration(
                                    hintText: snapshot.child('dinner').value.toString(),hintStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),

                                  ),
                                ),
                              ),
                              IconButton(onPressed: () {
                                var tempRef = FirebaseDatabase.instance.ref('Mess').child(userToken).child('FoodMenu');
                                tempRef.update({
                                  "dinner" : dinner_controller1.text.toString()
                                }).then((value) {
                                  myFocusNode.unfocus();
                                });
                              }, icon: const Icon(Icons.done))
                            ],
                          ),

                        ],
                      );
                    },),
                )
              ],)
        ),),
      )
      ,
    );

  }

  void getUserData() async{
    final snapshot = await messFoodRef.child(widget.userToken).get();
    if (snapshot.exists) {
      setState(() {
        breakfast = snapshot.child('breakfast').value.toString();
        breakfast_drink = snapshot.child('breakfast_drink').value.toString();
        lunch = snapshot.child('lunch').value.toString();
        dinner = snapshot.child('dinner').value.toString();

      });
    }

  }

}
