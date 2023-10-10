import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'functions.dart';

class HelperFunction {
  static HelperFunction slt = HelperFunction();

  formateData(String date) {
    DateTime now = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy-MM-dd  kk:mm').format(now);
    return formattedDate;
  }

  notifyUser({context, message, color, bool isNeedPop = false}) {
    return Flushbar(
      padding: const EdgeInsets.all(30),
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: color,
      animationDuration: const Duration(milliseconds: 400),
      leftBarIndicatorColor: color,
    )..show(context).whenComplete(() {
        if (isNeedPop) pop(context);
      });
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }

  checkInternet(context) async {
    bool isOnline = await hasNetwork();
    if (!isOnline) {
      notifyUser(
        context: context,
        message: "no_internet",
        color: Colors.red,
      );
    }
    return isOnline;
  }

  showSheet(BuildContext context, child) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return child;
      },
    );
  }

  openGoogleMapLocation(lat, lng) async {
    String mapOptions = [
      'saddr=${locData.latitude},${locData.longitude}',
      'daddr=$lat,$lng',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

openNewGoogleMapLocation({lat, lng}) async {
  // try{
  // String mapOptions = [
  //   'saddr=${locData.latitude},${locData.longitude}',
  //   'daddr=$lat,$lng',
  //   'dir_action=navigate'
  // ].join('&');

  //   String url = 'https://www.google.com/maps?$mapOptions';
  // // if (await canLaunchUrl(Uri.parse(url),)) {
  //   await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
  // // } else {
  // //   throw 'Could not launch $url';
  // // }
  // }catch(e){
  //    throw 'Could not launch ${e}';
  // }

  String appleUrl =
      'https://maps.apple.com/?saddr=${locData.latitude},${locData.longitude}&daddr=$lat,$lng&directionsmode=driving';
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng';

  Uri appleUri = Uri.parse(appleUrl);
  Uri googleUri = Uri.parse(googleUrl);

  if (Platform.isIOS) {
    if (await canLaunchUrl(appleUri)) {
      await launchUrl(appleUri, mode: LaunchMode.externalApplication);
    } else {
      if (await canLaunchUrl(googleUri)) {
        await launchUrl(googleUri, mode: LaunchMode.externalApplication);
      }
    }
  } else {
    if (await canLaunchUrl(googleUri)) {
      await launchUrl(googleUri, mode: LaunchMode.externalApplication);
    }
  }
}


  openUrlFaceBook({fbPageId, pageUrl}) async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = 'fb://profile/$fbPageId';
    } else {
      fbProtocolUrl = 'fb://page/$fbPageId';
    }

    String fallbackUrl = '$pageUrl';

    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  void launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
          await launch("$url", forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  launchWhatsapp({number, context}) async {
    var whatsapp = number;
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
       print("Can't open dial pad.");
    }
}

  rateApp({appPackageName}) {
    try {
      launch("market://details?id=" + appPackageName);
    } on PlatformException {
      launch("https://play.google.com/store/apps/details?id=" + appPackageName);
    } finally {
      launch("https://play.google.com/store/apps/details?id=" + appPackageName);
    }
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}