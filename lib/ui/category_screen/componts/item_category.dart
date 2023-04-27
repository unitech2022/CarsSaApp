
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_text.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: double.infinity,

      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.asset("assets/images/images.jpg",height: 80,width: 80,fit: BoxFit.fill,),
              const SizedBox(width: 20,),
              const CustomText(
                  family: "pnuB",
                  size: 18,
                  text: "طارة واجزائها",
                  textColor: Colors.black,
                  weight: FontWeight.bold,
                  align: TextAlign.center),

              Spacer(),
              Icon(Icons.arrow_forward_ios,color: Colors.black,size: 20,)

            ],

          ),
        ),

      ),
    );
  }
}