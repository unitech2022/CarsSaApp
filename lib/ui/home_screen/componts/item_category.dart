import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/models/home_model.dart';
import 'package:carsa/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCategory extends StatelessWidget {
final CategoryModel category;


const ItemCategory(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: CachedNetworkImage(
                imageUrl:baseurlImage+ category.image!,height: 100,width: double.infinity,fit: BoxFit.cover,
                placeholder: (context, url) => const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: CircularProgressIndicator(

                      color: homeColor,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )
            ,
            const SizedBox(
              height: 10,
            ),

            TextWidget3(
              color: Colors.black,
              fontFamliy: "pnuB",
              fontSize: 15,
              text: category.name! ,
              lines: 2,
              alginText:TextAlign.center,
            )
          ],
        ),

      ),
    );
  }
}