import 'package:carsa/bloc/app_cubit/app_cubit.dart';
import 'package:carsa/helpers/functions.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/ui/cart_screen/cart_screen.dart';
import 'package:carsa/ui/workshops_screen/workshops_screen.dart';
import 'package:carsa/widgets/Texts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../bloc/cart_cubite/cart_cubit.dart';
import '../../helpers/helper_function.dart';
import '../../widgets/text_widget.dart';
import '../home_screen/home_screen.dart';
import '../my_profile_screen/my_profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    CartScreen(),
    WorksShopsScreen(),
    const MyProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getHomeData();
    // AppCubit.get(context).getUserDetails();

    // if(isRegistered())
    // AppCubit.get(context).getFavorites();

    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: AppCubit.get(context).currentIndex != 0
              ? SizedBox()
              : GestureDetector(
                  onTap: () {
                    HelperFunction.slt.showSheet(context, _selectCall(context));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: .5),
                        color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      Icons.call,
                      size: 30,
                      color: Colors.green,
                    ),
                  ),
                ),
          body: RefreshIndicator(
            onRefresh: () async {
              AppCubit.get(context).getHomeData();
            },
            child: IndexedStack(
              index: AppCubit.get(context).currentIndex,
              children: _screens,
            ),
          ),
          bottomNavigationBar: BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                iconSize: 23,
                unselectedIconTheme: const IconThemeData(
                  color: Colors.black45,
                ),
                showSelectedLabels: true,
                showUnselectedLabels: true,
                unselectedItemColor: textColor,
                unselectedLabelStyle: const TextStyle(fontFamily: "pnuM"),
                selectedLabelStyle: const TextStyle(fontFamily: "pnuB"),
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'الرئيسية'),
                  BottomNavigationBarItem(
                      icon: badges.Badge(
                          position: badges.BadgePosition.topStart(
                            start: -1,
                          ),
                          badgeContent: CartCubit.get(context).carts.isEmpty
                              ? null
                              : Text(
                                  '${CartCubit.get(context).carts.length}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                          child: Icon(Icons.shopping_cart)),
                      label: 'السلة'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.work_outline), label: 'الورش'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'حسابي'),
                ],
                currentIndex: AppCubit.get(context).currentIndex,
                fixedColor: homeColor,
                onTap: onItemTapped,
              );
            },
          ),
        );
      },
    );
  }

  void onItemTapped(int index) {
    AppCubit.get(context).changeNav(index);
  }

  void _showMaterialBanner(String title) {
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      padding: EdgeInsets.all(20),
      content: Text(
        title,
        style: TextStyle(
          fontFamily: "pnuB",
          fontSize: 14,
          color: Colors.red,
        ),
      ),
      leading: Icon(Icons.notifications_active_outlined, color: Colors.red),
      backgroundColor: backgroundColor,
      actions: <Widget>[
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).clearMaterialBanners();
          },
          icon: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
      ],
    ));
  }

  void getFCMToken() async {
    await FirebaseMessaging.instance.subscribeToTopic('user');

    FirebaseMessaging.instance.getToken().then((token) {
      print(token.toString() + "tokrrrrrrn");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // NotifyAowsome(notification!.title!,notification.body!);
      if (notification != null && android != null && !kIsWeb) {
        _showMaterialBanner(notification.title!);
        // AwesomeNotifications().createNotification(
        //
        //     content: NotificationContent(
              // id: createUniqueId(),
        //
        //       color: homeColor,
        //       icon: 'resource://drawable/ic_launcher',
        //
        //       channelKey: 'key1',
        //       title:
        //       '${Emojis.money_money_bag + Emojis.plant_cactus}${notification.title}',
        //       body: notification.body,
        //       bigPicture: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        //       notificationLayout: NotificationLayout.BigPicture,
        //       // largeIcon: "asset://assets/images/logo_final.png"
        //     ));

        // AwesomeNotifications().initialize(
        //     "asset://assets/images/logo_final",
        //     [
        //       NotificationChannel(
        //           channelKey: 'key1',
        //           channelName: 'chat',
        //           channelDescription: "Notification example",
        //           defaultColor: Colors.blue,
        //           ledColor: Colors.blue,
        //           channelShowBadge: true,
        //           playSound: true,
        //           enableLights:true,
        //           enableVibration: false
        //       )
        //     ]
        // );

/*        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            "تم اضافة اعلان في الاعلانات المعلقة",
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                // channel!.description,

                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: '@mipmap/ic_launcher',
              ),
            ));*/

        print("aaaaaaaaaaaawww${message.data["desc"]}");
      }
    });
  }

  _selectCall(BuildContext context) {
    return Container(
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
              height: 10,
            ),
              Texts(fSize: 16,title: "التواصل مع الدعم الفنى",color: Colors.black,weight: FontWeight.bold,),
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
                        pop(context);
                        HelperFunction.slt.launchWhatsapp(
                            number: AppCubit.get(context)
                                .homeModel
                                .sittings![14]
                                .value!,
                            context: context);
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
                            const FaIcon(
                              FontAwesomeIcons.whatsapp,
                              size: 30,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextWidget3(
                                alginText: TextAlign.start,
                                isCustomColor: true,
                                text: "WhatsApp",
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
                          pop(context);
                        HelperFunction.slt.openDialPad(AppCubit.get(context)
                            .homeModel
                            .sittings![14]
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
                            Icon(
                              Icons.call,
                              size: 30,
                              color: Colors.blue,
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
