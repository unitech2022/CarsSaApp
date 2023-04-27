import 'package:carsa/bloc/suggestion_cubit/suggestion_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../helpers/styles.dart';
import '../../widgets/Buttons.dart';
import '../../widgets/custom_text_field.dart';

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({Key? key}) : super(key: key);

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  final _controllerName = TextEditingController();


  final _controllerMessage = TextEditingController();
  final _controllerPhone = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerName.dispose();

    _controllerMessage.dispose();
    _controllerPhone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: homeColor,
          ),
          onPressed: () {
            pop(context);
          },
        ),
        title: Text(
          "الشكاوي والاقتراحات",
          style: const TextStyle(color: homeColor, fontFamily: "pnuB"),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_list_alt,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: BlocConsumer<SuggestionCubit, SuggestionState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  TitleWidget("الاسم "),
                  CustomFormField(
                    headingText: "Email",
                    hintText: "اكتب الاسم",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: _controllerName,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleWidget("رقم الهاتف"),
                  CustomFormField(
                    headingText: "Email",
                    hintText: "رقم الهاتف",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: _controllerPhone,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TitleWidget("الرسالة او الشكوى"),
                  CustomFormField(
                    headingText: "Password",
                    maxLines: 8,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.text,
                    hintText: "الرسالة او الشكوى",
                    obsecureText: false,
                    suffixIcon: const SizedBox(),
                    controller: _controllerMessage,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  SuggestionCubit.get(context).loadAdd?const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: homeColor,
                    ),
                  ): DefaultButton(
                    colorText: const Color(0xffffffff),
                    height: 50,
                    text: "ارسال الشكوي",
                    onPress: () {
                      if (isValidate(context)) {


                        SuggestionCubit.get(context).addSuggestion (context,phone: _controllerPhone.text,
                        userName: _controllerName.text,
                        message: _controllerMessage.text);

                      }
                      // Navigator.of(context).pushNamed(ValidateNumberScreen.id);
                    },
                    color: homeColor,
                  ),
SizedBox(height: 5,),
                  Text(AppCubit.get(context)
                      .homeModel
                      .sittings![3]
                      .value!,
                      style: const TextStyle(
                          fontFamily: "pnuB", fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool isValidate(BuildContext context) {
    if (_controllerName.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.red, message: "اكتب اسم المحل ");
      return false;
    }
    else if (_controllerPhone.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.red, message: "اكتب رقم الهاتف");
      return false;
    } else if (_controllerMessage.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.red, message: "اكتب الرسالة");
      return false;
    } else {
      return true;
    }
  }
}

class TitleWidget extends StatelessWidget {
  final String text;

  TitleWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Text(text,
          style: const TextStyle(
              fontFamily: "pnuB", fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
