
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/ui/shoping_screen/shoping_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/styles.dart';
import '../../../models/home_model.dart';
import '../../../widgets/text_widget.dart';

class ListNeedsOfCars extends StatelessWidget {
final List<NeedModel> list;


const ListNeedsOfCars(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 120,
            childAspectRatio: 6 / 4.7,
            crossAxisSpacing: 2,
            mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return  ItemNeedsOfCars(list[index]);
        },
      ),
    );
  }
}

class ItemNeedsOfCars extends StatelessWidget {
final NeedModel needModel;


const ItemNeedsOfCars(this.needModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        CategoryModel categoryModel=CategoryModel(name: needModel.name,
        id: needModel.id,image: needModel.image);
        pushPage(context: context, page: ShoppingScreen(categoryModel,0,1));
      },
      child: SizedBox(
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(

              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
              child: ClipRRect(

                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CachedNetworkImage(
                    imageUrl:baseurlImage+ needModel.image!, height: 50,
                      width: 50,fit: BoxFit.cover,
                    placeholder: (context, url) => const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(

                        color: homeColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                )


              ),
            ),
            const SizedBox(height: 4,),

            TextWidget3(
              color: Colors.black,
              fontFamliy: "pnuB",
              fontSize: 12,
              text: needModel.name!,
              lines: 2,
              alginText: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}