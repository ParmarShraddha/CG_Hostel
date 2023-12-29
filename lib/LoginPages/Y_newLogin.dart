import 'package:cg_hostel/MessPages/S_messHome.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../S_practice_phone.dart';
import '../StudentPages/P_studentHomePage.dart';
import '../RectorPages/S_rectorHomePage.dart';
import '../Utils/AppConst.dart';
import '../Utils/AppStyle.dart';
import '../Utils/SizeConfig.dart';
import '../Utils/reusable_text.dart';
import 'S_forgotPassword.dart';
import 'Y_mobileNumber.dart';
import 'Y_newSignUp_1.dart';

class Y_newLogin extends StatefulWidget {
  const Y_newLogin({super.key});

  @override
  State<Y_newLogin> createState() => _Y_newLoginState();
}

class _Y_newLoginState extends State<Y_newLogin> {

  var _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference userRef = FirebaseDatabase.instance.ref('Girls');

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool dark= true;
  bool passwordShow = true;
  var userToken;
  bool loading = false;
  var rectorArray = ["6AJIxeNWFINGvYNG44IbLNDHMLC3","HLVHpHpdM5XQiuNp9NmR8dN0vGA3","LgC0lekzzWT9AQAuyLNmtgFFl5M2","Ow2stbx0QvUKbUgnes3kthums5Q2","Yit3cgMRveZPso9iu8GhFMWQkKX2"];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                        ReusableText(text: "Login", style: appStyle(35, AppConst.brown, FontWeight.bold)),
                        SizedBox(height: 4*h),
                        ReusableText(text: 'Email Id:', style: appStyle(16, AppConst.black, FontWeight.w600)),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
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

                        ReusableText(text: 'Password:', style: appStyle(16, AppConst.black, FontWeight.w600)),

                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: passwordShow,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                )
                            ),
                            hintText: '***',
                            suffixIcon: IconButton(
                              icon: passwordShow? const Icon(Icons.remove_red_eye):const Icon(Icons.lock_outline_rounded),
                              onPressed: (){
                                if (passwordShow)
                                {
                                  passwordShow = false;
                                  setState(() {
                                  });
                                }
                                else
                                {
                                  passwordShow = true;
                                  setState(() {
                                  });
                                }
                              },
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color:AppConst.brown,
                                )
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter Password';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 4*h),

                        Container(
                          width: double.infinity,
                          height: 5*h,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: (){
                                print(emailController.text.toString());
                                print(passwordController.text.toString());
                                if (emailController.text.toString().isEmpty ||
                                    passwordController.text.toString().isEmpty)
                                {
                                  Fluttertoast.showToast(msg: 'Fill all details',backgroundColor: Colors.redAccent,fontSize: 20);
                                }
                                else {
                                  print('in else');
                                  login();
                                }
                              },
                              child: loading ? const SizedBox(height:25,width:25,child: CircularProgressIndicator(color: Colors.white,)):const Text('Login',)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const forgotPasswordScreen()));
                                },
                                child: ReusableText(text: 'Forgot Password ?',style: appStyle(14, AppConst.black, FontWeight.w500)))
                          ],
                        ),
                        // InkWell(
                        //   onTap: (){
                        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPhone()));
                        //
                        //   },
                        //   child: Container(
                        //       height: 50,
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(50),
                        //           border: Border.all(
                        //               color: Colors.black
                        //           )
                        //       ),
                        //       child:Center(
                        //         child:ReusableText(text: "Login with Phone Number", style: GoogleFonts.poppins(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w400)),
                        //
                        //       )
                        //   ),
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReusableText(text: "Don't have an account?", style: appStyle(14, AppConst.black, FontWeight.normal)),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Y_newSignUp_1()));
                                },
                                child: ReusableText(text: 'Signup',style: appStyle(14, AppConst.black, FontWeight.bold)))
                          ],
                        ),



                      ]
                  ),
                )
            )
          ],
        ),
      )
    );

  }


void login()async{
  print('in login');
  _auth.signInWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passwordController.text.toString()).then((value) async{
    print(value.toString());
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = value.user!.uid.toString();
    sharedPreferences.setString("userToken", value.user!.uid.toString());
    sharedPreferences.setBool("LogIn", true);
    print(sharedPreferences.getBool("LogIn"));
    setState(() {
      loading = false;
    });
    print("usertoken ${userToken}");
    if(rectorArray.contains(userToken)){
      print('rector login');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => S_rec_Home(userToken: userToken),) );

    }
    else if(userToken == "tM6JqT7SvUfTJHrPqNTEMP8gbI52"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => S_mess_Home(userToken: userToken),));

    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => studentHome(userToken:userToken),));
    }

  }).onError((error, stackTrace)
  {
    setState(() {
      loading = false;
    });
    print('error');
    Fluttertoast.showToast(msg: error.toString(),backgroundColor: Colors.red);
  });
}

}