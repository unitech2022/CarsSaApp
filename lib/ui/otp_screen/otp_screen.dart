import 'package:carsa/bloc/auth_cubit/auth_cubit.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/helpers/helper_function.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/ui/forget_password_screen/forget_password_screen.dart';
import 'package:carsa/ui/navigation/navigation_screen.dart';
import 'package:carsa/work_shop_medul/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../helpers/functions.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_widget.dart';

class OtpScreen extends StatefulWidget {
  final String code, phone;

  OtpScreen({Key? key, required this.code, required this.phone})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String newCode = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LoginAuthStateSuccess) {
            Future.delayed(Duration.zero, () {
              if (role == "user") {
                replacePage(context: context, page: const NavigationScreen());
              } else {
                replacePage(context: context, page: HomeScreenWorkShop());
              }
            });
          }

          return Scaffold(
            backgroundColor: textColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: textColor,
              automaticallyImplyLeading: true,
              leading: IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "التحقق من رقم الجوال",
                style: TextStyle(color: Colors.white, fontFamily: "pnuR"),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 85,
                      ),
                      Icon(
                        Icons.phone_android,
                        size: 60,
                        color: Colors.white,
                      ),
                      // SizedBox(
                      //     width: double.infinity,
                      //     height: MediaQuery.of(context).size.height * .35,
                      //     child: ImageAndLogo(
                      //         rightMargen: 30,
                      //         fontSize: 45,
                      //         title2: 'الهاتف'.tr(),
                      //         title1: 'تأكيد رقم'.tr(),
                      //         image: "assets/images/back_login_e.png")),
                      const SizedBox(
                        height: 35,
                      ),
                      TextWidget(
                        width: double.infinity,
                        text: "ادخل كود الدخول",
                        fontSize: 16,
                        fontFamliy: "pnuR",
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // TextWidget(
                      //   width: double.infinity,
                      //   text: code ,
                      //   fontSize: 16,
                      //   fontFamliy: "pnuR",
                      //   color: Colors.white,
                      // ),
                      const SizedBox(
                        height: 45,
                      ),
                      // todo :

                      SizedBox(
                        width: 200,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 4,
                            obscureText: false,
                            obscuringCharacter: '*',
                            textStyle: const TextStyle(color: Colors.black),
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v.toString().length < 3) {
                                return "";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(9),
                              fieldHeight: 50,
                              fieldWidth: 35,
                              inactiveColor: const Color(0xFFE2E2E2),
                              inactiveFillColor: const Color(0xFFE2E2E2),
                              borderWidth: 1,
                              selectedFillColor: const Color(0xFFE2E2E2),
                              activeFillColor: Colors.white,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            onCompleted: (v) {
                              newCode = v;
                              printFunction(newCode);
                            },
                            onChanged: (value) {
                              printFunction(value);
                            },
                            beforeTextPaste: (text) {
                              printFunction("Allowing to paste $text");
                              return true;
                            },
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      state is LoginAuthStateLoad
                          ? const SizedBox(
                              width: 50,
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomButton(
                                height: 50,
                                fontFamily: "pnuM",
                                color: homeColor,
                                isCustomColor: true,
                                onPress: () {
                                  if (newCode == widget.code) {
                                    AuthCubit.get(context).loginUser(
                                        userName: widget.phone, code: newCode);
                                  } else {
                                    HelperFunction.slt.notifyUser(
                                        context: context,
                                        color: Colors.grey,
                                        message: "الكود غير صحيح");
                                  }
                                },
                                text: "دخول",
                                textColor: homeColor,
                                redius: 5,
                                fontSize: 18,
                                isBorder: false,
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),

                      TextButton(
                          onPressed: () {
                            pushPage(
                                context: context, page: ForgetPasswordScreen());
                          },
                          child: Text("نسيت كلمة المرور ؟")),

                      const SizedBox(
                        height: 200,
                      ),
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
}
