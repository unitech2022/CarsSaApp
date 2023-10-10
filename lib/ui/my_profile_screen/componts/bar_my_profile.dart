import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../bloc/app_cubit/app_cubit.dart';

import '../../../helpers/styles.dart';

import 'container_counter.dart';
import 'container_image_and_name.dart';

class BarMyProfile extends StatelessWidget {
  final void Function() onPress;

  const BarMyProfile(this.onPress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: homeColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Container(
        padding: paddingSymmetric(hor: 20, ver: 0),
        child: Column(
          children: [
            ContainerImageAndName(onPress),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 1,
              color: Colors.white,
            ),
            Expanded(
              child: Row(
                children: [
                  ContainerCounter(
                      text: "قطعة فى المفضلة",
                      icon: Icons.favorite_border,
                      count: "${AppCubit.get(context).favoritesData.length}"),
                  ContainerCounter(
                      text: "قطعة فى السلة",
                      icon: Icons.add_shopping_cart_rounded,
                      count: "${AppCubit.get(context).homeModel.carts!.length}"),
  ],
              ),
            )
          ],
        ),
      ),
    );
  }
}