import 'package:carsa/helpers/functions.dart';
import 'package:carsa/ui/search_screen/search_screen.dart';
import 'package:carsa/widgets/custom_text.dart';
import 'package:flutter/material.dart';


import 'icon_bar.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      child: InkWell(
        onTap: (){
          pushPage(context: context, page: SearchScreen());
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.withOpacity(.5),
          ),
          child: Row(
            children: [
              IconButtonController2(
                onPress: () {

                },
                icon: Icons.search,
                color: Colors.white,
              ),
              const SizedBox(width: 20,),
              const CustomText(
                  family: "pnuB",
                  size: 13,
                  text: "ابحث بقطعة العربية",
                  textColor: Colors.white,
                  weight: FontWeight.w300,
                  align: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
