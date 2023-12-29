import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/reusable_text.dart';

class S_mess_girlsCount extends StatefulWidget {
  final userToken;
  S_mess_girlsCount({super.key, required this.userToken});

  @override
  State<S_mess_girlsCount> createState() => _S_mess_girlsCountState();
}

class _S_mess_girlsCountState extends State<S_mess_girlsCount> {
  var userToken;
  var recRef;
  String formattedToday = '';
  String formattedTodayWithDay = ''; // Declare formattedTodayWithDay variable

  @override
  void initState() {
    super.initState();
    userToken = widget.userToken;
    recRef = FirebaseDatabase.instance.ref('Rector');
    DateTime now = DateTime.now();
    formattedTodayWithDay = DateFormat('EEEE, yyyy-MM-dd').format(now); // Update formattedTodayWithDay

    print('Today with day: $formattedTodayWithDay');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Girls' Count",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ReusableText(text:formattedTodayWithDay,style:appStyle(20, AppConst.brown ,FontWeight.w600)),
            SizedBox(height: 20,),
            Container(
              width: 50*w,
              height: 600,
              child: FirebaseAnimatedList(
                defaultChild:
                Column(
                  children: [
                    Icon(Icons.incomplete_circle)
                    ,Text('Loading')],
                ),
                query: recRef,
                itemBuilder: (context, snapshot, animation, index) {
                  print(snapshot.child('Hostel').value.toString());
                  return Column(
                    children: [
                      Row(
                        children: [
                          ReusableText(text:snapshot.child('Hostel').value.toString(),style:appStyle(18, AppConst.brown ,FontWeight.w600)),
                          ReusableText(text:' : ',style:appStyle(18, AppConst.brown ,FontWeight.w600)),
                          Card(
                            child:
                            Container(
                                height:60,
                                width:100,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      ReusableText(text:"   ",style:appStyle(18, AppConst.brown ,FontWeight.w600)),
                                      ReusableText(text:snapshot.child('Count').value.toString(),style:appStyle(18, AppConst.brown ,FontWeight.w600)),
                                    ],
                                  ),
                                )
                            ),
                          )
                        ],
                      ),

                    ],
                  );
                },
              ),
            ),

          ],
        ),

      ),
    );
  }
}
