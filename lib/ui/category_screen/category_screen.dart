import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/bloc/app_cubit/app_cubit.dart';
import 'package:carsa/models/car_mode.dart';
import 'package:carsa/models/home_model.dart';
import 'package:carsa/ui/shoping_screen/shoping_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/constants.dart';
import '../../helpers/functions.dart';


import '../../helpers/styles.dart';
import '../../widgets/text_widget.dart';


class CategoryScreen extends StatelessWidget {
  final CarModel carModel;
  CategoryScreen({required this.carModel});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
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
              "أقسام القطع",
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
          body: AppCubit.get(context).load
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: homeColor,
                  ),
                )
              : ListView.builder(
                  itemCount: AppCubit.get(context).homeModel.categories!.length,
                  padding: const EdgeInsets.only(top: 40, bottom: 10),
                  itemBuilder: (ctx, index) {
                    CategoryModel categoryModel =
                        AppCubit.get(context).homeModel.categories![index];
                    return InkWell(
                        onTap: () {
                          pushPage(
                              context:context,page: ShoppingScreen(
                                  categoryModel, 1, carModel.id!));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: .8))),
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: baseurlImage + categoryModel.image!,
                                height: 60,
                                width: 60,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(
                                    color: homeColor,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget3(
                                        alginText: TextAlign.start,
                                        isCustomColor: true,
                                        text: categoryModel.name!,
                                        fontFamliy: "pnuB",
                                        fontSize: 18,
                                        lines: 2,
                                        color: Colors.black),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ));
                  }),
        );
      },
    );
  }
}
