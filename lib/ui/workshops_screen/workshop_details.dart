import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/bloc/workshops_cubit/workshop_cubit.dart';
import 'package:carsa/bloc/workshops_cubit/workshop_state.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/models/rate_response.dart';
import 'package:carsa/widgets/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/post_cubit/post_cubit.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../helpers/styles.dart';
import '../../widgets/RatingBar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class WorkshopDetails extends StatefulWidget {
  final int workshopId;

  WorkshopDetails(this.workshopId);

  @override
  State<WorkshopDetails> createState() => _WorkshopDetailsState();
}

class _WorkshopDetailsState extends State<WorkshopDetails> {
  final TextEditingController _controllerComment = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WorkshopCubit.get(context).getWorksById(widget.workshopId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerComment.dispose();
  }

  double stars = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: homeColor,
          ),
        ),
        title: const Text(
          "تفاصيل الورشة",
          style: TextStyle(
              color: homeColor,
              fontFamily: "pnuB",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<WorkshopCubit, WorkshopState>(
        builder: (context, state) {
          return WorkshopCubit.get(context).loadDetails
              ? Center(
                  child: CircularProgressIndicator(
                    color: homeColor,
                    strokeWidth: 3,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          imageUrl: baseurlImage +
                              WorkshopCubit.get(context)
                                  .workshops!
                                  .workshop!
                                  .image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Texts(
                                fSize: 20,
                                weight: FontWeight.bold,
                                color: Colors.black,
                                title: WorkshopCubit.get(context)
                                    .workshops!
                                    .workshop!
                                    .name,
                                lines: 1,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  child: Texts(
                                    fSize: 16,
                                    weight: FontWeight.normal,
                                    color: Colors.grey,
                                    title: WorkshopCubit.get(context)
                                        .workshops!
                                        .workshop!
                                        .desc,
                                    lines: 4,
                                  )),
                              SizedBox(
                                height: 10,
                              )

                              //address
                              ,
                              GestureDetector(
                                onTap: () {
                                  HelperFunction().openGoogleMapLocation(
                                      WorkshopCubit.get(context)
                                          .workshops!
                                          .workshop!
                                          .lat,
                                      WorkshopCubit.get(context)
                                          .workshops!
                                          .workshop!
                                          .lng);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Texts(
                                        fSize: 16,
                                        weight: FontWeight.normal,
                                        color: Colors.grey,
                                        title: WorkshopCubit.get(context)
                                            .workshops!
                                            .workshop!
                                            .address,
                                        lines: 3,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Texts(
                                      fSize: 15,
                                      weight: FontWeight.normal,
                                      color: Colors.red,
                                      title:
                                          "ملحوظة : التطبيق غير مسئول عن الورشة ويتحمل المسئولية صاحب الورشة",
                                      lines: 2,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      luncherUrl(Uri.parse(
                                          'whatsapp://send?phone=${WorkshopCubit.get(context).workshops!.workshop!.phoneWhats}'));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green),
                                      child: Icon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showBottomSheet(
                                        context: context,
                                        builder: (context) => BlocConsumer<
                                            WorkshopCubit, WorkshopState>(
                                          listener: (context, statbottom) {
                                            // TODO: implement listener
                                          },
                                          builder: (context, state) {
                                            return SingleChildScrollView(
                                              // controller:
                                              //     ModalScrollController.of(
                                              //         context),
                                              child: Padding(
                                                padding: MediaQuery.of(context)
                                                    .viewInsets,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 25),
                                                  height: 300,
                                                  color: Colors.white,
                                                  child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        SizedBox(
                                                          child:
                                                              RatingBar.builder(
                                                            initialRating:
                                                                stars,
                                                            minRating: 1,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                false,
                                                            itemCount: 5,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              stars = rating;
                                                              print(stars);
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        CustomTextField2(
                                                          controller:
                                                              _controllerComment,
                                                          hint: "اضافة تعليق",
                                                          inputType:
                                                              TextInputType
                                                                  .text,
                                                        ),
                                                        Spacer(),
                                                        WorkshopCubit.get(
                                                                    context)
                                                                .loadAddRate
                                                            ? const SizedBox(
                                                                height: 50,
                                                                width: 46,
                                                                child: Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color:
                                                                        homeColor,
                                                                    strokeWidth:
                                                                        3,
                                                                  ),
                                                                ),
                                                              )
                                                            : CustomButton(
                                                                height: 50,
                                                                fontFamily:
                                                                    "pnuM",
                                                                color:
                                                                    homeColor,
                                                                redius: 10.0,
                                                                isCustomColor:
                                                                    true,
                                                                onPress:
                                                                    () async {
                                                                  Rate rate = Rate(
                                                                      comment:
                                                                          _controllerComment
                                                                              .text,
                                                                      stare: stars
                                                                          .toInt(),
                                                                      workshopId: WorkshopCubit.get(
                                                                              context)
                                                                          .workshops!
                                                                          .workshop!
                                                                          .id);
                                                                  print(rate
                                                                          .stare
                                                                          .toString() +
                                                                      "${rate.comment}");
                                                                  WorkshopCubit.get(
                                                                          context)
                                                                      .addRate(
                                                                          rate,
                                                                          context)
                                                                      .then(
                                                                          (value) {});
                                                                },
                                                                text: "تقييم",
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 14,
                                                              ),
                                                      ]),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: RatingBarWidget(
                                      emptColor: Colors.grey,
                                      fillColor:
                                          Color.fromARGB(255, 249, 205, 93),
                                      itemSize: 15,
                                      onRate: (rating) {},
                                      ratingValue: WorkshopCubit.get(context)
                                          .workshops!
                                          .workshop!
                                          .rate!,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      luncherUrl(Uri.parse(
                                          'tel://${WorkshopCubit.get(context).workshops!.workshop!.phone}'));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blueAccent),
                                      child: Icon(
                                        Icons.call,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              WorkshopCubit.get(context)
                                      .workshops!
                                      .rates!
                                      .isEmpty
                                  ? SizedBox()
                                  : SizedBox(
                                      width: double.infinity,
                                      child: Texts(
                                        fSize: 16,
                                        weight: FontWeight.bold,
                                        color: Colors.black,
                                        title: "تقييم العملاء",
                                        lines: null,
                                      )),
                              SizedBox(
                                height: 10,
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: WorkshopCubit.get(context)
                                      .workshops!
                                      .rates!
                                      .length,
                                  itemBuilder: (context, index) {
                                    RateResponse rate =
                                        WorkshopCubit.get(context)
                                            .workshops!
                                            .rates![index];
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      height: 80,
                                      padding: EdgeInsets.all(10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 1.5)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: CachedNetworkImage(
                                                imageUrl: rate.userImage != null
                                                    ? baseurlImage +
                                                        rate.userImage!
                                                    : "notfound",
                                                width: 45,
                                                height: 45,
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                  Icons.person,
                                                  color: Colors.grey,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Texts(
                                                    fSize: 16,
                                                    weight: FontWeight.bold,
                                                    color: Colors.black,
                                                    title: rate.userName,
                                                    lines: 1,
                                                  ),
                                                  RatingBarWidget(
                                                    emptColor: Colors.grey,
                                                    fillColor: Color.fromARGB(
                                                        255, 249, 205, 93),
                                                    itemSize: 12,
                                                    onRate: (rating) {},
                                                    ratingValue: rate
                                                        .rate!.stare!
                                                        .toDouble(),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                  width: 240,
                                                  child: Texts(
                                                    fSize: 16,
                                                    weight: FontWeight.normal,
                                                    color: Colors.grey,
                                                    title: rate.rate!.comment,
                                                    lines: 2,
                                                  ))
                                            ],
                                          ))
                                        ],
                                      ),
                                    );
                                  })
                            ]),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
