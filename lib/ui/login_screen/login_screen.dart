import 'package:carsa/bloc/auth_cubit/auth_cubit.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/helpers/functions.dart';
import 'package:carsa/helpers/helper_function.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/ui/navigation/navigation_screen.dart';
import 'package:carsa/ui/otp_screen/otp_screen.dart';
import 'package:carsa/ui/sign_up_screen/sign_up_screen.dart';
import 'package:carsa/widgets/custom_button.dart';
import 'package:carsa/widgets/custom_text.dart';
import 'package:carsa/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../privacy_policy/privacy_policy_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  // String get password => _passwordController.text.trim();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        // if (state is CheckUserAuthStateSuccess) {
        //   printFunction("${state.status}");

       
        // }

        return Scaffold(
          backgroundColor: Colors.black26,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const CustomText(
                      family: "pnuB",
                      size: 25,
                      text: "أهلا بعودتك !",
                      textColor: Colors.white,
                      weight: FontWeight.bold,
                      align: TextAlign.center),
                  const SizedBox(
                    height: 10,
                  ),

                  const CustomText(
                      family: "pnuR",
                      size: 18,
                      text: "تسجيل الدخول ",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Colors.white,
                        ),
                        child: Checkbox(
                          tristate: false,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(
                                  color: Colors.white, width: 2)),
                          checkColor: Colors.white,
                          activeColor: homeColor,
                          value: AuthCubit.get(context).isChecked,
                          onChanged: (value) {
                            AuthCubit.get(context).changeCheckBox(value!);
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          pushPage(
                              context: context,
                              page: PrivacyPolicyScreen(
                                value: "",
                                title: "",
                                status: 1,
                              ));
                        },
                        child: const Text(
                          "أوافق علي الشروط والأحكام",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "pnuL"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  state is CheckUserAuthStateLoad
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
                          text: "تسجيل الدخول",
                          fontFamily: "PNUB",
                          onPress: () {
                            if (isValidate()) {
                              AuthCubit.get(context).checkUserName(
                                  phone: code + _phoneController.text, code: code,context: context);
                            }
                          },
                          redius: 10,
                          color: homeColor,
                          textColor: Colors.white,
                          fontSize: 18,
                          height: 60),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      pushPage(page: SignUpScreen(phone: "",code: "+966",), context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const SizedBox(
                        width: double.infinity,
                        child: CustomText(
                            family: "pnuB",
                            size: 15,
                            text: "انشاء حساب جديد",
                            textColor: Colors.white,
                            weight: FontWeight.w300,
                            align: TextAlign.center),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),

                role=="user"?  InkWell(
                    onTap: () {
                      pushPage(page: NavigationScreen(), context: context);
                    },
                    child: const CustomText(
                        family: "pnuB",
                        size: 15,
                        text: "تخطى والاستمرار كضيف",
                        textColor: Colors.green,
                        weight: FontWeight.w300,
                        align: TextAlign.center),
                  ):SizedBox(),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isValidate() {
    if (_phoneController.text.isEmpty &&
        _phoneController.text.trim().length == 9 &&
        _phoneController.text.trim().startsWith("5")) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.red, message: "أدخل رقم الهاتف");
      return false;
    } else if (!AuthCubit.get(context).isChecked) {
      HelperFunction.slt.notifyUser(
          context: context,
          color: Colors.red,
          message: "يجب الموافقة علي الشروط والأحكام");
      return false;
    } else {
      return true;
    }
  }
}

class ContainerCountryCode extends StatelessWidget {
  final void Function() onPress;
  final String code, nameContry;
  ContainerCountryCode({
    required this.onPress,
    required this.nameContry,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              code,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontFamily: "pnuB",
                  fontSize: 15,
                  color: Colors.black,
                  height: 1.2),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 20,),
            Text(
              nameContry,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontFamily: "pnuB",
                  fontSize: 15,
                  color: Colors.black,
                  height: 1.2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
