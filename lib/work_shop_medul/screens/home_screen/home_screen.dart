import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/models/workshop_model.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth_cubit/auth_cubit.dart';
import '../../../bloc/workshops_cubit/workshop_cubit.dart';
import '../../../bloc/workshops_cubit/workshop_state.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/helper_function.dart';
import '../../../helpers/styles.dart';

import '../../../widgets/Texts.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/text_widget.dart';
import '../create_workshop_screen/create_workshop_screen.dart';
import '../post_detalis_screen/post_details_screen.dart';
import '../sitings_screen/seitings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WorkshopCubit.get(context).getWorkshopsByUserId();
    AuthCubit.get(context).getSitting();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopCubit, WorkshopState>(
      builder: (context, state) {
        if (state is GetWorkshopDataByUserIdSuccess) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text(
                "الرئيسية",
                style: TextStyle(
                    color: homeColor,
                    fontFamily: "pnuB",
                    fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                  onPressed: () {
                    pushPage(context: context, page: SittingsScreen());
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  )),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    WorkshopCubit.get(context).getWorkshopsByUserId();
                  },
                ),
              ],
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.grey, width: 1.5)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: baseurlImage +
                                    state.responseModel.workshop!.image!,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Texts(
                                fSize: 16,
                                weight: FontWeight.bold,
                                color: Colors.black,
                                title: state.responseModel.workshop!.name,
                                lines: 1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                  width: 200,
                                  child: Texts(
                                    fSize: 16,
                                    weight: FontWeight.normal,
                                    color: Colors.grey,
                                    title: state.responseModel.workshop!.desc!,
                                    lines: 3,
                                  ))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      )
                      //address
                      ,
                      GestureDetector(
                        onTap: () {
                          HelperFunction().openGoogleMapLocation(
                              state.responseModel.workshop!.lat,
                              state.responseModel.workshop!.lng);
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Texts(
                                fSize: 16,
                                weight: FontWeight.normal,
                                color: Colors.grey,
                                title: state.responseModel.workshop!.address,
                                lines: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                      // socidl
                      ,
                    ]),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Divider(),

                  // get Posts and offers
                  TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.red,
                    labelStyle: const TextStyle(
                        color: homeColor,
                        fontSize: 16,
                        fontFamily: "pnuB",
                        fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(
                        text: 'الطلبات الحالية',
                      ),
                      Tab(
                        text: 'عروضى',
                      )
                    ],
                    controller: _tabController,
                    indicatorColor: homeColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListPosts(
                          posts: state.responseModel.posts!,
                          workshopId: state.responseModel.workshop!.id!,
                        ),
                        ListOffers(state.responseModel.offers!,
                            state.responseModel.workshop!.id!)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is GetWorkshopDataByUserIdNotFound) {
          return Scaffold(
            backgroundColor: Colors.white,
                appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: GestureDetector(
                onTap: () {
                  signOut(ctx: context);
                },
                child: const Text(
                  "الرئيسية",
                  style: TextStyle(
                      color: homeColor,
                      fontFamily: "pnuB",
                      fontWeight: FontWeight.bold),
                ),
              ),
              leading: IconButton(
                  onPressed: () {
                    pushPage(context: context, page: SittingsScreen());
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                  )),
            ),
        
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: CustomButton3(
                      text: "انشاء ورشتى ",
                      fontFamily: "PNUB",
                      onPress: () {
                        pushPage(
                            page: const CreateWorkShopScreen(),
                            context: context);
                      },
                      redius: 10,
                      color: homeColor,
                      textColor: Colors.white,
                      fontSize: 18,
                      height: 50),
                ),
              ),
            ),
          );
        } else if (state is GetWorkshopDataByUserIdError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(
                state.message,
                style: const TextStyle(),
              ),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: homeColor,
                strokeWidth: 3,
              ),
            ),
          );
        }
      },
    );
  }
}

class ListPosts extends StatelessWidget {
  final int workshopId;
  final List<Post> posts;
  const ListPosts({required this.posts, required this.workshopId});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemCount: posts.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        Post post = posts[index];
        DateTime now = DateTime.parse(post.createdAt.toString());
        String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
        return InkWell(
            onTap: () {
              if (post.acceptedOfferId == 0 ||
                  post.acceptedOfferId == workshopId) {
                pushPage(
                    context: context,
                    page: PostDetailsScreen(
                      postId: post.id!,
                      workShopId: workshopId,
                    ));
              }
            },
            child: Container(
              width: double.infinity,
              color: Colors.white,
              margin: paddingOnly(top: 0, bottom: 10, left: 0, right: 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: post.images == "not"
                            ? baseurlImage + "a.jpeg"
                            : baseurlImage + post.images!,
                        width: 100,
                        height: 100,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.photo,
                          size: 50,
                          color: Color.fromARGB(180, 158, 158, 158),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget3(
                                    alginText: TextAlign.center,
                                    isCustomColor: true,
                                    text: post.nameCar!,
                                    fontFamliy: "pnuB",
                                    fontSize: 15,
                                    lines: 4,
                                    color: Colors.black.withOpacity(.6)),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: post.acceptedOfferId == 0
                                          ? const Color.fromARGB(
                                              255, 236, 124, 6)
                                          : Colors.green),
                                  child: TextWidget3(
                                      alginText: TextAlign.right,
                                      isCustomColor: true,
                                      text: post.acceptedOfferId == 0
                                          ? "تلقي العروض"
                                          : "تم القبول",
                                      fontFamliy: "pnuB",
                                      fontSize: 11,
                                      lines: 1,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            TextWidget3(
                                alginText: TextAlign.center,
                                isCustomColor: true,
                                text: "${formattedDate}",
                                fontFamliy: "pnuB",
                                fontSize: 15,
                                lines: 4,
                                color: Colors.grey.withOpacity(.6)),
                            SizedBox(
                              width: 240,
                              child: TextWidget3(
                                  alginText: TextAlign.right,
                                  isCustomColor: true,
                                  text: post.desc!,
                                  fontFamliy: "pnuB",
                                  fontSize: 15,
                                  lines: 2,
                                  color: Colors.grey.withOpacity(.6)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}

class ListOffers extends StatelessWidget {
  final int workshopId;
  final List<Offer> offers;
  const ListOffers(this.offers, this.workshopId);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 30),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: offers.length,
      itemBuilder: (_, i) {
        Offer offer = offers[i];

        DateTime now = DateTime.parse(offer.createdAt.toString());
        String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
        return GestureDetector(
          onTap: () {
            if (offer.accepted == 1) {
              // pushPage(
              //     context: context,
              //     page: PostDetailsScreen(
              //       postId: offer.postId!,
              //       workShopId: workshopId,
              //     ));
            }
          },
          child: Container(
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(50),
                    //       border: Border.all(color: Colors.grey, width: 1.5)),
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(50),
                    //     child: CachedNetworkImage(
                    //       imageUrl: baseurlImage +
                    //           offer.imageUrlWorkShop!,
                    //       width: 60,
                    //       height: 60,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Texts(
                                fSize: 16,
                                weight: FontWeight.bold,
                                color: Colors.black,
                                title: offer.text,
                                lines: 1,
                              ),
                            ),
                            Texts(
                              fSize: 12,
                              weight: FontWeight.bold,
                              color: Colors.grey,
                              title: formattedDate,
                              lines: 1,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            width: 240,
                            child: Texts(
                              fSize: 16,
                              weight: FontWeight.normal,
                              color: offer.accepted == 0
                                  ? Colors.grey
                                  : Colors.green,
                              title: offer.accepted == 0
                                  ? "لم يتم القبول حتي الان "
                                  : "تم قبول هذا العرض",
                              lines: 2,
                            ))
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
