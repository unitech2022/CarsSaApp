import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../helpers/constants.dart';
import '../../../helpers/data.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/styles.dart';

class PrivacyHtmlScreen extends StatelessWidget {
  const PrivacyHtmlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
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
          "الشروط والأحكام" ,
          style: TextStyle(color: homeColor, fontFamily: "pnuR", fontSize: 16),
        ),
      ),
      body:SingleChildScrollView(
        child: Html(
        data: htmlData,
      ),
      ),
    
    );
  }
}