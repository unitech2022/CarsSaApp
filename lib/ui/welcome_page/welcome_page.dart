import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/helpers/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../helpers/styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_widget.dart';
import '../login_screen/login_screen.dart';


 const colorizeColors = [
    homeColor,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  const colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'pnuB',
    color: homeColor
  );

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [

        Align(
          alignment: Alignment.topCenter,
          child:   Padding(
            padding: const EdgeInsets.only(top: 120),
            child: SizedBox(
                  height: 80,
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 40,
                      fontFamily: "pnuB",
                      color: homeColor,
                      fontWeight: FontWeight.bold,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        // TypewriterAnimatedText('C'),
                        // TypewriterAnimatedText('a'),
                        // TypewriterAnimatedText('r'),
                        // TypewriterAnimatedText('Sa'),

                        // ColorizeAnimatedText(
                        //   'Car Sa',
                        //   textStyle: colorizeTextStyle,
                        //   colors: colorizeColors,
                        // ),
                         WavyAnimatedText('Car Sa',textStyle: TextStyle(fontSize: 50)),
                      ],
                      isRepeatingAnimation: true,
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ),
          ),
             
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 200.0,
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextWidget(
                width: double.infinity,
                text: "الدخول ",
                fontSize: 25,
                fontFamliy: "pnuB",
                color: homeColor,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                height: 50,
                fontFamily: "pnuM",
                color: homeColor,
                isCustomColor: true,
                onPress: () {
                  role = "user";
                  saveData(key: "Role", data: "user");
                  pushPage(context: context, page: LoginScreen());
                },
                text: "قطع غيار",
                textColor: homeColor,
                redius: 5,
                fontSize: 18,
                isBorder: false,
              ),
              SizedBox(
                height: 10,
              ),
              CustomButton(
                height: 50,
                fontFamily: "pnuM",
                color: Colors.white,
                isCustomColor: false,
                onPress: () {
                  role = "provider";
                  saveData(key: "Role", data: "provider");
                  pushPage(context: context, page: LoginScreen());
                },
                text: "صاحب ورشة",
                textColor: homeColor,
                redius: 5,
                fontSize: 18,
                isBorder: false,
              )
            ]),
          ),
        )
      ]),
    );
  }
}
