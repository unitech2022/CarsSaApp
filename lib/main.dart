
import 'dart:io';

import 'package:carsa/bloc/address_cubit/address_cubit.dart';
import 'package:carsa/bloc/cart_cubite/cart_cubit.dart';
import 'package:carsa/bloc/order_cubit/order_cubit.dart';
import 'package:carsa/bloc/post_cubit/post_cubit.dart';
import 'package:carsa/bloc/product_bloc/product_cubit.dart';
import 'package:carsa/bloc/suggestion_cubit/suggestion_cubit.dart';
import 'package:carsa/bloc/workshops_cubit/workshop_cubit.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/ui/add_car_screen/add_car_screen.dart';
import 'package:carsa/ui/edite_my_profile_screen/edite_my_profile_screen.dart';
import 'package:carsa/ui/home_screen/home_screen.dart';
import 'package:carsa/ui/login_screen/login_screen.dart';
import 'package:carsa/ui/my-address_screen/my-address_screen.dart';
import 'package:carsa/ui/my-orders-screen/my-orders-screen.dart';
import 'package:carsa/ui/my_cars_screen/my_cars_screen.dart';
import 'package:carsa/ui/my_favorite_screen/my_favorite_screen.dart';
import 'package:carsa/ui/navigation/navigation_screen.dart';
import 'package:carsa/ui/ordering_product/ordering_product.dart';
import 'package:carsa/ui/splash_screen/splash_screen.dart';
import 'package:carsa/ui/welcome_page/welcome_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'bloc/app_cubit/app_cubit.dart';
import 'bloc/auth_cubit/auth_cubit.dart';
import 'helpers/functions.dart';
import 'helpers/helper_function.dart';
import 'helpers/router.dart';

// todo: add rate to product

Future<void> _messageHandler(RemoteMessage message) async {
  // RemoteNotification? notification = message.notification;
  // AndroidNotification? android = message.notification?.android;
  // NotifyAowsome(notification!.title!,notification.body!);
  // if (notification != null && android != null && !kIsWeb) {
  //   AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //     id: createUniqueId(),
  //
  //     color: homeColor,
  //     icon: 'resource://drawable/ic_launcher',
  //
  //     channelKey: 'key1',
  //     title:
  //         '${Emojis.money_money_bag + Emojis.plant_cactus}${notification.title}',
  //     body: notification.body,
  //     bigPicture:
  //         "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
  //     notificationLayout: NotificationLayout.BigPicture,
  //     // largeIcon: "asset://assets/images/logo_final.png"
  //   ));
  //
  //   print('background message ${message.notification!.body}');
  // }
}
AndroidNotificationChannel? channel =
AndroidNotificationChannel("key1", "chat");

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
 await readToken();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp;

 
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale("en")],
        path: "assets/translations",
        // <-- change the path of the translation files
        fallbackLocale: const Locale("ar"),
        startLocale: const Locale("ar"),
        child: Phoenix(child: const MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (BuildContext context) => AppCubit()),
        BlocProvider<CartCubit>(create: (BuildContext context) => CartCubit()),
        BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()),
        BlocProvider<AddressCubit>(create: (BuildContext context) => AddressCubit()),
        BlocProvider<OrderCubit>(create: (BuildContext context) => OrderCubit()),
        BlocProvider<ProductCubit>(create: (BuildContext context) => ProductCubit()),
        BlocProvider<WorkshopCubit>(create: (BuildContext context) => WorkshopCubit()),
        BlocProvider<PostCubit>(create: (BuildContext context) => PostCubit()),
        BlocProvider<SuggestionCubit>(create: (BuildContext context) => SuggestionCubit())

      ],
      child: MaterialApp(
        title: 'Car Sa',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            primarySwatch: Colors.blue,
            appBarTheme:
                const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle())),
        initialRoute:
         "/",
        routes: {
          "/": (context) => const SplashScreen(),
          login: (context) => const LoginScreen(),
          // "signUp": (context) => SignUpScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          nav: (context) => const NavigationScreen(),
         

          cars: (context) => MyCarsScreen(),
          addCar: (context) => AddCarScreen(),
          edit: (context) => EditMyProfileScreen(),
          // details: (context) => DetailsProductScreen(),
          orderProduct: (context) => OrderingProduct(),

          myAddress: (context) =>  const MyAddressScreen(),
          myOrders: (context) =>  const MyOrdersScreen(),
          fav: (context) =>   MyFavoriteScreen(),
           welcome: (context) =>   WelcomePage(),

        },
      ),
    );
  }
}
