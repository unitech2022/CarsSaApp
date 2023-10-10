import 'package:carsa/helpers/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/text_widget.dart';

class MyCarsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          const CustomText(
              family: "pnuB",
              size: 25,
              text: "سياراتى",
              textColor: Colors.black,
              weight: FontWeight.w300,
              align: TextAlign.center),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Container(
                      height: 120,
                      padding: paddingSymmetric(hor: 20, ver: 10),
                      margin: const EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.grey),
                                child: const Icon(
                                  Icons.directions_car,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget3(
                                  alginText: TextAlign.start,
                                  isCustomColor: true,
                                  text: "Deliver to mbw 14255272",
                                  fontFamliy: "pnuB",
                                  fontSize: 14,
                                  color: Colors.black),
                              const SizedBox(
                                height: 10,
                              ),
                              TextWidget3(
                                  alginText: TextAlign.start,
                                  isCustomColor: true,
                                  text: " mbw 14255272",
                                  fontFamliy: "pnuL",
                                  fontSize: 14,
                                  color: Colors.black),
                              const SizedBox(
                                height: 10,
                              ),
                              TextWidget3(
                                  alginText: TextAlign.start,
                                  isCustomColor: true,
                                  text: "14255272",
                                  fontFamliy: "pnuL",
                                  fontSize: 14,
                                  color: Colors.black)
                            ],
                          ),
                          const Spacer(),
                          Radio<String>(

                            activeColor: homeColor,
                            value: "",
                            groupValue: "",
                            onChanged: (String? value) {},
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    );
                  })),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: CustomButton3(
                text: "اضف سيارة أخرى",
                fontFamily: "PNUB",
                onPress: () {
                  Navigator.pushNamed(context, addCar);
                },
                redius: 10,
                color: homeColor,
                textColor: Colors.white,
                fontSize: 18,
                height: 40),
          )
        ],
      ),
    );
  }
}
