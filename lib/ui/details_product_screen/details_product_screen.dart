import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/bloc/cart_cubite/cart_cubit.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/helpers/helper_function.dart';

import 'package:carsa/helpers/styles.dart';
import 'package:carsa/models/cart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_cubit/app_cubit.dart';
import '../../helpers/functions.dart';
import '../../models/home_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../navigation/navigation_screen.dart';

class DetailsProductScreen extends StatefulWidget {
  final Product product;

  const DetailsProductScreen({required this.product});

  @override
  State<DetailsProductScreen> createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (isRegistered()) AppCubit.get(context).getFavorites();
  }

  Future<bool> _willPopCallback() async {
    if (CartCubit.get(context).isFound) {
      // Navigator.pushNamed(c+963ontext, nav);
    }

    return true; //
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return CartCubit.get(context).carts.isNotEmpty
                    ? badges.Badge(
                        position: badges.BadgePosition.topStart(start: 1),
                        badgeContent: Text(
                          '${CartCubit.get(context).carts.length}',
                          style: TextStyle(color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 50.0),
                          child: FloatingActionButton.small(
                            backgroundColor: homeColor,
                            onPressed: () {
                              AppCubit.get(context).changeNav(1);

                              pushPage(
                                  page: const NavigationScreen(),
                                  context: context);
                            },
                            child: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : SizedBox();
              },
            ),
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 350,
                            width: double.infinity,
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: baseurlImage + widget.product.image!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: homeColor,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),

                              // Image.network(
                              //   baseurlImage + widget.product.image!,
                              //   width: double.infinity,
                              //   height: double.infinity,
                              //   fit: BoxFit.fill,
                              // ),
                            ),
                          ),

                          // SizedBox(
                          //   height: 350,
                          //   width: double.infinity,
                          //   child: Stack(
                          //     children: [
                          //       CarouselSlider.builder(
                          //         options: CarouselOptions(
                          //             autoPlay: false,
                          //             enableInfiniteScroll: false,
                          //             enlargeCenterPage: false,
                          //             viewportFraction: 1,
                          //             aspectRatio: 0.0,
                          //             initialPage: 0,
                          //             onPageChanged: (index, cars) {
                          //               setState(() {
                          //                 _current = index;
                          //               });
                          //             },
                          //             height: double.infinity),
                          //         itemCount: imgList.length,
                          //         itemBuilder: (BuildContext context, int itemIndex,
                          //                 int pageViewIndex) =>
                          //             SizedBox(
                          //           height: 350,
                          //           width: double.infinity,
                          //           child: ClipRRect(
                          //             child: Image.network(
                          //               imgList[itemIndex],
                          //               width: double.infinity,
                          //               height: double.infinity,
                          //               fit: BoxFit.fill,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       // Align(
                          //       //   alignment: Alignment.bottomCenter,
                          //       //   child: Row(
                          //       //     mainAxisAlignment: MainAxisAlignment.center,
                          //       //     children: map<Widget>(imgList, (index, url) {
                          //       //       return Container(
                          //       //         width: 12.0,
                          //       //         height: 12.0,
                          //       //         margin: EdgeInsets.symmetric(
                          //       //             vertical: 10.0, horizontal: 2.0),
                          //       //         decoration: BoxDecoration(
                          //       //           border: Border.all(color: homeColor, width: 1),
                          //       //           shape: BoxShape.circle,
                          //       //           color: _current == index
                          //       //               ? homeColor
                          //       //               : Colors.transparent,
                          //       //         ),
                          //       //       );
                          //       //     }),
                          //       //   ),
                          //       // )
                          //     ],
                          //   ),
                          // ),
                          DetailsProductName(widget.product),
                          SizedBox(
                            height: 20,
                          ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                                child: CustomText(
                                    family: "pnuB",
                                    size: 18,
                                    text: "السعر",
                                    textColor: homeColor,
                                    weight: FontWeight.bold,
                                    align: TextAlign.start),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: "${widget.product.price!}",
                                    style: const TextStyle(
                                        fontFamily: "pnuB",
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: ' ريال',
                                          style: TextStyle(
                                              fontFamily: "pnuB",
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                                child: CustomText(
                                    family: "pnuB",
                                    size: 18,
                                    text: "رقم القطعة",
                                    textColor: homeColor,
                                    weight: FontWeight.bold,
                                    align: TextAlign.start),
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: "${widget.product.sellerId!}",
                                    style: const TextStyle(
                                        fontFamily: "pnuB",
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    children: const <TextSpan>[

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),




                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                CustomText(
                                    family: "pnuB",
                                    size: 18,
                                    text: "الوصف",
                                    textColor: homeColor,
                                    weight: FontWeight.bold,
                                    align: TextAlign.start),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                      family: "pnuB",
                                      size: 16,
                                      text: widget.product.detail!,
                                      textColor: Colors.grey,
                                      weight: FontWeight.bold,
                                      align: TextAlign.start),
                                ),
                                // Image.asset(
                                //   "assets/images/mob.jpg",
                                //   height: 25,
                                //   width: 60,
                                // ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 10.0, vertical: 10),
                          //   child: CustomText(
                          //       family: "pnuB",
                          //       size: 16,
                          //       text: "السعر شامل الضريبة",
                          //       textColor:Colors.green,
                          //       weight: FontWeight.bold,
                          //       align: TextAlign.start),
                          // ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: CustomText(
                                family: "pnuB",
                                size: 16,
                                text: "مدة التوصيل من يوم الي سبعة أيام ",
                                textColor: Colors.black,
                                weight: FontWeight.bold,
                                align: TextAlign.start),
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                          /*  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [

                                CustomText(
                                    family: "pnuB",
                                    size: 18,
                                    text: "مدة التوصيل",
                                    textColor: homeColor,
                                    weight: FontWeight.bold,
                                    align: TextAlign.start),
                              ],
                            ),
                          ),

                          SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Row(

                              children: [



                                Expanded(
                                  child: CustomText(
                                      family: "pnuB",
                                      size: 16,
                                      text: widget.product.timeDelivery??"",
                                      textColor:Colors.grey,
                                      weight: FontWeight.bold,
                                      align: TextAlign.start),
                                ),
                                // Image.asset(
                                //   "assets/images/mob.jpg",
                                //   height: 25,
                                //   width: 60,
                                // ),
                              ],
                            ),
                          ),*/
                          const SizedBox(
                            height: 10,
                          ),

                          /* DefaultTabController(
                              length: 2,
                              child: Column(
                                children: [
                                  CustomTabBarAdds(),
                                  SizedBox(
                                    height: 200,
                                    child: TabBarView(
                                      children: [Container(), Container()],
                                    ),
                                  )
                                ],
                              ))*/
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          // child: state is AddCartGetDataLoad
                          //     ? const Center(
                          //         child: CircularProgressIndicator(
                          //           color: Colors.black,
                          //         ),
                          //       )
                          //     :
                          child: CustomButton3(
                              text: "اضافة الى عربة السلة",
                              fontFamily: "PNUB",
                              onPress: () {
                                if (CartCubit.get(context)
                                    .cartsFound
                                    .containsValue(widget.product.id)) {
                                  HelperFunction.slt.notifyUser(
                                      context: context,
                                      message: "المنتج موجود داخل السلة",
                                      color: homeColor);
                                } else {
                                  // CartCubit.get(context).isCart();
                                  Cart cart = Cart(
                                      userId: currentUser.id,
                                      image: widget.product.image,
                                      orderId: 1,
                                      price: widget.product.price,
                                      nameProduct: widget.product.name,
                                      productId: widget.product.id,
                                      productNumber: widget.product.sellerId,
                                      quantity: 1);
                                  CartCubit.get(context)
                                      .addCart(cart, context)
                                      .then((value) {
                                    AppCubit.get(context).getHomeData();
                                  });

                                  // HelperFunction.slt.notifyUser(
                                  //     context: context,
                                  //     message: "تمت الاضافة  داخل السلة",
                                  //     color: homeColor);
                                }
                              },
                              width: double.infinity,
                              redius: 10,
                              color: CartCubit.get(context)
                                      .cartsFound
                                      .containsValue(widget.product.id)
                                  ? Colors.grey.withOpacity(.5)
                                  : homeColor,
                              textColor: Colors.white,
                              fontSize: 14,
                              height: 50),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        BlocConsumer<AppCubit, AppState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                AppCubit.get(context)
                                    .changeFavorite(widget.product.id!, context)
                                    .then((value) {
                                  if (isRegistered()) {
                                    AppCubit.get(context).getHomeData();
                                    AppCubit.get(context).getFavorites();
                                  }
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                margin: paddingSymmetric(hor: 5, ver: 0),
                                decoration: decoration(
                                    redias: 10,
                                    color: Colors.grey.withOpacity(.4)),
                                child: Center(
                                  child: Icon(
                                    AppCubit.get(context)
                                            .favorites
                                            .containsValue(widget.product.id)
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
                  ),
                ),
                Positioned(
                    top: 30,
                    right: 30,
                    child: IconButton(
                      onPressed: () {
                        pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DetailsProductName extends StatelessWidget {
  final Product product;

  const DetailsProductName(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  family: "pnuB",
                  size: 15,
                  text: product.name!,
                  textColor: Colors.black,
                  weight: FontWeight.bold,
                  align: TextAlign.center),
              const SizedBox(height: 5),
              // const CustomText(
              //     family: "pnuB",
              //     size: 15,
              //     text: "product product ",
              //     textColor: Colors.black,
              //     weight: FontWeight.bold,
              //     align: TextAlign.center),
              const SizedBox(height: 5),

              // Row(
              //   children: [
              //     RatingBarBest(
              //       rate: 5,
              //     ),
              //   ],
              // ),
            ],
          ),
        )),
        /*   Expanded(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    decoration: const BoxDecoration(
                        color: homeColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25))),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CustomText(
                              family: "pnuB",
                              size: 15,
                              text: "15%",
                              textColor: Colors.white,
                              weight: FontWeight.bold,
                              align: TextAlign.center),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.local_offer_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),


                  // CustomText(
                  //    family: "pnuB",
                  //    size: 20,
                  //    text: ,
                  //    textColor: Colors.black,
                  //    weight: FontWeight.bold,
                  //    align: TextAlign.center),

                  // Text(
                  //   "100 جنية",
                  //   style: TextStyle(
                  //       fontFamily: "pnuL",
                  //       fontSize: 20,
                  //       color: Colors.black.withOpacity(.5),
                  //       height: 1.2,
                  //       decoration: TextDecoration.lineThrough),
                  // )
                ],
              ),
            ))*/
      ],
    );
  }
}

class CustomTabBarAdds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: TabBar(
          indicatorColor: homeColor,

          // padding: const EdgeInsets.only(right: 5),
          labelStyle: TextStyle(
            fontFamily: 'pnuB',
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          labelColor: homeColor,
          unselectedLabelColor: Colors.black,
          unselectedLabelStyle: TextStyle(
            fontFamily: 'pnuB',
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          labelPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          tabs: [
            Tab(text: "تفاصيل المنتج "),
            Tab(text: "تقيمات المنتج "),
          ]),
    );
  }
}
