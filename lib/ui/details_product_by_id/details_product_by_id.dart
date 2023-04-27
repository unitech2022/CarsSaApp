import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/app_cubit/app_cubit.dart';
import '../../bloc/cart_cubite/cart_cubit.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../helpers/styles.dart';
import '../../models/cart.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../details_product_screen/details_product_screen.dart';
import '../navigation/navigation_screen.dart';

class DetailsProductById extends StatefulWidget {
  final int productId;


  DetailsProductById(this.productId);

  @override
  State<DetailsProductById> createState() => _DetailsProductByIdState();
}

class _DetailsProductByIdState extends State<DetailsProductById> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(isRegistered())AppCubit.get(context).getFavorites();

    CartCubit.get(context).getProductById(id: widget.productId);

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
                    ? Badge(
                  position: BadgePosition.topStart(start: 1),
                  badgeContent:
                  Text('${CartCubit.get(context).carts.length}',style: TextStyle(color: Colors.white),),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: FloatingActionButton.small(

                      backgroundColor: homeColor,
                      onPressed: () {

                        AppCubit.get(context).changeNav(1);

                        pushPage(page: const NavigationScreen(),context: context);


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
            body: CartCubit.get(context).loadProductById?

            const Center(
              child: CircularProgressIndicator(
                color: homeColor,
                strokeWidth: 3,
              ),
            ):
            CartCubit.get(context).product!=null? Stack(
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
                                imageUrl: baseurlImage+CartCubit.get(context).product!.image!,

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


                          DetailsProductName(CartCubit.get(context).product!),
                          SizedBox(
                            height: 20,

                          ),
                          Padding(
                            padding:const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                CustomText(
                                    family: "pnuB",
                                    size: 18,
                                    text: "السعر",
                                    textColor: homeColor,
                                    weight: FontWeight.bold,
                                    align: TextAlign.start),




                              ],
                            ),
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
                                        text: "${CartCubit.get(context).product!.price!}",
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
                                        text: "${CartCubit.get(context).product!.sellerId!}",
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
                            height: 1,color: Colors.grey,
                          ),
                          SizedBox(height: 20,),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                      text: CartCubit.get(context).product!.detail!,
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
                          ),
                          Divider(
                            height: 1,color: Colors.grey,
                          ),
                          SizedBox(height: 20,),
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
                                textColor:Colors.black,
                                weight: FontWeight.bold,
                                align: TextAlign.start),
                          ),
                          Divider(
                            height: 1,color: Colors.grey,
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
                                if (CartCubit.get(context).cartsFound.containsValue(CartCubit.get(context).product!.id)) {
                                  HelperFunction.slt.notifyUser(
                                      context: context,
                                      message: "المنتج موجود داخل السلة",
                                      color: homeColor);
                                } else {
                                  // CartCubit.get(context).isCart();
                                  Cart cart = Cart(
                                      userId: currentUser.id,
                                      image:CartCubit.get(context).product!.image,
                                      orderId: 1,
                                      price: CartCubit.get(context).product!.price,
                                      nameProduct: CartCubit.get(context).product!.name,
                                      productId: CartCubit.get(context).product!.id,
                                      productNumber:CartCubit.get(context).product!.sellerId,
                                      quantity: 1);
                                  CartCubit.get(context)
                                      .addCart(cart,context)
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
                              color: CartCubit.get(context).cartsFound.containsValue(CartCubit.get(context).product!.id)
                                  ? Colors.grey.withOpacity(.5)
                                  : homeColor,
                              textColor: Colors.white,
                              fontSize: 14,
                              height: 50),
                        ),
                        SizedBox(width: 10,),
                        BlocConsumer<AppCubit, AppState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            return InkWell(
                              onTap: (){
                                AppCubit.get(context).changeFavorite(CartCubit.get(context).product!.id!,context).then((value){
                                  if(isRegistered()){
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
                                        .favorites.containsValue(CartCubit.get(context).product!.id)
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
                      onPressed: (){
                        pop(context);
                      },
                      icon: Icon(Icons.arrow_back,color: Colors.black,),
                    )),
              ],
            ) :Center(
              child:  CustomText(
                  family: "pnuB",
                  size: 16,
                  text: "المنتج غير موجود ",
                  textColor:Colors.black,
                  weight: FontWeight.bold,
                  align: TextAlign.center),
            ) ,
          );
        },
      ),
    );
  }
}

