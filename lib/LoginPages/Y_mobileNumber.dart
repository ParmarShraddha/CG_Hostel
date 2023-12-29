import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';
import '../Utils/OutlineBtn.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/reusable_text.dart';
import 'Y_codeVerification.dart';

class Y_MobileNumber extends StatelessWidget {
  Y_MobileNumber({super.key});

  TextEditingController MobileNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5*w),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15*h,),
            ReusableText(text: 'Enter Phone number', style: appStyle(16, AppConst.black, FontWeight.w600)),
            TextField(
              controller:MobileNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppConst.brown,
                    )
                ),
                hintText: '+91 1272637828',
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: AppConst.brown,
                    )
                ),
              ),
            ),
            SizedBox(
              height: 4*h,
            ),
            CustomOtlnBtn(
                width: double.infinity,
                height: 5*h,
                buttonColor: AppConst.brown,
                buttonBorderColor: AppConst.brown,
                onPress: (){
                  if(MobileNumberController.text.toString().isNotEmpty){
                    if(MobileNumberController.text.toString().length==10) {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Y_codeVerification(MobileNumber: MobileNumberController.text.toString(),)));
                      showModalBottomSheet(
                        context: context,
                        isDismissible:true,
                        builder: (BuildContext context) {
                          return Container(
                            height: 50*h,
                            child: Y_codeVerification(MobileNumber: MobileNumberController.text.toString()),
                          );
                        },
                      );
                      // send otp code
                    }
                    else{
                      Fluttertoast.showToast(msg: 'Enter Valid Phone Number',backgroundColor: Colors.red);
                    }
                  }
                  else{
                    Fluttertoast.showToast(msg: 'Provide Phone Number',backgroundColor: Colors.red);

                  }
                },

                buttonName: 'Send OTP',
                buttonTextColor: AppConst.white),

          ],),
      ),
    );
  }
}