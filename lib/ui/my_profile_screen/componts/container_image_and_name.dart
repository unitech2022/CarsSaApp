
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../bloc/app_cubit/app_cubit.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/styles.dart';
import '../../../widgets/text_widget.dart';

class ContainerImageAndName extends StatelessWidget {
  final void Function() onPress;

  const ContainerImageAndName(this.onPress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    shape: BoxShape.circle),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: AppCubit.get(context).userModel.imageUrl != null
                          ? baseurlImage +
                          AppCubit.get(context).userModel.imageUrl!
                          : "notFound",
                      height: 90,
                      fit: BoxFit.cover,
                      width: 90,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(
                          color: homeColor,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 80,
                      ),
                    )),
              ),
              // Positioned(
              //   bottom: 0,
              //   right: 0,
              //   child: InkWell(
              //     onTap: onPress,
              //     child: Container(
              //       padding: const EdgeInsets.all(3),
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           border: Border.all(color: Colors.white, width: 1),
              //           shape: BoxShape.circle),
              //       child: const Center(
              //         child: Icon(
              //           Icons.edit,
              //           color: homeColor,
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextWidget3(
            //     alginText: TextAlign.start,
            //     isCustomColor: true,
            //     text: "Deliver to mbw 14255272",
            //     fontFamliy: "pnuB",
            //     fontSize: 14,
            //     color: Colors.white),
            // const SizedBox(
            //   height: 10,
            // ),
            TextWidget3(
                alginText: TextAlign.start,
                isCustomColor: true,
                text: AppCubit.get(context).userModel.fullName ?? "بدون اسم",
                fontFamliy: "pnuL",
                fontSize: 14,
                color: Colors.white),
          ],
        ),
      ],
    );
  }
}