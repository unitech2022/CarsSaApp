import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/bloc/app_cubit/app_cubit.dart';
import 'package:carsa/models/favorite.dart';
import 'package:carsa/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/text_widget.dart';
import '../details_product_screen/details_product_screen.dart';
import '../home_screen/componts/rating_best.dart';

class MyFavoriteScreen extends StatefulWidget {
  MyFavoriteScreen({Key? key}) : super(key: key);

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  final keyAnimated = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: CustomText(
                family: "pnuB",
                size: 25,
                text: "المفضلة",
                textColor: Colors.black,
                weight: FontWeight.w300,
                align: TextAlign.center),
            automaticallyImplyLeading: true,
          ),
          body: AppCubit.get(context).loadFav
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: homeColor,
                  ),
                )
              : AnimatedList(
                  padding: EdgeInsets.zero,
                  key: keyAnimated,
                  initialItemCount: AppCubit.get(context).favoritesData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index, animation) {
                    return InkWell(
                      onTap: () {
                        Product product = Product(
                            image: AppCubit.get(context)
                                .favoritesData[index]
                                .image,
                            status: AppCubit.get(context)
                                .favoritesData[index]
                                .status,
                            id: AppCubit.get(context)
                                .favoritesData[index]
                                .productId,
                            name:
                                AppCubit.get(context).favoritesData[index].name,
                            categoryId: AppCubit.get(context)
                                .favoritesData[index]
                                .categoryId,
                            price: AppCubit.get(context)
                                .favoritesData[index]
                                .price,
                            brandId: AppCubit.get(context)
                                .favoritesData[index]
                                .brandId,
                            detail: AppCubit.get(context)
                                .favoritesData[index]
                                .detail,
                            offerId: 0,
                            detailsPrice: false,
                            isCart: AppCubit.get(context)
                                .favoritesData[index]
                                .isCart,
                            isFav: AppCubit.get(context)
                                .favoritesData[index]
                                .isFav,
                            timeDelivery: "",
                            sellerId: AppCubit.get(context)
                                .favoritesData[index]
                                .sellerId);
                        pushPage(
                            context: context,
                            page: DetailsProductScreen(product: product));
                      },
                      child: ScaleTransition(
                        scale: animation,
                        child: Container(
                          height: 130,
                          padding: paddingSymmetric(hor: 20, ver: 10),
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          color: Colors.white,
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: baseurlImage +
                                    AppCubit.get(context)
                                        .favoritesData[index]
                                        .image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                                placeholder: (context, url) => const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget3(
                                      alginText: TextAlign.start,
                                      isCustomColor: true,
                                      text: AppCubit.get(context)
                                          .favoritesData[index]
                                          .name!,
                                      fontFamliy: "pnuB",
                                      fontSize: 15,
                                      color: Colors.black),
                                  TextWidget3(
                                      alginText: TextAlign.start,
                                      isCustomColor: true,
                                      text: AppCubit.get(context)
                                          .favoritesData[index]
                                          .detail!,
                                      fontFamliy: "pnuB",
                                      fontSize: 15,
                                      lines: 2,
                                      color: Colors.grey),
                                ],
                              )),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        Favorite cart = AppCubit.get(context)
                                            .favoritesData
                                            .removeAt(index);

                                        keyAnimated.currentState!.removeItem(
                                            index, (context, animation) {
                                          return buildItem(
                                              cart, animation, index);
                                        });
                                        AppCubit.get(context)
                                            .changeFavorite(
                                                cart.productId!, context)
                                            .then((value) {
                                          if (isRegistered()) {
                                            AppCubit.get(context).getHomeData();
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline_rounded,
                                        color: homeColor,
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextWidget3(
                                      alginText: TextAlign.start,
                                      isCustomColor: true,
                                      text:
                                          "${AppCubit.get(context).favoritesData[index].price} ريال ",
                                      fontFamliy: "pnuB",
                                      fontSize: 20,
                                      color: priceColor),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
        );
      },
    );
  }

  ScaleTransition buildItem(
      Favorite cart, Animation<double> animation, int index) {
    return ScaleTransition(
      scale: animation,
      child: Container(
        height: 130,
        padding: paddingSymmetric(hor: 20, ver: 10),
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: baseurlImage + cart.image!,
              width: 100,
              height: 100,
              fit: BoxFit.fill,
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget3(
                        alginText: TextAlign.start,
                        isCustomColor: true,
                        text: cart.name!,
                        fontFamliy: "pnuB",
                        fontSize: 15,
                        color: Colors.black),
                    RatingBarBest(
                      rate: 5,
                    ),
                  ],
                ),
                TextWidget3(
                    alginText: TextAlign.start,
                    isCustomColor: true,
                    text: cart.detail!,
                    fontFamliy: "pnuB",
                    fontSize: 15,
                    color: Colors.black),
              ],
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: homeColor,
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextWidget3(
                    alginText: TextAlign.start,
                    isCustomColor: true,
                    text: " جنية${cart.price}",
                    fontFamliy: "pnuB",
                    fontSize: 20,
                    color: priceColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
