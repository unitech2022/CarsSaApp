import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/bloc/post_cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../helpers/constants.dart';
import '../../../../helpers/functions.dart';
import '../../../../helpers/styles.dart';
import '../../../../widgets/RatingBar.dart';
import '../../../../widgets/Texts.dart';
import '../../../../widgets/custom_button.dart';
import '../../../navigation/navigation_screen.dart';

class OfferDetailsScreen extends StatefulWidget {
  final int offerId;
  OfferDetailsScreen(this.offerId);
  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostCubit.get(context).getOfferDetails(offerId: widget.offerId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    pushPage(context: context, page: NavigationScreen());
                  },
                  icon: Icon(
                    Icons.home,
                    color: homeColor,
                  ))
            ],
            leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: homeColor,
              ),
            ),
            title: Text(
              "تفاصيل العرض",
              style: TextStyle(
                  color: homeColor,
                  fontFamily: "pnuB",
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: PostCubit.get(context).getOfferLoad
              ? const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: homeColor,
                      strokeWidth: 3,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          CachedNetworkImage(
                            imageUrl: baseurlImage +
                                PostCubit.get(context)
                                    .offerResponse!
                                    .workshop!
                                    .image!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Texts(
                                  fSize: 16,
                                  weight: FontWeight.bold,
                                  color: Colors.black,
                                  title: PostCubit.get(context)
                                      .offerResponse!
                                      .workshop!
                                      .name!,
                                  lines: 1,
                                ),
                                RatingBarWidget(
                                  emptColor: Colors.grey,
                                  fillColor: Color.fromARGB(255, 249, 205, 93),
                                  itemSize: 15,
                                  onRate: (rating) {},
                                  ratingValue: PostCubit.get(context)
                                      .offerResponse!
                                      .workshop!
                                      .rate!,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Texts(
                            fSize: 16,
                            weight: FontWeight.bold,
                            color: Color.fromARGB(255, 34, 34, 34),
                            title: "تفاصيل العرض",
                            lines: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(20),
                            color: Colors.white,
                            child: Texts(
                              fSize: 16,
                              weight: FontWeight.bold,
                              color: Colors.grey,
                              title: PostCubit.get(context)
                                  .offerResponse!
                                  .offer!
                                  .text!,
                              lines: null,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Texts(
                            fSize: 16,
                            weight: FontWeight.bold,
                            color: Color.fromARGB(255, 34, 34, 34),
                            title: "تواصل مع مقدم العرض ",
                            lines: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    luncherUrl(Uri.parse(
                                        'whatsapp://send?phone=+${PostCubit.get(context).offerResponse!.workshop!.phoneWhats}'));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green),
                                    child: Icon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: (){
                                     luncherUrl( Uri.parse('tel://${PostCubit.get(context).offerResponse!.workshop!.phone}'));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blueAccent),
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                    PostCubit.get(context).offerResponse!.offer!.accepted==0
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: PostCubit.get(context).acceptOfferLoad
                                ? SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: homeColor,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: CustomButton3(
                                        text: "قبول العرض",
                                        fontFamily: "PNUB",
                                        onPress: () {
                                          PostCubit.get(context).acceptOffer(
                                              offerId: PostCubit.get(context)
                                                  .offerResponse!
                                                  .offer!
                                                  .id!,
                                              context: context);
                                        },
                                        redius: 10,
                                        color: homeColor,
                                        textColor: Colors.white,
                                        fontSize: 18,
                                        height: 50),
                                  ),
                          )
                        : SizedBox()
                  ],
                ),
        );
      },
    );
  }
}
