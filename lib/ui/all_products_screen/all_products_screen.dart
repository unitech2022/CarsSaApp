import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../../bloc/product_bloc/product_cubit.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../../models/home_model.dart';
import '../../widgets/text_widget.dart';
import '../details_product_screen/details_product_screen.dart';
import '../home_screen/componts/rating_best.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductCubit.get(context).getAllProducts();
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
                "كل المنتجات",
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
            body: ProductCubit.get(context).loadGetProducts
                ? const Center(
              child: CircularProgressIndicator(
                color: homeColor,
                strokeWidth: 3,
              ),
            )
                : ListView.builder(
                itemCount: ProductCubit.get(context).listAllProducts.length,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (ctx, index) {
                  Product product =
                  ProductCubit.get(context).listAllProducts[index];

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
                        padding: paddingSymmetric(hor: 10, ver: 0),
                        child: Stack(
                          children: [
                            product.offerId == 1?
                            Align(
                              alignment: Alignment.topLeft,
                              child: Icon(Icons.local_offer,color: Colors.red,size: 20,),
                            ):SizedBox(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: baseurlImage + product.image!,
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
                                          text: product.name!,
                                          fontFamliy: "pnuB",
                                          fontSize: 18,
                                          lines: 2,
                                          color: Colors.black),

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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        text: "${product.price}  ريال ",
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
                          ],
                        ),
                      ));
                }));
      },
    );
  }
}
