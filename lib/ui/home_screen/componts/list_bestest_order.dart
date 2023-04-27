import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/styles.dart';
import '../../../models/home_model.dart';
import '../../../widgets/text_widget.dart';
import '../../details_product_screen/details_product_screen.dart';

class ListBestOrder extends StatelessWidget {

  final List<Product> list;


  const ListBestOrder(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return ItemBestOrder(list[index]);
          }),
    );
  }
}

class ItemBestOrder extends StatelessWidget {
final Product product;

const ItemBestOrder(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        pushPage(context: context, page: DetailsProductScreen(product:product));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25)),
        width: 250,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child:
          SizedBox(
          height: 60,

            child: CachedNetworkImage(
              imageUrl:baseurlImage+ product.image!, height: double.infinity,
              fit: BoxFit.fill,
              width: double.infinity,
              placeholder: (context, url) => const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(

                    color: homeColor,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          )),

              //   ClipRRect(
              //     borderRadius: const BorderRadius.only(
              //         topLeft: Radius.circular(10),
              //         topRight: Radius.circular(10)),
              //     child: Image.asset(
              //       "assets/images/img.jpg",
              //      ,
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0),
                child: TextWidget2(
                  width: 200,
                  color: Colors.black,
                  fontFamliy: "pnuB",
                  fontSize: 15,
                  text: product.name!,
                  lines: 1,
                  alginText: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}