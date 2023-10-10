import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/bloc/app_cubit/app_cubit.dart';
import 'package:carsa/helpers/functions.dart';
import 'package:carsa/models/home_model.dart';
import 'package:carsa/ui/home_screen/componts/rating_best.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/styles.dart';
import '../../../widgets/text_widget.dart';
import '../../details_product_screen/details_product_screen.dart';


class ListBestSeller extends StatelessWidget {
  final List<Product> list;

  const ListBestSeller(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
          itemCount:list.length >4? 4:list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return ItemListBestSeller(list[index]);
          }),
    );
  }
}

class ItemListBestSeller extends StatelessWidget {
  final Product product;

  const ItemListBestSeller(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        pushPage(context: context, page: DetailsProductScreen(product:product));

      },
      child: SizedBox(
        width: 150,
        child: Card(
          margin: const EdgeInsets.only(left: 5, right: 5, bottom: 2),
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5),
            child: Stack(
              children: [
                product.offerId == 1?
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Container(
                          height: 30,
                          width: 20,
                          color: Colors.red,
                          child: Icon(Icons.local_offer_outlined,color: Colors.white,size: 15,),
                        ),
                      ),
                    ):SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: CachedNetworkImage(
                              imageUrl: baseurlImage + product.image!,
                              height: 60,
                              width: 60,
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
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget3(

                      color: Colors.black,
                      fontFamliy: "pnuB",
                      fontSize: 13,
                      text: product.name!,
                      lines: 2,
                      alginText: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    TextWidget2(
                      width: double.infinity,
                      color: Colors.black45,
                      isCustomColor: true,
                      fontFamliy: "pnuR",
                      fontSize: 12,
                      text: product.detail!,
                      lines: 2,
                      alginText: TextAlign.start,
                    ),
/*                    const SizedBox(
                      height: 2,
                    ),
                    TextWidget2(
                      width: 150,
                      color: priceColor,
                      fontFamliy: "pnuR",
                      fontSize: 14,
                      text: product.sellerId!,
                      isCustomColor: true,
                      lines: 1,
                      alginText: TextAlign.start,
                    ),*/
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        RatingBarBest(
                          rate: 5,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    TextWidget2(
                      width: 150,
                      color: Colors.black,
                      fontFamliy: "pnuR",
                      fontSize: 14,
                      text: "${product.price} ريال ",
                      isCustomColor: true,
                      lines: 1,
                      alginText: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    // TextWidget2(
                    //   width: 150,
                    //   color: Colors.black,
                    //   fontFamliy: "pnuR",
                    //   fontSize: 14,
                    //   text: product.detailsPrice!?"شـامل الضريبة":"غير شـامل الضريبة",
                    //   isCustomColor: true,
                    //   lines: 1,
                    //   alginText: TextAlign.start,
                    // ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {

                            AppCubit.get(context).changeFavorite(product.id!,context)
                            .then((value){
                              if(isRegistered()){

                                AppCubit.get(context).getFavorites();

                              }

                            });

                          },
                          icon:  Icon(
                            AppCubit.get(context).favorites.containsValue(product.id)? Icons.favorite:Icons.favorite_border,
                            color: homeColor,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


