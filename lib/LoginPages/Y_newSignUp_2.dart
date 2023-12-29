// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, camel_case_types, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:cg_hostel/LoginPages/Y_newSignUp_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/reusable_text.dart';
import 'Y_newLogin.dart';


class Y_newSignUp_2 extends StatefulWidget {
  // final SignUpData signUpData;
  final String email;
  final String userName;
  final String roomNo;
  final String hostel;

  Y_newSignUp_2({super.key, required this.email, required this.userName, required this.roomNo, required this.hostel, });

  @override
  State<Y_newSignUp_2> createState() => _Y_newSignUp_2State();
}

class _Y_newSignUp_2State extends State<Y_newSignUp_2> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var userRef = FirebaseDatabase.instance.ref('Girls');

  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  bool dark= true;
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool showProcess = false;
  var email;
  var userName;
  var roomNo;
  var hostel;


  @override
  void initState() {
    super.initState();
    email = widget.email;
    userName = widget.userName;
    roomNo = widget.roomNo;
    hostel = widget.hostel;
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Column(
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
                  padding:  EdgeInsets.symmetric(horizontal: 5*w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReusableText(text: "SignUp", style: appStyle(35, AppConst.brown, FontWeight.bold) ),
                        SizedBox(height: 4*h),
                        ReusableText(text: 'Mobile Number:', style: appStyle(16, AppConst.black, FontWeight.w600),),
                        TextFormField(
                          controller: mobileNoController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color: AppConst.brown,
                                )
                            ),
                            hintText: '+91 1234567890',

                            suffixIcon: const Icon(Icons.phone),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color: AppConst.brown,
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 2*h),
                        ReusableText(text: 'Create Password:', style: appStyle(16, AppConst.black, FontWeight.w600)),
                        TextFormField(
                          controller: passwordController,
                          obscureText: showPassword,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color: AppConst.brown,
                                )
                            ),
                            hintText: 'a-z,A-Z,1-9',
                            suffixIcon:
                            IconButton(
                              icon:showPassword? const Icon(Icons.remove_red_eye): const Icon(Icons.lock_outline_rounded),
                              onPressed: () {
                                if (showPassword){
                                  showPassword = false;
                                  setState(() {});
                                }
                                else {
                                  showPassword = true;
                                  setState(() {});
                                }
                              },),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color: AppConst.brown,
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 2*h),
                        ReusableText(text: 'Confirm Password:', style: appStyle(16, AppConst.black, FontWeight.w600)),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: showConfirmPassword,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color: AppConst.brown,
                                )
                            ),
                            hintText: 'a-z,A-Z,1-9',
                            suffixIcon:
                            IconButton(
                              icon: showConfirmPassword? const Icon(Icons.remove_red_eye): const Icon(Icons.lock_outline_rounded), onPressed: () {
                              if(showConfirmPassword){
                                showConfirmPassword = false;
                                setState(() {
                                });
                              }
                              else{
                                showConfirmPassword = true;
                                setState(() {
                                });
                              }
                            },
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color: AppConst.brown,
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 3*h),
                        Center(
                          child: ElevatedButton(onPressed: ()async{
                            if (passwordController.text.toString().isNotEmpty &&
                                confirmPasswordController.text.toString().isNotEmpty &&
                                mobileNoController.text.toString().isNotEmpty)
                            {
                              if(passwordController.text.toString() == confirmPasswordController.text.toString()){
                                if(mobileNoController.text.toString().length<10 || mobileNoController.text.toString().length>10){
                                  Fluttertoast.showToast(msg: 'Enter valid 10 digit number',backgroundColor: Colors.redAccent,fontSize: 20);
                                }
                                else{
                                  SignUp();
                                }
                              }
                              else{
                                Fluttertoast.showToast(msg: 'Rewrite Password',backgroundColor: Colors.redAccent,fontSize: 20);
                                confirmPasswordController.clear();
                              }
                            }
                            else{
                              Fluttertoast.showToast(msg: 'Provide All Details',backgroundColor: Colors.redAccent,fontSize: 20);
                            }
                          }, child: ReusableText(text:'Create Account',style: appStyle(16, AppConst.white, FontWeight.normal))),
                        )
                      ]
                  ),
                )
            )
          ],
        ),
      )
    );
  }

  void SignUp(){

    _auth.createUserWithEmailAndPassword(
        email: email,
        password: passwordController.text.toString()).then((value){
      userRef.child(value.user!.uid.toString()).set({
        'uid' : value.user!.uid.toString(),
        'email' : email,
        'userName': userName,
        'Password' : passwordController.text.toString(),
        'Mobile Number' : mobileNoController.text.toString(),
        'Leave': "",
        'History': "",
        'roomNo':roomNo,
        'hostelNo':hostel,
      }).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Y_newLogin()));
      }).onError((error, stackTrace) {
      });
    }
    ).onError((error, stackTrace){

    });
  }
}