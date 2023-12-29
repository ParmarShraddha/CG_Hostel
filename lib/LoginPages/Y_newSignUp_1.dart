// ignore_for_file: camel_case_types

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';
import '../Utils/OutlineBtn.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/reusable_text.dart';
import 'Y_newLogin.dart';
import 'Y_newSignUp_2.dart';

class Y_newSignUp_1 extends StatefulWidget {
  const Y_newSignUp_1({super.key});

  @override
  State<Y_newSignUp_1> createState() => _Y_newSignUp_1State();
}

class _Y_newSignUp_1State extends State<Y_newSignUp_1> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController roomNoController = TextEditingController();
  String selectedHostel = 'Hostel';
  bool dark= true;
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool showProcess = false;
  var items = [
    'Hostel',
    'H1',
    'H2',
    'H3',
    'H4',
    'H5',
  ];
  // String emailValue ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
                children: [
                  ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      color: AppConst.brown.shade100,
                      height: 20*h,
                    ),
                  ),

                  ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      color: AppConst.brown.shade500,
                      height: 18.5*h,
                    ),
                  ),
                ]
            ),

            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5*w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 3*h),
                    ReusableText(text: 'Sign Up', style: appStyle(35, AppConst.brown, FontWeight.bold)),

                    SizedBox(height: 4*h),

                    ReusableText(text: 'Email Id:', style: appStyle(16, AppConst.black, FontWeight.w600)),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: const BorderSide(
                              color: AppConst.brown,
                            )
                        ),
                        hintText: 'abc@gmail.com',
                        suffixIcon: const Icon(Icons.email_outlined),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: const BorderSide(
                              color: AppConst.brown,
                            )
                        ),
                      ),
                      validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                    ),
                    SizedBox(height: 2*h),
                    ReusableText(text: 'Username:', style: appStyle(16, AppConst.black, FontWeight.w600)),
                    TextFormField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: const BorderSide(
                                color: AppConst.brown,
                              )
                          ),
                          hintText: 'abc',
                          suffixIcon: const Icon(Icons.account_circle_outlined),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11),
                              borderSide: const BorderSide(
                                color: AppConst.brown,
                              )
                          ),
                        ),
                        validator:(value) {
                          return value!.isEmpty ? 'enter userName' : null;
                        }
                    ),

                    SizedBox(height: 2*h),

                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(text: 'Select Hostel:', style: appStyle(16, AppConst.black, FontWeight.w600)),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color:AppConst.white),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: DropdownButton(
                                      value: selectedHostel,
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedHostel = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(text: "Room No:", style: appStyle(16, AppConst.black, FontWeight.w600)),
                                Container(
                                  height:h*8.5,
                                  child:TextFormField(
                                  controller: roomNoController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                        borderSide: const BorderSide(
                                          color: AppConst.brown,
                                        )
                                    ),
                                    hintText: '1',
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(11),
                                        borderSide: const BorderSide(
                                          color: AppConst.brown,
                                        )
                                    ),
                                  ),
                                ),),
                              ],
                            ),
                          ),
                        ]
                    ),


                    SizedBox(height: 4*h),

                    CustomOtlnBtn(
                        width: double.infinity,
                        height: 5*h,
                        buttonColor: AppConst.brown,
                        buttonBorderColor: AppConst.brown,
                        onPress: (){
                          if (emailController.text.toString().isEmpty ||
                              userNameController.text.toString().isEmpty ||
                              roomNoController.text.toString().isEmpty ||
                              selectedHostel.isEmpty
                          ){
                            Fluttertoast.showToast(msg: 'Fill all details',backgroundColor: Colors.redAccent,fontSize: 20);
                          }
                          else if(selectedHostel == 'Hostel'){
                            Fluttertoast.showToast(msg: 'select Hostel',backgroundColor: Colors.redAccent,fontSize: 20);
                          }
                          else{
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Y_newSignUp_2(email: emailController.text,hostel: selectedHostel,roomNo: roomNoController.text,userName: userNameController.text),),);                          }
                        },
                        buttonName: 'CONTINUE >>',
                        buttonTextColor: AppConst.white),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReusableText(text: "Already have an account?", style: appStyle(14, AppConst.black, FontWeight.normal)),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Y_newLogin()));
                            },
                            child: ReusableText(text: 'Login',style: appStyle(14, AppConst.black, FontWeight.bold)))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double w=size.width;
    double h=size.height;
    final path=Path();

    path.lineTo(0, h);
    path.quadraticBezierTo(w*0.5, h-100, w, h);
    path.lineTo(w, 0);

    path.close();
    return path;

  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}