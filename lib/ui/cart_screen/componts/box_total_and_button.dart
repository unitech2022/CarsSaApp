import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';

class BoxTotalAndButton extends StatelessWidget {
  final void Function() onPress;
  final String total;

  BoxTotalAndButton(this.onPress, this.total);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               CustomText(
                  family: "pnuB",
                  size: 15,
                  text: "اجمالي المبلغ المطلوب",
                  textColor: Colors.black,
                  weight: FontWeight.w300,
                  align: TextAlign.center),
              SizedBox(height: 5,),
              CustomText(
                  family: "pnuB",
                  size: 15,
                  text: total,
                  textColor: Colors.black,
                  weight: FontWeight.w300,
                  align: TextAlign.center)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton3(
              text: "متابعة",
              fontFamily: "PNUB",
              onPress: onPress,
              redius: 10,
              color: homeColor,
              textColor: Colors.white,
              fontSize: 18,
              height: 40),
        ],
      ),
    );
  }
}