import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/bloc/product_bloc/product_cubit.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/helpers/functions.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/models/car_mode.dart';
import 'package:carsa/models/home_model.dart';
import 'package:carsa/widgets/Texts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_widget.dart';
import '../details_product_screen/details_product_screen.dart';
import '../home_screen/componts/rating_best.dart';

class ShoppingScreen extends StatefulWidget {
  final CategoryModel category;
  final int carModelId;
final int ststus ;
  const ShoppingScreen(this.category,this.ststus,this.carModelId);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final ScrollController _controller = ScrollController();
  int page = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ProductCubit.get(context).getProductsByCategoryPage(widget.category.id!,
        endpoint: widget.ststus==0?
    "/product/get-products-by-category-page"
    :"/product/get-products-by-barnd-page",page: 1,carId: widget.carModelId);


 //pagination
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent) {

          if (page >= ProductCubit
              .get(context)
              .responsePagination!
              .totalPage!) {
            return;
          } else {
            page++;
            ProductCubit.get(context).getProductsByCategoryPage(widget.category.id!,endpoint:widget.ststus==0? "/product/get-products-by-category-page":
            "/product/get-products-by-barnd-page",page: page,status: 1,carId: widget.carModelId);
          }

      }}
      );}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
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
              title:  Text(
                widget.category.name!,
                style: const TextStyle(color: homeColor,fontFamily: "pnuB"),
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
            body: ProductCubit.get(context).load
                ? const Center(
                    child: CircularProgressIndicator(
                      color: homeColor,
                      strokeWidth: 3,
                    ),
                  )
                :ProductCubit.get(context).responsePagination!.items!.isEmpty?
            Center(
              child: Texts(fSize: 25,
              title: "لا توجد قطع ",color: homeColor,weight: FontWeight.bold,),
            )

            :Stack(
                  children: [
                    ListView.builder(
                    controller: _controller,
                        itemCount: ProductCubit.get(context).responsePagination!.items!.length,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemBuilder: (ctx, index) {
                          Product product =
                          ProductCubit.get(context).responsePagination!.items![index];

                          return InkWell(
                              onTap: () {

                                pushPage(context: context, page: DetailsProductScreen(product:product));
                              },
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                color: Colors.white,
                                margin: paddingOnly(
                                    top: 0, bottom: 10, left: 0, right: 0),
                                padding: paddingSymmetric(hor: 10, ver: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: baseurlImage + product.image!,
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child:SizedBox()
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
                                              text: product.name!,
                                              fontFamliy: "pnuB",
                                              fontSize: 15,
                                              lines: 1,
                                              color: Colors.black),
                                               TextWidget3(
                                              alginText: TextAlign.start,
                                              isCustomColor: true,
                                              text: product.detail!,
                                              fontFamliy: "pnuB",
                                              fontSize: 13,
                                              lines: 2,
                                              color: Colors.grey),

                                          /*                                     TextWidget3(
                                          alginText: TextAlign.start,
                                          isCustomColor: true,
                                          text: "اوروبي",
                                          fontFamliy: "pnuB",
                                          fontSize: 18,
                                          color: Colors.black),
                                      const SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          TextWidget3(
                                              alginText: TextAlign.start,
                                              isCustomColor: true,
                                              text: "70 Ampree",
                                              fontFamliy: "pnuR",
                                              fontSize: 18,
                                              color: priceColor),
                                          const SizedBox(width: 100,),
                                          TextWidget3(
                                              alginText: TextAlign.start,
                                              isCustomColor: true,
                                              text: "70 جنية",
                                              fontFamliy: "pnuB",
                                              fontSize: 20,
                                              color: priceColor),

                                        ],
                                      ),*/

                                          // Row(
                                          //   children: [
                                          //     RatingBarBest(
                                          //       rate: 5,
                                          //     ),
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // CustomButton3(
                                        //     text: "اضافة الى عربة السلة",
                                        //     fontFamily: "PNUB",
                                        //     onPress: () {
                                        //
                                        //
                                        //     },
                                        //     width: 150,
                                        //     redius: 10,
                                        //     color: homeColor,
                                        //     textColor: Colors.white,
                                        //     fontSize: 14,
                                        //     height: 50),
                                        TextWidget3(
                                            alginText: TextAlign.start,
                                            isCustomColor: true,
                                            text: "${product.price}ريال ",
                                            fontFamliy: "pnuB",
                                            fontSize: 20,
                                            color: priceColor),
                                        BlocConsumer<AppCubit, AppState>(
                                          listener: (context, state) {
                                            // TODO: implement listener
                                          },
                                          builder: (context, state) {
                                            return InkWell(
                                              onTap: () {
                                                AppCubit.get(context)
                                                    .changeFavorite(product.id!,context)
                                                    .then((value) {
                                                  if(isRegistered()){
                                                    AppCubit.get(context).getFavorites();
                                                  }

                                                });
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                margin: paddingSymmetric(
                                                    hor: 5, ver: 0),
                                                decoration: decoration(
                                                    redias: 10,
                                                    color: Colors.grey
                                                        .withOpacity(.4)),
                                                child: Center(
                                                  child: Icon(
                                                    AppCubit.get(context)
                                                            .favorites
                                                            .containsValue(
                                                                product.id)
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: homeColor,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                        }),
                    ProductCubit.get(context).loadPage
                        ? Align(
                        alignment: Alignment.center,
                        child: Container(

                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(20),
                            color: Colors.black.withOpacity(.5),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ))
                        : const SizedBox()
                  ],
                ));
      },
    );
  }
}

class ListShopping extends StatelessWidget {
  const ListShopping({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: 10,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            itemBuilder: (ctx, index) {
              return InkWell(
                  onTap: () {},
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.white,
                    margin: paddingOnly(top: 0, bottom: 10, left: 0, right: 0),
                    padding: paddingSymmetric(hor: 10, ver: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/images.jpg",
                                height: 50,
                                width: 50,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget3(
                                      alginText: TextAlign.start,
                                      isCustomColor: true,
                                      text: "Deliver to mbw 14255272",
                                      fontFamliy: "pnuB",
                                      fontSize: 18,
                                      color: Colors.black),
                                  TextWidget3(
                                      alginText: TextAlign.start,
                                      isCustomColor: true,
                                      text: "اوروبي",
                                      fontFamliy: "pnuB",
                                      fontSize: 18,
                                      color: Colors.black),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget3(
                                          alginText: TextAlign.start,
                                          isCustomColor: true,
                                          text: "70 Ampree",
                                          fontFamliy: "pnuR",
                                          fontSize: 18,
                                          color: priceColor),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      TextWidget3(
                                          alginText: TextAlign.start,
                                          isCustomColor: true,
                                          text: "70 جنية",
                                          fontFamliy: "pnuB",
                                          fontSize: 20,
                                          color: priceColor),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      RatingBarBest(
                                        rate: 5,
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/images.jpg",
                                height: 50,
                                width: 50,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        TextWidget3(
                                            alginText: TextAlign.start,
                                            isCustomColor: true,
                                            text: "Deliver to mbw ",
                                            fontFamliy: "pnuB",
                                            fontSize: 18,
                                            color: Colors.black),
                                        const SizedBox(
                                          width: 50,
                                        ),
                                        Image.asset(
                                          "assets/images/mob.jpg",
                                          height: 30,
                                          width: 40,
                                          fit: BoxFit.fill,
                                        ),
                                      ],
                                    ),
                                    TextWidget3(
                                        alginText: TextAlign.start,
                                        isCustomColor: true,
                                        text: "اوروبي",
                                        fontFamliy: "pnuB",
                                        fontSize: 18,
                                        color: Colors.black),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomButton3(
                                            text: "اضافة الى عربة السلة",
                                            fontFamily: "PNUB",
                                            onPress: () {},
                                            width: 150,
                                            redius: 10,
                                            color: homeColor,
                                            textColor: Colors.white,
                                            fontSize: 14,
                                            height: 50),
                                        Container(
                                          height: 50,
                                          width: 50,
                                          margin:
                                              paddingSymmetric(hor: 5, ver: 0),
                                          decoration: decoration(
                                              redias: 10,
                                              color:
                                                  Colors.grey.withOpacity(.4)),
                                          child: const Center(
                                            child: Icon(
                                              Icons.favorite_border,
                                              color: homeColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            }));
  }
}

class ItemShopping extends StatelessWidget {
  const ItemShopping({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          height: 300,
          width: double.infinity,
          color: Colors.white,
          margin: paddingOnly(top: 0, bottom: 10, left: 0, right: 0),
          padding: paddingSymmetric(hor: 10, ver: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/images.jpg",
                      height: 50,
                      width: 50,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget3(
                            alginText: TextAlign.start,
                            isCustomColor: true,
                            text: "Deliver to mbw 14255272",
                            fontFamliy: "pnuB",
                            fontSize: 18,
                            color: Colors.black),
                        TextWidget3(
                            alginText: TextAlign.start,
                            isCustomColor: true,
                            text: "اوروبي",
                            fontFamliy: "pnuB",
                            fontSize: 18,
                            color: Colors.black),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget3(
                                alginText: TextAlign.start,
                                isCustomColor: true,
                                text: "70 Ampree",
                                fontFamliy: "pnuR",
                                fontSize: 18,
                                color: priceColor),
                            const SizedBox(
                              width: 100,
                            ),
                            TextWidget3(
                                alginText: TextAlign.start,
                                isCustomColor: true,
                                text: "70 جنية",
                                fontFamliy: "pnuB",
                                fontSize: 20,
                                color: priceColor),
                          ],
                        ),
                        Row(
                          children: [
                            RatingBarBest(
                              rate: 5,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/images.jpg",
                      height: 50,
                      width: 50,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              TextWidget3(
                                  alginText: TextAlign.start,
                                  isCustomColor: true,
                                  text: "Deliver to mbw ",
                                  fontFamliy: "pnuB",
                                  fontSize: 18,
                                  color: Colors.black),
                              const SizedBox(
                                width: 50,
                              ),
                              Image.asset(
                                "assets/images/mob.jpg",
                                height: 30,
                                width: 40,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                          TextWidget3(
                              alginText: TextAlign.start,
                              isCustomColor: true,
                              text: "اوروبي",
                              fontFamliy: "pnuB",
                              fontSize: 18,
                              color: Colors.black),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButton3(
                                  text: "اضافة الى عربة السلة",
                                  fontFamily: "PNUB",
                                  onPress: () {},
                                  width: 150,
                                  redius: 10,
                                  color: homeColor,
                                  textColor: Colors.white,
                                  fontSize: 14,
                                  height: 50),
                              Container(
                                height: 50,
                                width: 50,
                                margin: paddingSymmetric(hor: 5, ver: 0),
                                decoration: decoration(
                                    redias: 10,
                                    color: Colors.grey.withOpacity(.4)),
                                child: const Center(
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: homeColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class ItemTypeShopping extends StatelessWidget {
  const ItemTypeShopping({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingSymmetric(hor: 20.0, ver: 5.0),
      height: 60,
      width: 100,
      decoration: decoration(color: Colors.white, redias: 15),
      child: Center(
          child: Image.asset(
        "assets/images/mob.jpg",
        height: 20,
        width: 50,
        fit: BoxFit.fill,
      )),
    );
  }
}
