import 'package:cg_hostel/Utils/AppConst.dart';
import 'package:cg_hostel/Utils/SizeConfig.dart';
import 'package:cg_hostel/Utils/OutlineBtn.dart';
import 'package:flutter/material.dart';

class Boarding extends StatelessWidget {
  const Boarding({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomOtlnBtn(
                width: 30*w,
                height: 5*h,
                buttonColor: AppConst.black,
                buttonBorderColor:AppConst.white,
                onPress: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return  SizedBox(
                          height: 30*h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[

                            ],
                          ),
                        );
                      });
                },
                buttonName: 'click me',
                buttonTextColor: AppConst.white,),
            )
          ],
        ),
      ),
    );
  }
}