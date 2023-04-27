
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/work_shop_medul/screens/show_praivcy_screen/show_praivcy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../bloc/auth_cubit/auth_cubit.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/styles.dart';
import '../../../ui/privacy_policy/privacy_policy_screen.dart';
import 'container_sitings.dart';

class SittingsScreen extends StatelessWidget {
  const SittingsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "الإعدادات",
          style: TextStyle(
              color: homeColor,
              fontFamily: "pnuB",
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Column(children: [
        const SizedBox(
          height: 30,
        ),
        ContainerProfileText(
          text: "سياسة الضمان",
          icon: Icons.info_outline,
          onPress: () {
            pushPage(
                context: context,
                page:  
                ShowPrivacyScreen(
                    value: warrantyData,
                    title: warrantyTitle));
          },
        ),
        ContainerProfileText(
          text: "الشروط والاحكام الخاصة بورش السيارات",
          icon: Icons.approval,
          onPress: () {
            pushPage(
                context: context,
                page: ShowPrivacyScreen(
                    value: termsAndConditionsData,
                    title: termsAndConditionsTitle));
          },
        ),
        // ContainerProfileText(
        //     text: "سياسة الاستبدال والاسترجاع",
        //     icon: Icons.all_inclusive,
        //     onPress: () {
        //       pushPage(
        //           context: context,
        //           page: PrivacyPolicyScreen(
        //               value: AuthCubit.get(context).sittings[10].value!,
        //               title: AuthCubit.get(context).sittings[10].name!));
        //     }),
      
      
        ContainerProfileText(
          text: "تسجيل الخروج",
          icon: Icons.logout,
          onPress: () {
            signOut(ctx: context);
          },
        )
      ]),
    );
  }
}
