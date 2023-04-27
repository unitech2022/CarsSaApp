import 'dart:io';

import 'package:carsa/bloc/app_cubit/app_cubit.dart';

import 'package:carsa/helpers/router.dart';
import 'package:carsa/ui/login_screen/login_screen.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:carsa/ui/my_adds_screen/my_adds_screen.dart';
import 'package:carsa/ui/privacy_policy/privacy_policy_screen.dart';
import 'package:carsa/ui/suggestions_screen/suggestions_screen.dart';
import 'package:carsa/ui/support/Support.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../helpers/styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/text_widget.dart';
import 'componts/bar_my_profile.dart';
import 'componts/container_profile_text.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // AppCubit.get(context).getUserDetails();
    //
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: homeColor,
            automaticallyImplyLeading: false,
          ),
          body:isRegistered()? AppCubit.get(context).load
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: homeColor,
                  ),
                )
              : Column(
                  children: [
                    Expanded(flex: 2, child: BarMyProfile(() {})),
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            ContainerProfileText(
                              text: "تعديل بياناتى",
                              icon: Icons.perm_identity_sharp,
                              onPress: () {
                                Navigator.pushNamed(context, edit);
                              },
                            ),
                            ContainerProfileText(
                              text: "اعلاناتى",
                              icon: Icons.local_offer_outlined,
                              onPress: () {
                                pushPage(
                                    context: context, page: MyAddsScreen());
                              },
                            ),
                            ContainerProfileText(
                              text: "المفضلة",
                              icon: Icons.favorite_border,
                              onPress: () {
                                Navigator.pushNamed(context, fav);
                              },
                            ),
                            ContainerProfileText(
                              text: "عناوين التوصيل المضافة",
                              icon: Icons.location_on_outlined,
                              onPress: () {
                                Navigator.pushNamed(context, myAddress);
                              },
                            ),
                            ContainerProfileText(
                              text: "طلباتى",
                              icon: Icons.add_shopping_cart_rounded,
                              onPress: () {
                                Navigator.pushNamed(context, myOrders);
                              },
                            ),

                            ContainerProfileText(
                              text: "الشكاوي والاقتراحات",
                              icon: Icons.comment,
                              onPress: () {
                                pushPage(
                                    context: context,
                                    page: SuggestionsScreen());
                              },
                            ),


                            // ContainerProfileText(
                            //   text: "اضافة اعلان",
                            //   icon: Icons.add,
                            //   onPress: () {
                            //     pushPage(
                            //         context: context, page: Support());
                            //   },
                            // ),
                            ContainerProfileText(
                              text: "الدعم الفني ",
                              icon: Icons.support,
                              onPress: () {
                                pushPage(context: context, page: Support());
                              },
                            ),
                            AppCubit.get(context).loadSittings
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: homeColor,
                                    ),
                                  )
                                : Column(
                                    children: [
                                      // AppCubit.get(context).homeModel.sittings![index]
                                      ContainerProfileText(
                                        text: "اتصل بنا",
                                        icon: Icons.call,
                                        onPress: () {

                                          HelperFunction.slt
                                              .showSheet(context, _callUs(context));




                                        },
                                      ),
                                      ContainerProfileText(
                                        text: "سياسة الخصوصية",
                                        icon: Icons.info_outline,
                                        onPress: () {
                                          pushPage(
                                              context: context,
                                              page: PrivacyPolicyScreen(
                                              value:AppCubit.get(context).homeModel.sittings![1].value!,
                                          title:AppCubit.get(context).homeModel.sittings![1].name!));
                                        },
                                      ),
                                      ContainerProfileText(
                                        text: "سياسة الضمان",
                                        icon: Icons.approval,
                                        onPress: () {
                                          pushPage(
                                              context: context,
                                              page: PrivacyPolicyScreen(
                                                  value:AppCubit.get(context).homeModel.sittings![5].value!,
                                                  title:AppCubit.get(context).homeModel.sittings![5].name!));
                                        },
                                      ),
                                      ContainerProfileText(
                                        text: "سياسة الاستبدال والاسترجاع",
                                        icon: Icons.all_inclusive,
                                        onPress: () {
                                          pushPage(
                                              context: context,
                                              page: PrivacyPolicyScreen(
                                                  value:AppCubit.get(context).homeModel.sittings![10].value!,
                                                  title:AppCubit.get(context).homeModel.sittings![10].name!));
                                        },
                                      ),
                                      ContainerProfileText(
                                        text: " الاسئلة الشائعة",
                                        icon: Icons.help,
                                        onPress: () {
                                          pushPage(
                                              context: context,
                                              page: PrivacyPolicyScreen(
                                                  value:AppCubit.get(context).homeModel.sittings![6].value!,
                                                  title:AppCubit.get(context).homeModel.sittings![6].name!));
                                        },
                                      ),
                                      // ContainerProfileText(
                                      //   text: "الشحن والتوصيل",
                                      //   icon: Icons.electric_car_rounded,
                                      //   onPress: () {
                                      //     pushPage(
                                      //         context: context,
                                      //         page: SuggestionsScreen());
                                      //   },
                                      // ),

                                    ],
                                  ),

                            ContainerProfileText(
                              text: "الحسابات الاجتماعية ",
                              icon: Icons.mail_outlined,
                              onPress: () {
                                HelperFunction.slt
                                    .showSheet(context, _selectApp(context));
                              },
                            ),



                            ContainerProfileText(
                              text: "التوثيق  :  معروف",
                              icon: Icons.web,
                              onPress: () async{
                                var url = Uri.parse(AppCubit.get(context)
                                    .homeModel
                                    .sittings![13]
                                    .value!);
                                if (await canLaunchUrl(url))
                                await launchUrl(url);
                                else
                                // can't launch url, there is some error
                                throw "Could not launch $url";
                                // Navigator.pushNamed(context, fav);
                              },
                            ),


                            ContainerProfileText(
                              text: "تقييم التطبيق ",
                              icon: Icons.star_rate_outlined,
                              onPress: () {
                               HelperFunction.slt.rateApp(appPackageName: "com.carsa.carsa");
                              },
                            ),
                            ContainerProfileText(
                              text: "مشاركة التطبيق ",
                              icon: Icons.share,
                              onPress: ()async {
                                await FlutterShare.share(
                                    title: 'مشاركة التطبيق',
                                    text: 'Car sa تطبيق قطع السيارات',
                                    linkUrl: 'https://play.google.com/store/apps/details?id=com.carsa.carsa&pli=1',
                                    chooserTitle: 'Car sa تطبيق قطع السيارات'
                                );

                                // Share.share('https://play.google.com/store/apps/details?id=com.awarake.awarake');
                              },
                            ),

                            ContainerProfileText(
                              text: "تسجيل الخروج",
                              icon: Icons.logout,
                              onPress: () {
                                signOut(ctx: context);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ):Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
            child: CustomButton3(
                  text: "الانتقال الي صفحة التسجيل",
                  fontFamily: "PNUB",
                  onPress: () {
                    pushPage(page: LoginScreen(), context: context);
                  },
                  redius: 10,
                  color: homeColor,
                  textColor: Colors.white,
                  fontSize: 18,
                  height: 50),
          ),
                ),
        );
      },
    );
  }

  _selectApp(context) => Container(
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 24,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.5),
                  color: const Color(0xFFDCDCDF),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          HelperFunction.slt.launchSocial(
                             "fb://profile/"+ AppCubit.get(context)
                                  .homeModel
                                  .sittings![7]
                                  .name!,
                              "https://www.facebook.com/"+AppCubit.get(context)
                                  .homeModel
                                  .sittings![7]
                                  .value!);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFF6F2F2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.facebook,
                                size: 30,
                                color: homeColor,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextWidget3(
                                  alginText: TextAlign.start,
                                  isCustomColor: true,
                                  text: "Facebook",
                                  fontFamliy: "pnuL",
                                  fontSize: 18,
                                  color: textColor.withOpacity(.5))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          HelperFunction.slt.launchSocial(
                              AppCubit.get(context)
                                  .homeModel
                                  .sittings![9]
                                  .value!,
                              "");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFF6F2F2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.twitter,
                                size: 30,
                                color: homeColor,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextWidget3(
                                  alginText: TextAlign.start,
                                  isCustomColor: true,
                                  text: "Twitter",
                                  fontFamliy: "pnuL",
                                  fontSize: 18,
                                  color: textColor.withOpacity(.5))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFF6F2F2),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.snapchat,
                                size: 30,
                                color: homeColor,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextWidget3(
                                  alginText: TextAlign.start,
                                  isCustomColor: true,
                                  text: "Snapchat",
                                  fontFamliy: "pnuL",
                                  fontSize: 18,
                                  color: textColor.withOpacity(.5))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  _callUs(context)  => Container(
    height: 200,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(30), topLeft: Radius.circular(30)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 24,
            height: 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.5),
              color: const Color(0xFFDCDCDF),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      launch(
                          'tel:+${AppCubit.get(context).homeModel.sittings![0].value!}');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFF6F2F2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.call,
                            size: 30,
                            color: homeColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextWidget3(
                              alginText: TextAlign.start,
                              isCustomColor: true,
                              text: "اتصال",
                              fontFamliy: "pnuL",
                              fontSize: 18,
                              color: textColor.withOpacity(.5))
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      var whatsappURl_android = "whatsapp://send?phone=${AppCubit.get(context).homeModel.sittings![4].value!}&text=مرحبا بك";
                      var whatappURL_ios ="https://wa.me/0 112 128 8341?text=${Uri.parse("مرحبا بك")}";
                      if(Platform.isIOS){
                        // for iOS phone only
                        if( await canLaunch(whatappURL_ios)){
                          await launch(whatappURL_ios, forceSafariVC: false);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: new Text("whatsapp no installed")));

                        }

                      }else{
                        // android , web
                        if( await canLaunch(whatsappURl_android)){
                          await launch(whatsappURl_android);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: new Text("whatsapp no installed")));

                        }


                      }

                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFF6F2F2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.whatsapp,
                            size: 30,
                            color: homeColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextWidget3(
                              alginText: TextAlign.start,
                              isCustomColor: true,
                              text: "واتساب",
                              fontFamliy: "pnuL",
                              fontSize: 18,
                              color: textColor.withOpacity(.5))
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    ),
  );
}
