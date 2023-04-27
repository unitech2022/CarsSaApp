import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/text_widget.dart';
import '../add_car_screen/add_car_screen.dart';

class OrderingProduct extends StatelessWidget {
  String? currentValue;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

  final _detProController = TextEditingController();
  final _nameProController = TextEditingController();
  final List<String> _list = ["a", "b", "c"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(onPressed: () {
          pop(context);

        }, icon: const Icon(Icons.arrow_back,color: homeColor,),

        ),
        title: const Text(
          "أضف السيارة",
          style: TextStyle(color: homeColor, fontFamily: "pnuR"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingSymmetric(hor: 20, ver: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailsUser(
                  nameController: _nameController,
                  emailController: _emailController),
              const SizedBox(
                height: 25,
              ),
              TextWidget2(
                  alginText: TextAlign.start,
                  isCustomColor: true,
                  width: double.infinity,
                  text: "معلومات عن السيارة",
                  fontFamliy: "pnuB",
                  fontSize: 14,
                  color: Colors.black),
              const SizedBox(
                height: 10,
              ),
              // CustomDropDwon(
              //     currentValue: currentValue,
              //     list: _list,
              //     onSelect: (value) {},
              //     textHint: "النمط"),
              // CustomDropDwon(
              //     currentValue: currentValue,
              //     list: _list,
              //     onSelect: (value) {},
              //     textHint: "ماركت"),
              // CustomDropDwon(
              //     currentValue: currentValue,
              //     list: _list,
              //     onSelect: (value) {},
              //     textHint: "الموديل"),
              // CustomDropDwon(
              //     currentValue: currentValue,
              //     list: _list,
              //     onSelect: (value) {},
              //     textHint: "سنة الصنع"),
              // CustomDropDwon(
              //     currentValue: currentValue,
              //     list: _list,
              //     onSelect: (value) {},
              //     textHint: "فئة السيارة"),

              DetailsProduct(
                ditailsController: _detProController,
                nameController: _nameProController,
              )

              ,const SizedBox(
                height: 35,
              ),
              CustomButton3(
                  text: "اضف السيارة ",
                  fontFamily: "PNUB",
                  onPress: () {},
                  redius: 10,
                  color: homeColor,
                  textColor: Colors.white,
                  fontSize: 18,
                  height: 40)
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsUser extends StatelessWidget {
  final TextEditingController nameController, emailController;

  DetailsUser({required this.nameController, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidget2(
            alginText: TextAlign.start,
            isCustomColor: true,
            width: double.infinity,
            text: "معلومات عن العميل",
            fontFamliy: "pnuB",
            fontSize: 14,
            color: Colors.black),
        const SizedBox(
          height: 15,
        ),
        CustomFormField(
          headingText: "Email",
          hintText: "اسم العميل",
          obsecureText: false,
          suffixIcon: const SizedBox(),
          controller: nameController,
          maxLines: 1,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 15,
        ),
        CustomFormField(
          headingText: "Email",
          hintText: "البريـد الإاكترونى",
          obsecureText: false,
          suffixIcon: const SizedBox(),
          controller: emailController,
          maxLines: 1,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}


class DetailsProduct extends StatelessWidget {
  final TextEditingController nameController, ditailsController;

  DetailsProduct({required this.nameController, required this.ditailsController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidget2(
            alginText: TextAlign.start,
            isCustomColor: true,
            width: double.infinity,
            text: "معلومات عن المنتج",
            fontFamliy: "pnuB",
            fontSize: 14,
            color: Colors.black),
        const SizedBox(
          height: 15,
        ),
        CustomFormField(
          headingText: "Email",
          hintText: "اسم المنتج",
          obsecureText: false,
          suffixIcon: const SizedBox(),
          controller: nameController,
          maxLines: 1,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xffF6F6F6),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: ditailsController,
            onSaved: (newValue) => newValue!,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (value) {},
            validator: (value) {
              return (value != null && value.isEmpty)
                  ? 'مطلوب * '
                  : null;
            },
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,

              fontFamily: "pnuR"
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              hintText: "القطعه المطلوبة",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ],
    );
  }
}

// class CustomDropDwon extends StatelessWidget {
//   final String? currentValue;
//   final List<String> list;
//   final String textHint;
//   final void Function(dynamic) onSelect;

//   CustomDropDwon(
//       {this.currentValue,
//       required this.list,
//       required this.textHint,
//       required this.onSelect});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       margin: const EdgeInsets.only(bottom: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 3),
//         child: CustomDropDownWidget(
//             currentValue: currentValue,
//             selectCar: false,
//             textColor: Colors.black26,
//             isTwoIcons: false,
//             iconColor: const Color(0xff515151),
//             list: list,
//             onSelect: onSelect,
//             hint:textHint),
//       ),
//     );
//   }
// }
