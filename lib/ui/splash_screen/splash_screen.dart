import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/ui/welcome_page/welcome_page.dart';
import 'package:carsa/work_shop_medul/screens/home_screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../../helpers/functions.dart';
import '../login_screen/login_screen.dart';
import '../navigation/navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // init();
    //  AppCubit.get(context).getSitting();
    printFunction("currentUser.id!${currentUser.id}");
    printFunction("currentUser.id!$token");
    // AppCubit.get(context).getSitting();
    startTime();
  }

  startTime() async {
    var _duration = const Duration(milliseconds: 5000);

    return Timer(_duration, () {
      navigationPage();
      // init();
    });
  }

  Future<void> navigationPage() async {
    // await readToken();

    if (role != "") {
      if (isRegistered()) {
        if (role == "user") {
          replacePage(context: context, page: const NavigationScreen());
        } else {
          replacePage(context: context, page: HomeScreen());
        }
      } else {
        replacePage(context: context, page: const LoginScreen());
      }
    } else {
      replacePage(context: context, page: const WelcomePage());
    }
    print(role+"roooole");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: 250.0,
            child: Image.asset("assets/images/logo.png"),
          ),
        ));
  }
}
/*
* 
* TextLiquidFill(

          text: 'CAR SA',
          waveColor: homeColor,
waveDuration:  const Duration(milliseconds: 5000),
boxBackgroundColor: Colors.white,
          textStyle: const TextStyle(
          fontSize: 50.0,
          color: Colors.white,
          fontFamily: "pnuB",
          letterSpacing: .1,
          fontWeight: FontWeight.bold,
    ),
    boxHeight: 300.0,
    )
* 
* 
* */