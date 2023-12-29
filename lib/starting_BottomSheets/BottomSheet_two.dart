// ignore_for_file: file_names

import 'package:cg_hostel/Utils/AppConst.dart';
import 'package:cg_hostel/Utils/OutlineBtn.dart';
import 'package:cg_hostel/Utils/SizeConfig.dart';
import 'package:cg_hostel/Utils/AppStyle.dart';
import 'package:cg_hostel/Utils/reusable_text.dart';
import 'package:cg_hostel/LoginPages/Y_newLogin.dart';
import 'package:flutter/material.dart';

class BottomSheetTwo extends StatelessWidget {
  const BottomSheetTwo({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
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
            text: "Keep In Touch",
            style: appStyle(18, AppConst.black, FontWeight.bold),
          ),

          SizedBox(height: 2*h),
          Text("be much better for attendance!",
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

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>const Y_newLogin(),
                  ),
                );

              },
              buttonName: "LOGIN >",
              buttonTextColor: AppConst.white)
        ],
      ),
    );
  }
}