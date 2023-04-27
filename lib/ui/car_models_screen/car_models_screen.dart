import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/bloc/product_bloc/product_cubit.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/models/car_mode.dart';
import 'package:carsa/ui/category_screen/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../widgets/text_widget.dart';

class CarModelsScreen extends StatefulWidget {
  final String nameCar;
  final int carId;

  const CarModelsScreen({required this.nameCar, required this.carId});

  @override
  State<CarModelsScreen> createState() => _CarModelsScreenState();
}

class _CarModelsScreenState extends State<CarModelsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductCubit.get(context).getCarModels(carId: widget.carId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return ProductCubit.get(context).loadCarModels
            ? Scaffold(
                body: Center(
                  child: CircularProgressIndicator(color: homeColor),
                ),
              )
            : Scaffold(
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
                    widget.nameCar,
                    style:
                        const TextStyle(color: homeColor, fontFamily: "pnuB"),
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
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ListView.builder(
                      itemCount: ProductCubit.get(context).carModels.length,
                      itemBuilder: ((context, index) {
                        CarModel carModel =
                            ProductCubit.get(context).carModels[index];
                        return GestureDetector(
                          onTap: () {
                            pushPage(context: context, page: CategoryScreen(
                              carModel:carModel
                            ));
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
                                  imageUrl: baseurlImage + carModel.image!,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget3(
                                          alginText: TextAlign.start,
                                          isCustomColor: true,
                                          text: carModel.name!,
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
                          ),
                        );
                      })),
                ),
              );
      },
    );
  }
}
