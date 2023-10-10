import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/models/home_model.dart';
import 'package:flutter/material.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/styles.dart';
import '../../details_product_screen/details_product_screen.dart';
import 'package:carousel_indicator/carousel_indicator.dart';

class CarsoulWidget extends StatefulWidget {
  CarsoulWidget({
    Key? key,
    required this.imgList,
  }) : super(key: key);

  final List<Product> imgList;

  @override
  State<CarsoulWidget> createState() => _CarsoulWidgetState();
}

class _CarsoulWidgetState extends State<CarsoulWidget> {
  int idx = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            onPageChanged: (index, car) {
              setState(() {
                idx = index;
              });
            },
            aspectRatio: .9,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            height: 180,
            autoPlay: true,
            reverse: true,
            enableInfiniteScroll: false,
            initialPage: 0,
          ),
          itemCount: widget.imgList.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            Product sliderModel = widget.imgList[itemIndex];

            return InkWell(
              onTap: () {
                pushPage(context: context, page: DetailsProductScreen(product:sliderModel));
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: baseurlImage + widget.imgList[itemIndex].image!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: homeColor,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
              ),
            );
          },
        ),
        SizedBox(
          height: 20,
        ),
        CarouselIndicator(
          width: 10,
          height: 10,
          activeColor: Colors.red,
          color: Colors.grey,
          cornerRadius: 40,
          count: widget.imgList.length,
          index: idx,
        ),
      ],
    );
  }
}
