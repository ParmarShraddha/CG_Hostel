// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:cg_hostel/Utils/SizeConfig.dart';
import 'package:cg_hostel/Utils/reusable_text.dart';
import 'package:flutter/material.dart';
import 'BottomSheet_one.dart';
import 'BottomSheet_two.dart';
import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';
import '../Utils/BottomSheet_Utils.dart';
import '../Utils/OutlineBtn.dart';

class newBoarding extends StatefulWidget {
  const newBoarding({super.key, });

  @override
  State<newBoarding> createState() => _newBoardingState();
}

class _newBoardingState extends State<newBoarding> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPersistentBottomSheet();
    });
  }
  void _showPersistentBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible:false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
          Container(
            height: 25 * h,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReusableText(
                  text: 'Enjoy the Experience',
                  style: appStyle(18, AppConst.black, FontWeight.bold),
                ),

                SizedBox(height: 2*h),
                Text("welcome to our team!",
                  textAlign: TextAlign.center,
                  style: appStyle(15, AppConst.black, FontWeight.normal),
                ),
                Text("Connect, explore, and make memories",
                  textAlign: TextAlign.center,
                  style: appStyle(15, AppConst.black, FontWeight.normal),
                ),
                SizedBox(height: 2*h),
                CustomOtlnBtn(
                    width: double.infinity,
                    height: 5.5*h,
                    buttonColor: AppConst.brown,
                    buttonBorderColor: AppConst.white,
                    onPress: (){
                      Navigator.of(context).pop();
                      BottomSheetUtils.showCustomBottomSheet(
                        context,
                        BottomSheetTwo(),
                      );
                    },
                    buttonName: "CONTINUE >",
                    buttonTextColor: AppConst.white)
              ],
            ),
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
              children: [
                Center(
                  child:SingleChildScrollView(
                  child: Image.asset("assets/boarding_one.jpg"),
                ),
                ),
                Positioned(
                  bottom: 15, // Adjust this value as needed
                  left: 0,
                  right: 0,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        // showModalBottomSheet(
                        //   context: context,
                        //   isScrollControlled: true,
                        //   showDragHandle: true,
                        //   shape: const RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.vertical(
                        //       top: Radius.circular(20.0),
                        //     ),
                        //   ),
                        //   builder: (context) {
                        //     return BottomSheetOne();
                        //   },
                        // );

                        BottomSheetUtils.showCustomBottomSheet(
                          context,
                          BottomSheetOne(),
                        );

                      },
                      child: const Icon(Icons.keyboard_arrow_up, color: AppConst.brown, size: 30),
                    ),
                  ),
                ),
// Add any other widgets over the image if needed
              ],
            ),


    );
  }


}
