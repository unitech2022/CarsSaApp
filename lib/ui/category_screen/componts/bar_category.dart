import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/styles.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/text_widget.dart';

class BarCategory extends StatelessWidget {
  const BarCategory({
    Key? key,
    required TextEditingController searchController,
  }) : _searchController = searchController, super(key: key);

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 25),
                decoration: const BoxDecoration(
                    color: homeColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_back_ios_outlined,color: Colors.white,
                          ),
                          const SizedBox(width: 10,),
                          Expanded(child:ListTile(
                            onTap: () {

                            },
                            contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey
                                  ),
                                  child:const Icon(Icons.directions_car,color:Colors.white,size: 30,),
                                )),
                            title: TextWidget3(
                                alginText: TextAlign.start,
                                isCustomColor: true,
                                text: "Deliver to mbw 14255272",
                                fontFamliy: "pnuB",
                                fontSize: 14,
                                color: Colors.white),
                            subtitle: TextWidget3(
                                alginText: TextAlign.start,
                                isCustomColor: true,
                                text: "Abu Dhabi - East",
                                fontFamliy: "pnuR",
                                fontSize: 13,
                                color: Colors.white),
                            trailing: Icon(Icons.favorite,color:Colors.white,size: 35,),
                          ))
                        ],

                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      const CustomText(
                          family: "pnuB",
                          size: 24,
                          text: "الاجزاء الداخلية والخارجية",
                          textColor: Colors.white,
                          weight: FontWeight.bold,
                          align: TextAlign.center),


                    ],


                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomFormField(
                  headingText: "Email",
                  hintText: "ابحث بقطعة الغيار",
                  obsecureText: false,
                  isIcon: true,
                  suffixIcon: const SizedBox(),
                  controller: _searchController,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.emailAddress,
                ),
              ),
            ),

          ],
        ));
  }
}