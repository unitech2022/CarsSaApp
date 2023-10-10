import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/bloc/workshops_cubit/workshop_cubit.dart';
import 'package:carsa/bloc/workshops_cubit/workshop_state.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/models/home_model.dart';
import 'package:carsa/ui/my_adds_screen/my_adds_screen.dart';
import 'package:carsa/ui/workshops_screen/workshop_details.dart';
import 'package:carsa/widgets/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../widgets/RatingBar.dart';
import 'add_post_screen.dart';

class WorksShopsScreen extends StatefulWidget {
  @override
  State<WorksShopsScreen> createState() => _WorksShopsScreenState();
}

class _WorksShopsScreenState extends State<WorksShopsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WorkshopCubit.get(context).getCategoriesWork().then((value) {
      WorkshopCubit.get(context).getWorkshopsByCaiId(
          catId: WorkshopCubit.get(context).categories.first.id, page: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopCubit, WorkshopState>(
        builder: (context, stateWork) {
      print(stateWork);
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              TextButton(
                onPressed: () {
                  pushPage(context: context, page: MyAddsScreen());
                },
                child: const Text(
                  "عروض الورش للعملاء",
                  style: TextStyle(
                      color: homeColor,
                      fontFamily: "pnuB",
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
            centerTitle: true,
            // leading: IconButton(
            //   onPressed: () {
            //     pop(context);
            //   },
            //   icon: const Icon(
            //     Icons.arrow_back,
            //     color: homeColor,
            //   ),
            // ),
            title: const Text(
              "الورش",
              style: TextStyle(
                  color: homeColor,
                  fontFamily: "pnuB",
                  fontWeight: FontWeight.bold),
            ),
          ),
          floatingActionButton: Transform.scale(
              scale: 1.0,
              child: FloatingActionButton(
                  backgroundColor: homeColor,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    pushPage(context: context, page: AddPostScreen());
                  })),
          body: WorkshopCubit.get(context).loadCategories
              ? const Center(
                  child: CircularProgressIndicator(
                    color: homeColor,
                    strokeWidth: 3,
                  ),
                )
              : Column(
                  children: [
                    // categories
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 40,
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                WorkshopCubit.get(context).categories.length,
                            itemBuilder: (context, index) {
                              CategoryWork categoryWork =
                                  WorkshopCubit.get(context).categories[index];
                              return GestureDetector(
                                onTap: () {
                                  WorkshopCubit.get(context)
                                      .changeIndex(categoryWork.id);

                                  WorkshopCubit.get(context)
                                      .getWorkshopsByCaiId(
                                          catId: categoryWork.id, page: 1);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 2),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: WorkshopCubit.get(context)
                                                  .currentIndex ==
                                              categoryWork.id
                                          ? homeColor
                                          : Colors.white54,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    WorkshopCubit.get(context)
                                        .categories[index]
                                        .name!,
                                    style: TextStyle(
                                        color: WorkshopCubit.get(context)
                                                    .currentIndex ==
                                                categoryWork.id
                                            ? Colors.white
                                            : homeColor),
                                  ),
                                ),
                              );
                            })),
                    SizedBox(
                      height: 5,
                    ),
                    // stateWork is GetWorkshopDataByCatIdLoad
                    //     ? const Center(
                    //         child: LinearProgressIndicator(
                    //           backgroundColor: Colors.black26,
                    //           color: homeColor,
                    //           minHeight: 4,
                    //         ),
                    //       )
                    //     : SizedBox(),
                    WorkshopCubit.get(context).loadworks
                        ? const Center(
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.black26,
                              color: homeColor,
                              minHeight: 4,
                            ),
                          ):Expanded(
                        child:  WorkshopCubit.get(context).responseModel!.items!.isEmpty?
                            Center(
                              child: Texts(
                                fSize: 16,
                                title: "لا توجد ورش",
                                color: homeColor,
                                weight: FontWeight.bold,
                              ),
                            ):
                             ListView.builder(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                itemCount:
                                    WorkshopCubit.get(context).responseModel!.items!.length,
                                itemBuilder: (ctx, index) {
                                  Workshops workshops =
                                      WorkshopCubit.get(context).responseModel!.items![index];
                                  return GestureDetector(
                                    onTap: () {
                                      pushPage(
                                          context: context,
                                          page: WorkshopDetails(workshops.id!));
                                    },
                                    child: Container(
                                      height: 200,
                                      padding: EdgeInsets.all(15),
                                      width: double.infinity,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                  imageUrl: baseurlImage +
                                                      workshops.image!,
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Texts(
                                                  fSize: 16,
                                                  weight: FontWeight.bold,
                                                  color: Colors.black,
                                                  title: workshops.name,
                                                  lines: 1,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                    width: 200,
                                                    child: Texts(
                                                      fSize: 16,
                                                      weight: FontWeight.normal,
                                                      color: Colors.grey,
                                                      title: workshops.desc,
                                                      lines: 2,
                                                    ))
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                        //address
                                        ,
                                        GestureDetector(
                                          onTap: () {
                                            HelperFunction().openGoogleMapLocation(workshops.lat,workshops.lng);
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
                                                  title: workshops.address,
                                                  lines: 1,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                        // socidl
                                        ,



                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                luncherUrl(Uri.parse(
                                                    'whatsapp://send?phone=${workshops.phoneWhats}'));
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.green),
                                                child: Icon(
                                                  FontAwesomeIcons.whatsapp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            RatingBarWidget(
                                              emptColor: Colors.grey,
                                              fillColor: Color.fromARGB(
                                                  255, 249, 205, 93),
                                              itemSize: 15,
                                              onRate: (rating) {},
                                              ratingValue: workshops.rate!,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                luncherUrl(Uri.parse(
                                                    'tel://${workshops.phone}'));
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.blueAccent),
                                                child: Icon(
                                                  Icons.call,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ]),
                                    ),
                                  );
                                }))
                       
                  ],
                ));
    });
  }
}
