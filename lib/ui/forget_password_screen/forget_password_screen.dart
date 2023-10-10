import 'package:carsa/bloc/auth_cubit/auth_cubit.dart';
import 'package:carsa/helpers/functions.dart';
import 'package:carsa/helpers/helper_function.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/ui/login_screen/login_screen.dart';
import 'package:carsa/ui/otp_screen/otp_screen.dart';
import 'package:carsa/widgets/custom_button.dart';
import 'package:carsa/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/custom_text.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _phoneController = TextEditingController();
  String code = "+966";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),

                  const CustomText(
                      family: "pnuR",
                      size: 18,
                      text: "استرجاع كلمة المرور",
                      textColor: Colors.grey,
                      weight: FontWeight.w300,
                      align: TextAlign.center),
                  const SizedBox(
                    height: 30,
                  ),
                  // CustomFormField(
                  //   headingText: "Email",
                  //   hintText: "البريـد الإاكترونى",
                  //   obsecureText: false,
                  //   suffixIcon: const SizedBox(),
                  //   controller: _emailController,
                  //   maxLines: 1,
                  //   textInputAction: TextInputAction.done,
                  //   textInputType: TextInputType.emailAddress,
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomFormField(
                          headingText: "Password",
                          maxLines: 1,
                          isPhone: true,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.number,
                          hintText: "أدخل رقم الهاتف",
                          obsecureText: false,
                          suffixIcon: const SizedBox(),
                          controller: _phoneController,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: (() {
                          HelperFunction.slt.showSheet(
                              context,
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ContainerCountryCode(
                                      onPress: () {
                                        pop(context);
                                        code = "+966";
                                        setState(() {});
                                      },
                                      code: "+966",
                                      nameContry: "المملكة العربية السعودية",
                                    ),
                                    ContainerCountryCode(
                                      onPress: () {
                                        pop(context);
                                        code = "+968";
                                        setState(() {});
                                      },
                                      code: "+968",
                                      nameContry: "سلطنة عمان",
                                    ),
                                  ],
                                ),
                              ));
                        }),
                        child: Text(
                          code,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontFamily: "pnuB",
                              fontSize: 15,
                              color: Colors.white,
                              height: 1.2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // const SizedBox(
                  //   width: double.infinity,
                  //   child: CustomText(
                  //       family: "pnuB",
                  //       size: 15,
                  //       text: "نسيت كلمة المرور؟",
                  //       textColor: Colors.white,
                  //       weight: FontWeight.w300,
                  //       align: TextAlign.start),
                  // ),
                  SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                   CustomText(
                      family: "pnuR",
                      size: 18,
                      text: state is GetCodeSuccess ? " كود الدخول هو :  ${state.code}":"",
                      textColor: Colors.grey,
                      weight: FontWeight.w300,
                      align: TextAlign.center),
                  const SizedBox(
                    height: 25,
                  ),
                  state is GetCodeLoading
                      ? const SizedBox(
                          height: 60,
                          width: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : CustomButton3(
                          text: state is GetCodeSuccess
                              ? "دخول الان"
                              : "استرجاع كود الدخول",
                          fontFamily: "PNUB",
                          onPress: () {
                            if (state is GetCodeSuccess) {
                              pushPage(
                                  context: context,
                                  page: OtpScreen(
                                      code: state.code, phone: state.phone));
                            } else {
                              if (isValidate()) {
                                AuthCubit.get(context).getCode(
                                    phone: code + _phoneController.text,
                                    context: context);
                              }
                            }
                          },
                          redius: 10,
                          color: homeColor,
                          textColor: Colors.white,
                          fontSize: 18,
                          height: 60),
                  const SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool isValidate() {
    if (_phoneController.text.isEmpty ||
        _phoneController.text.trim().length < 9 
        // _phoneController.text.trim().startsWith("5")
        ) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.red, message: "أدخل رقم الهاتف");
      return false;
    } else {
      return true;
    }
  }
}
