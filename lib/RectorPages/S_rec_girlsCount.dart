// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types, non_constant_identifier_names, unnecessary_new

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Utils/AppConst.dart';

class S_rec_girlsCount extends StatefulWidget {
  final userToken;
  const S_rec_girlsCount({super.key, this.userToken});

  @override
  State<S_rec_girlsCount> createState() => _S_rec_girlsCountState();
}

class _S_rec_girlsCountState extends State<S_rec_girlsCount> {

  var userRef;
  var userToken;
  var girlsCount;
  FocusNode myFocusNode = FocusNode();
  var recRef = FirebaseDatabase.instance.ref('Rector');
  TextEditingController girlsCountController = TextEditingController();
 

  bool set = true;

  @override
  void initState() {
    super.initState();
    userToken = widget.userToken;
    girlsCount = FirebaseDatabase.instance.ref('Rector').child(userToken).child('Count');

    getUserData();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    girlsCountController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        girlsCountController.dispose(); // Dispose the controller when leaving the page
        return true;
      },
      child:       Scaffold(
        appBar: AppBar(
          title: const Text("Total Girls",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              //color: Colors.black87,
            ),
          ),
          centerTitle: true,
        ),
        body:
        SingleChildScrollView(child:
        Padding(
            padding: const EdgeInsets.all(20.0),
            child:Column(
              children:[
                FutureBuilder<DatabaseEvent>(
                  future: recRef.child(userToken).child('Count').once(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Fetching current count...'); // Display a loading message
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final currentSnapshot = snapshot.data?.snapshot;
                      if (currentSnapshot != null) {
                        final currentCount = currentSnapshot.value.toString();
                        return Text('Current Count  : $currentCount');
                      } else {
                        return Text('No data available');
                      }
                    } else {
                      return Text('No data available');
                    }
                  },
                ),
                SizedBox(
                  child:
                  TextFormField(
                    controller: girlsCountController,
                    decoration: InputDecoration(
                      hintText:"Enter girls count",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                            color: AppConst.brown,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                            color: AppConst.brown,
                          )
                      ),
                    ),
                  ),

                ),
                ElevatedButton(
                  onPressed: () {
                    if(girlsCountController.text.isNotEmpty)
                    {
                      recRef.child(userToken).child('Count').set(girlsCountController.text);
                      girlsCountController.clear();
                      Fluttertoast.showToast(msg: 'Count Updated'

                      );
                      setState(() {

                      });
                    }
                  },
                  child: Text('Update'),
                ),
                // Text('Current Count: ${girlsCountController.text}'), // Display the entered value



              ],)
        ),),
      )

    );
  }


  void getUserData() {
    recRef.child(userToken).child('Count').once().then((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        setState(() {
          girlsCountController.text = event.snapshot.value.toString();
        });
      }
    });
  }

}
