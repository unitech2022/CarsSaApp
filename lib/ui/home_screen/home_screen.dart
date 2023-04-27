import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/bloc/app_cubit/app_cubit.dart';
import 'package:carsa/helpers/functions.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/models/home_model.dart';
import 'package:carsa/ui/all_products_screen/all_products_screen.dart';
import 'package:carsa/ui/car_models_screen/car_models_screen.dart';
import 'package:carsa/ui/shoping_screen/shoping_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/constants.dart';
import '../../widgets/custom_text.dart';
import 'componts/app_bar_home.dart';
import 'componts/carsoul_widget.dart';
import 'componts/item_category.dart';
import 'componts/list_bestest.dart';
import 'componts/title_list.dart';

class HomeScreen extends StatefulWidget {
  static String id = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: homeColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "الرئيسية",
          style: TextStyle(color: Colors.white, fontFamily: "pnuR"),
        ),
      ),
      body: BlocConsumer<AppCubit, AppState>(
          listener: (ctx, state) {},
          builder: (ctx, state) {
            // if (state is HomeGetDataLoad) {
            //   return const Center(
            //     child: CircularProgressIndicator(
            //       strokeWidth: 3,
            //       color: homeColor,
            //     ),
            //   );
            // } else if (state is HomeLoadDataSuccess) {
            //   return Scaffold(
            //     body: Column(
            //       children: [
            //         Expanded(
            //             flex: 2,
            //             child: Container(
            //               height: double.infinity,
            //               width: double.infinity,
            //               decoration: const BoxDecoration(
            //                   color: homeColor,
            //                   borderRadius: BorderRadius.only(
            //                       bottomLeft: Radius.circular(15),
            //                       bottomRight: Radius.circular(15))),
            //               child: Column(
            //                 children: [
            //                   const SizedBox(
            //                     height: 30,
            //                   ),
            //                   const AppBarHome(),
            //                   const SizedBox(
            //                     height: 10,
            //                   ),
            //                   SizedBox(
            //                     height: 120,
            //                     child: ListView.builder(
            //                         itemCount:
            //                             state.homeModel.categories!.length,
            //                         scrollDirection: Axis.horizontal,
            //                         itemBuilder: (ctx, index) {
            //                           return InkWell(
            //                               onTap: () {
            //                                 Navigator.pushNamed(context, categ);
            //                               },
            //                               child: ItemCategory(state
            //                                   .homeModel.categories![index]));
            //                         }),
            //                   )
            //                 ],
            //               ),
            //             )),
            //         Expanded(
            //           flex: 4,
            //           child: SingleChildScrollView(
            //             child: Column(
            //               children: [
            //                 const SizedBox(
            //                   height: 20,
            //                 ),
            //                 CarsoulWidget(imgList: state.homeModel.sliders!),
            //                 const SizedBox(
            //                   height: 20,
            //                 ),
            //                 const CustomText(
            //                     family: "pnuB",
            //                     size: 24,
            //                     text: "ما تحتاجه السيارة دائما",
            //                     textColor: Colors.black54,
            //                     weight: FontWeight.bold,
            //                     align: TextAlign.center),
            //                 const SizedBox(
            //                   height: 20,
            //                 ),
            //                 ListNeedsOfCars(state.homeModel.needs!),
            //                 TitleList(" الاكثر مبيعا"),
            //                 ListBestSeller(state.homeModel.products!),
            //                 const SizedBox(
            //                   height: 20,
            //                 ),
            //                 Row(
            //                   children: const [
            //                     Padding(
            //                       padding:
            //                           EdgeInsets.symmetric(horizontal: 20.0),
            //                       child: CustomText(
            //                           family: "pnuB",
            //                           size: 20,
            //                           text: "الاكثر طلبا",
            //                           textColor: Colors.black54,
            //                           weight: FontWeight.bold,
            //                           align: TextAlign.center),
            //                     ),
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 20,
            //                 ),
            //                 ListBestOrder(state.homeModel.products!),
            //                 TitleList("الكوتشات الاكثر مبيعا"),
            //                 ListBestSeller(state.homeModel.products!),
            //                 TitleList("الاكسسوارات الاكثر مبيعا"),
            //                 ListBestSeller(state.homeModel.products!),
            //                 TitleList("ماركات قطع الغيار"),
            //                 SizedBox(
            //                   height: 100,
            //                   child: ListView.builder(
            //                       itemCount: state.homeModel.brands!.length,
            //                       scrollDirection: Axis.horizontal,
            //                       itemBuilder: (ctx, index) {
            //                         return SizedBox(
            //                           width: 110,
            //                           child: Card(
            //                             margin: const EdgeInsets.only(
            //                                 left: 5, right: 5, bottom: 2),
            //                             shape: RoundedRectangleBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(10),
            //                             ),
            //                             child: Padding(
            //                               padding: const EdgeInsets.all(5),
            //                               child: Center(
            //                                   child: SizedBox(
            //                                 height: 80,
            //                                 width: 80,
            //                                 child: CachedNetworkImage(
            //                                   imageUrl: baseurlImage +
            //                                       state.homeModel.brands![index]
            //                                           .image!,
            //                                   height: 60,
            //                                   width: double.infinity,
            //                                   fit: BoxFit.cover,
            //                                   placeholder: (context, url) =>
            //                                       const Padding(
            //                                     padding: EdgeInsets.all(10.0),
            //                                     child:
            //                                         CircularProgressIndicator(
            //                                       color: homeColor,
            //                                     ),
            //                                   ),
            //                                   errorWidget:
            //                                       (context, url, error) =>
            //                                           const Icon(Icons.error),
            //                                 ),
            //                               )),
            //                             ),
            //                           ),
            //                         );
            //                       }),
            //                 ),
            //                 const SizedBox(
            //                   height: 20,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   );
            // }
            /*else {
              return Center(
                child: TextWidget3(
                  color: homeColor,
                  fontSize: 13,
                  text: "حدث خطأ أثناء تحميل البيانات",
                  fontFamliy: "pnuM",
                  isCustomColor: true,
                  alginText: TextAlign.center,
                  lines: 1,
                ),
              );
            }*/
            return AppCubit.get(context).load
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: homeColor,
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: homeColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: const Center(child: AppBarHome()),
                      ),

                      /* SizedBox(
                              height: 120,
                              child: ListView.builder(
                                  itemCount:
                                  AppCubit.get(context).homeModel.categories!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (ctx, index) {
                                    CategoryModel cato= AppCubit.get(context).homeModel.categories![index];
                                    return InkWell(
                                        onTap: () {

                                          pushPage(page:ShoppingScreen(cato) ,context: context);
                                        },
                                        child: ItemCategory( AppCubit.get(context).homeModel.categories![index]));
                                  }),
                            )*/

                      Expanded(
                        flex: 5,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              AppCubit.get(context)
                                      .homeModel
                                      .sliders!
                                      .isNotEmpty
                                  ? CarsoulWidget(
                                      imgList: AppCubit.get(context)
                                          .homeModel
                                          .sliders!)
                                  : SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    const CustomText(
                                        family: "pnuB",
                                        size: 24,
                                        text: "الأقسام",
                                        textColor: Colors.black54,
                                        weight: FontWeight.bold,
                                        align: TextAlign.start),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                    itemCount: AppCubit.get(context)
                                        .homeModel
                                        .categories!
                                        .length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx, index) {
                                      CategoryModel cato = AppCubit.get(context)
                                          .homeModel
                                          .categories![index];
                                      return InkWell(
                                          onTap: () {
                                            pushPage(
                                                page: ShoppingScreen(cato, 0,0),
                                                context: context);
                                          },
                                          child: ItemCategory(
                                              AppCubit.get(context)
                                                  .homeModel
                                                  .categories![index]));
                                    }),
                              ),
                              /*  ListNeedsOfCars(AppCubit.get(context).homeModel.needs!),*/
                              /*  TitleList(" الاكثر مبيعا", () {
                                pushPage(
                                    page: AllProductsScreen(),
                                    context: context);
                              }),
                              ListBestSeller(
                                  AppCubit.get(context).homeModel.products!),*/
                              const SizedBox(
                                height: 20,
                              ),
                              /*     Row(
                          children: const [
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 20.0),
                              child: CustomText(
                                  family: "pnuB",
                                  size: 20,
                                  text: "الاكثر طلبا",
                                  textColor: Colors.black54,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListBestOrder(
                            AppCubit.get(context).homeModel.products!),
                        TitleList("الكوتشات الاكثر مبيعا"),
                        ListBestSeller(
                            AppCubit.get(context).homeModel.products!),
                        TitleList("الاكسسوارات الاكثر مبيعا"),
                        ListBestSeller(
                            AppCubit.get(context).homeModel.products!),*/
                              TitleList("ماركات قطع الغيار", () {}),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0 ,left: 20,right: 20),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 2,
                                            crossAxisSpacing: 2,
                                            childAspectRatio:1),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: AppCubit.get(context)
                                        .homeModel
                                        .brands!
                                        .length,
                                    itemBuilder: (ctx, index) {
                                      CategoryModel cate = CategoryModel(
                                          id: AppCubit.get(context)
                                              .homeModel
                                              .brands![index]
                                              .id,
                                          image: AppCubit.get(context)
                                              .homeModel
                                              .brands![index]
                                              .image,
                                          name: AppCubit.get(context)
                                              .homeModel
                                              .brands![index]
                                              .name);
                                      return InkWell(
                                        onTap: () {
                                          pushPage(
                                              page: CarModelsScreen(carId: cate.id!, nameCar: cate.name!,),
                                              context: context);
                                        },
                                        child: Card(
                                          margin: const EdgeInsets.only(
                                              left: 5, right: 5, bottom: 2),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Center(
                                                child: SizedBox(
                                              // height: 100,
                                              // width: 80,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: baseurlImage +
                                                        AppCubit.get(context)
                                                            .homeModel
                                                            .brands![index]
                                                            .image!,
                                                    height: 60,
                                                    width: double.infinity,
                                                    fit: BoxFit.contain,
                                                    placeholder: (context, url) =>
                                                        const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: homeColor,
                                                      ),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  CustomText(
                                                      family: "pnuB",

                                                      size: 18,
                                                      text: AppCubit.get(context)
                                                          .homeModel
                                                          .brands![index]
                                                          .name!,
                                                      textColor: Colors.black54,
                                                      weight: FontWeight.bold,
                                                      align: TextAlign.center),
                                                ],
                                              ),
                                            )),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
          }),
    );
  }
}
