import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';
import '../Utils/OutlineBtn.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/reusable_text.dart';
import 'Y_codeVerification.dart';
import 'package:flutter/material.dart';

class Y_codeVerification extends StatelessWidget {
  final MobileNumber;
  Y_codeVerification({super.key, required this.MobileNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: 5*w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 3*h,),
              ReusableText(text: 'Please wait...', style: appStyle(20, AppConst.black, FontWeight.w600)),
              SizedBox(height: 1*h),
              ReusableText(text: 'we will send OTP to', style: appStyle(14, AppConst.black, FontWeight.normal)),
              ReusableText(text: '+91 $MobileNumber', style: appStyle(14, AppConst.black, FontWeight.normal)),
              SizedBox(height: 2*h),
              Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (value){
                  if(value.length==6){

                  }
                },
                onSubmitted: (value){
                  if(value.length==6){

                  }
                },
              ),
              SizedBox(height: 3*h),

              CustomOtlnBtn(
                  width: double.infinity,
                  height: 5*h,
                  buttonColor: AppConst.brown,
                  buttonBorderColor: AppConst.brown,
                  onPress: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));


                  },
                  buttonName: 'Verify',
                  buttonTextColor: AppConst.white),
            ],
          ),
        ),
      ),
    );
  }
}