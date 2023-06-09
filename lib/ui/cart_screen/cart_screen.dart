import 'package:cached_network_image/cached_network_image.dart';

import 'package:carsa/bloc/cart_cubite/cart_cubit.dart';
import 'package:carsa/helpers/functions.dart';
import 'package:carsa/helpers/helper_function.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/ui/method_payment/method_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/constants.dart';
import '../../models/cart.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/text_widget.dart';
import '../details_product_by_id/details_product_by_id.dart';
import '../home_screen/componts/rating_best.dart';
import '../login_screen/login_screen.dart';
import 'componts/box_total_and_button.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // final double _initFabHeight = 120.0;
  // double _fabHeight = 0;
  // double _panelHeightOpen = 0;
  // final double _panelHeightClosed = 10.0;
  final key = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();

    // printFunction(CartCubit.get(context).carts.length);
  if (isRegistered()) CartCubit.get(context).getCarts();
    // _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    // _panelHeightOpen = MediaQuery.of(context).size.height * .60;
    return BlocConsumer<CartCubit, CartState>(listener: (ctx, state) {
      if (state is DeleteCartLoadDataSuccess) {
        Future.delayed(Duration.zero, () {
          HelperFunction.slt.notifyUser(
              context: ctx, color: homeColor, message: state.success);
        });
      }
    }, builder: (ctx, state) {
      if (state is GetCartGetDataLoad) {
        return const Center(
          child: CircularProgressIndicator(
            color: homeColor,
            strokeWidth: 3,
          ),
        );
      }

      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: CustomText(
                family: "pnuB",
                size: 20,
                text: "عربة التسوق",
                textColor: Colors.black,
                weight: FontWeight.w300,
                align: TextAlign.center),
          ),
          body: isRegistered()
              ? CartCubit.get(context).carts.isNotEmpty
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        buildlistCart(CartCubit.get(context).carts),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /*  ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18.0),
                                  topRight: Radius.circular(18.0)),
                              child: SlidingUpPanel(
                                maxHeight: _panelHeightOpen,
                                minHeight: 50.0,
                                parallaxEnabled: true,
                                parallaxOffset: .5,
                                panel: Container(
                                    height: 50,
                                    alignment: Alignment.topCenter,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(18.0),
                                            topRight: Radius.circular(18.0))),
                                    child: Column(
                                      children: const [
                                        Icon(
                                          Icons.drag_handle,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        CustomText(
                                            family: "pnuB",
                                            size: 25,
                                            text: "عربة التسوق",
                                            textColor: Colors.black,
                                            weight: FontWeight.w300,
                                            align: TextAlign.center)
                                      ],
                                    )),
                                panelBuilder: (sc) => const SizedBox(),
                                onPanelSlide: (double pos) => setState(() {
                                  _fabHeight = pos *
                                          (_panelHeightOpen -
                                              _panelHeightClosed) +
                                      _initFabHeight;
                                }),
                              ),
                            ),*/
                                  // OrderCubit.get(context).loadAddOrder
                                  //     ? const SizedBox(
                                  //         height: 50,
                                  //         width: 50,
                                  //         child: Center(
                                  //             child: CircularProgressIndicator(
                                  //           color: homeColor,
                                  //           strokeWidth: 3,
                                  //         )))
                                  BoxTotalAndButton(() {
                                    pushPage(
                                        context: context,
                                        page: MethodPaymentScreen(
                                          total: CartCubit.get(context).total,
                                        ));
                                    // OrderCubit.get(context).addOrder()
                                  }, "${CartCubit.get(context).total}")
                                ],
                              ),
                            ))
                      ],
                    )
                  : Center(
                      child: TextWidget3(
                        color: homeColor,
                        fontSize: 26,
                        text: "الســلة فارغة",
                        fontFamliy: "pnuR",
                        isCustomColor: true,
                        alginText: TextAlign.center,
                        lines: 1,
                      ),
                    )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: CustomButton3(
                        text: "الانتقال الي صفحة التسجيل",
                        fontFamily: "PNUB",
                        onPress: () {
                          pushPage(page: LoginScreen(), context: context);
                        },
                        redius: 10,
                        color: homeColor,
                        textColor: Colors.white,
                        fontSize: 18,
                        height: 50),
                  ),
                ));
    }

        // else {
        //   return Center(
        //     child: TextWidget3(
        //       color: homeColor,
        //       fontSize: 16,
        //       text: "حدث خطأ أثناء تحميل البيانات",
        //       fontFamliy: "pnuR",
        //       isCustomColor: true,
        //       alginText: TextAlign.center,
        //       lines: 1,
        //     ),
        //   );
        // }

        );
  }

  double total = 0.0;

  getTotal() {
    double total = 0.0;
    CartCubit.get(context).carts.forEach((element) {
      total += element.price!;

      // setState(() {});
    });
    printFunction(total);
  }

  Container buildlistCart(List<Cart> list) {
    return Container(
      margin: paddingOnly(left: 0, right: 0, top: 0, bottom: 150),
      child: AnimatedList(
          padding: EdgeInsets.zero,
          key: key,
          initialItemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index, animation) {
            return ScaleTransition(
              scale: animation,
              child: InkWell(

                  onTap: (){
                    pushPage(context: context,page: DetailsProductById(list[index].productId!));
                  },
                child: Container(
                  height: 130,
                  padding: paddingSymmetric(hor: 20, ver: 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: baseurlImage + list[index].image!,
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
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget3(
                                  alginText: TextAlign.start,
                                  isCustomColor: true,
                                  text: list[index].nameProduct!,
                                  fontFamliy: "pnuB",
                                  fontSize: 15,
                                  color: Colors.black),
                              RatingBarBest(
                                rate: 5,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  CartCubit.get(context).quantities[index]++;
                                  CartCubit.get(context).total +=
                                      list[index].price;
                                  CartCubit.get(context).prices[index] =
                                      double.parse("${list[index].price}") *
                                          CartCubit.get(context)
                                              .quantities[index];

                                  Cart cart = Cart(
                                      quantity: CartCubit.get(context)
                                          .quantities[index],
                                      productId: list[index].productId,
                                      nameProduct: list[index].nameProduct,
                                      orderId: list[index].orderId,
                                      image: list[index].image,
                                      userId: list[index].userId,
                                      price: list[index].price,
                                      total: CartCubit.get(context).prices[index],
                                      id: list[index].id);
                                  CartCubit.get(context).updateCart(cart);
                                  print(CartCubit.get(context).quantities[index]);
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.add_circle,
                                  color: homeColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextWidget3(
                                  alginText: TextAlign.start,
                                  isCustomColor: true,
                                  text:
                                      "${CartCubit.get(context).quantities[index]}",
                                  fontFamliy: "pnuB",
                                  fontSize: 18,
                                  color: Colors.black),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  if (CartCubit.get(context).quantities[index] >
                                      1) {
                                    CartCubit.get(context).quantities[index]--;
                                    CartCubit.get(context).total -=
                                        list[index].price;
                                    CartCubit.get(context).prices[index] =
                                        double.parse("${list[index].price}") *
                                            CartCubit.get(context)
                                                .quantities[index];

                                    Cart cart = Cart(
                                        quantity: CartCubit.get(context)
                                            .quantities[index],
                                        productId: list[index].productId,
                                        nameProduct: list[index].nameProduct,
                                        orderId: list[index].orderId,
                                        image: list[index].image,
                                        userId: list[index].userId,
                                        price: list[index].price,
                                        total:
                                            CartCubit.get(context).prices[index],
                                        id: list[index].id);
                                    CartCubit.get(context).updateCart(cart);
                                    // getTotal();
                                    print(
                                        CartCubit.get(context).quantities[index]);
                                    setState(() {});
                                  }
                                },
                                child: const Icon(
                                  Icons.remove_circle_outline,
                                  color: homeColor,
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                Cart cart = list.removeAt(index);

                                key.currentState!.removeItem(index,
                                    (context, animation) {
                                  return buildItem(cart, animation, index);
                                });
                                CartCubit.get(context)
                                    .deleteCart(cart.id!)
                                    .then((value) {});
                              },
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: homeColor,
                              )),
                          TextWidget3(
                              alginText: TextAlign.start,
                              isCustomColor: true,
                              text:
                                  " ${CartCubit.get(context).prices[index]} ريال ",
                              fontFamliy: "pnuB",
                              fontSize: 20,
                              color: priceColor),
                          Container(
                            height: 40,
                            width: 40,
                            margin: paddingSymmetric(hor: 5, ver: 0),
                            decoration: decoration(
                                redias: 10, color: Colors.grey.withOpacity(.4)),
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
                ),
              ),
            );
          }),
    );
  }

  ScaleTransition buildItem(Cart cart, Animation<double> animation, int index) {
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
                    color: Colors.blue,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget3(
                        alginText: TextAlign.start,
                        isCustomColor: true,
                        text: cart.nameProduct!,
                        fontFamliy: "pnuB",
                        fontSize: 15,
                        color: Colors.black),
                    RatingBarBest(
                      rate: 5,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.add_circle,
                      color: homeColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextWidget3(
                        alginText: TextAlign.start,
                        isCustomColor: true,
                        text: "${cart.quantity!}",
                        fontFamliy: "pnuB",
                        fontSize: 18,
                        color: Colors.black),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.remove_circle_outline,
                      color: homeColor,
                    )
                  ],
                ),
              ],
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: homeColor,
                    )),
                SizedBox(
                  height: 5,
                ),
                TextWidget3(
                    alginText: TextAlign.start,
                    isCustomColor: true,
                    text: " ريال${cart.id!}",
                    fontFamliy: "pnuB",
                    fontSize: 20,
                    color: priceColor),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 40,
                  width: 40,
                  margin: paddingSymmetric(hor: 5, ver: 0),
                  decoration: decoration(
                      redias: 10, color: Colors.grey.withOpacity(.4)),
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
      ),
    );
  }
}
