
import 'package:carsa/helpers/functions.dart';
import 'package:carsa/helpers/helper_function.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/ui/otp_screen/otp_screen.dart';
import 'package:carsa/widgets/custom_button.dart';
import 'package:carsa/widgets/custom_text.dart';
import 'package:carsa/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth_cubit/auth_cubit.dart';
import '../login_screen/login_screen.dart';
import '../privacy_html_screen/privacy_html_screen/privacy_html_screen.dart';


class SignUpScreen extends StatefulWidget {
  final String phone, code;

  const SignUpScreen({Key? key, required this.phone, required this.code})
      : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _key = GlobalKey<FormState>();

  final _controllerPhone = TextEditingController();

  final _controllerEmail = TextEditingController();

  final _controllerFullName = TextEditingController();

  String code = "+966";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerPhone.text = widget.phone;
    code = widget.code;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerFullName.dispose();
    _controllerEmail.dispose();
    _controllerPhone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ValidateAuthStateError) {
            Future.delayed(Duration.zero, () {
              HelperFunction.slt.notifyUser(
                  color: Colors.grey, message: state.error, context: context);
            });
          }

          if (state is RegisterAuthStateSuccess) {
            Future.delayed(Duration.zero, () {
              pushPage(
                  context: context,
                  page: OtpScreen(code: state.code, phone: state.userName));
            });
          }

          return Scaffold(
            backgroundColor: Colors.black26,
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              CustomText(
                                  family: "pnuB",
                                  size: 25,
                                  text: "انشاء حساب جديد",
                                  textColor: Colors.white,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center),
                              SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                  family: "pnuR",
                                  size: 18,
                                  text:
                                      "اهلا بك في Car Sa \n خطوات بسيطة وتمتع بعالم متكامل ",
                                  textColor: Colors.grey,
                                  weight: FontWeight.w300,
                                  align: TextAlign.start),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomFormField(
                        headingText: "Email",
                        hintText: "الاسم بالكامل",
                        obsecureText: false,
                        suffixIcon: const SizedBox(),
                        controller: _controllerFullName,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomFormField(
                        headingText: "Password",
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        hintText: "اكتب كلمة المرور ",
                        obsecureText: false,
                        isPhone: true
                      ,length: 4,
                        suffixIcon: const SizedBox(),
                        controller: _controllerEmail,
                      ),
                       
                
                       
                       const SizedBox(
                        height: 5,
                      ),

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: CustomText(
                                        family: "pnuB",
                                        size: 12,
                                        text: "الرجاء حفظ هذا الكود حتى تتمكن من الدخول ",
                                        textColor: Colors.red,
                                        weight: FontWeight.bold,
                                        align: TextAlign.right),
                            ),
                          ],
                        ),

                      //,
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
                            textInputType: TextInputType.phone,
                            hintText: "رقم التلفون",
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            controller: _controllerPhone,
                          )),
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
                                          nameContry:
                                              "المملكة العربية السعودية",
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
                      // CustomFormField2(
                      //   headingText: "Password",
                      //   maxLines: 1,
                      //   textInputAction: TextInputAction.done,
                      //   textInputType: TextInputType.text,
                      //   hintText: "كلمـة المرور",
                      //   obsecureText: true,
                      //   suffixIcon: IconButton(
                      //       icon: const Icon(Icons.visibility), onPressed: () {}),
                      //   onSaved: (value) {},
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // CustomFormField2(
                      //   headingText: "Password",
                      //   maxLines: 1,
                      //   textInputAction: TextInputAction.done,
                      //   textInputType: TextInputType.text,
                      //   hintText: "اعادة كلمـة المرور",
                      //   obsecureText: true,
                      //   suffixIcon: IconButton(
                      //       icon: const Icon(Icons.visibility), onPressed: () {}),
                      //   onSaved: (value) {},
                      // ),
                      const SizedBox(
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
                                  page:  PrivacyHtmlScreen(
                               
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
                        height: 25,
                      ),
                      state is ValidateAuthStateLoad
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
                              text: "انشاء حساب جديد",
                              fontFamily: "PNUB",
                              onPress: () {
                                if (isValidate(context)) {
                                  print(code + _controllerPhone.text);
                                  AuthCubit.get(context).validateUser(
                                      fullName: _controllerFullName.text.trim(),
                                      code: _controllerEmail.text,
                                      username: code + _controllerPhone.text);
                                }
                              },
                              redius: 10,
                              color: homeColor,
                              textColor: Colors.white,
                              fontSize: 18,
                              height: 60),
                      const SizedBox(
                        height: 35,
                      ),
                      // const CustomText(
                      //     family: "pnuB",
                      //     size: 15,
                      //     text: "تخطى والاستمرار كضيف",
                      //     textColor: Colors.white,
                      //     weight: FontWeight.w300,
                      //     align: TextAlign.center),
                      // const SizedBox(
                      //   height: 35,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool isValidate(BuildContext context) {
    if (_controllerFullName.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.red, message: "أدخل الاسم كاملا");
      return false;
    }
    else if (_controllerEmail.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.red, message: "أدخل كلمة المرور ");
      return false;
    }
    else if (_controllerPhone.text.isEmpty ||
        !(_controllerPhone.text.trim().length == 9) ||
        !_controllerPhone.text.trim().startsWith("5")) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.red, message: "أدخل رقم الهاتف");
      return false;
    } else if (!AuthCubit.get(context).isChecked) {
      HelperFunction.slt.notifyUser(
          context: context,
          color: Colors.red,
          message: "يجب الموافقة علي سياسة الخصوصية");
      return false;
    } else {
      return true;
    }
  }
}
