import 'dart:async';
import 'package:cg_hostel/Utils/AppConst.dart';
import 'package:cg_hostel/Utils/SizeConfig.dart';
import 'package:cg_hostel/StudentPages/P_studentHomePage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MessPages/S_messHome.dart';
import '../RectorPages/S_rectorHomePage.dart';
import '../starting_BottomSheets/newBoarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async{

    var logInPref = await SharedPreferences.getInstance();
    var logInFlag= logInPref.getBool("LogIn");
    var userToken = logInPref.getString('userToken');
    var rectorArray = ["6AJIxeNWFINGvYNG44IbLNDHMLC3","HLVHpHpdM5XQiuNp9NmR8dN0vGA3","LgC0lekzzWT9AQAuyLNmtgFFl5M2","Ow2stbx0QvUKbUgnes3kthums5Q2","Yit3cgMRveZPso9iu8GhFMWQkKX2"];

    if (logInFlag == true){
      print('splash checkroute if');
      Timer(const Duration(seconds: 3),(){
        if(rectorArray.contains(userToken)){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>S_rec_Home(userToken: userToken,)));
        }
        else if(userToken =="tM6JqT7SvUfTJHrPqNTEMP8gbI52"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>S_mess_Home(userToken: userToken,)));
        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>studentHome(userToken: userToken,)));
        }
      });
    }
    else{
      print('splash checkroute else');
      Timer(const Duration(seconds: 3),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const newBoarding()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/my animation.json', width: 40*w, height: 40*w),
      ),
    );
  }
}