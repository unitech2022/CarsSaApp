
import 'package:flutter/material.dart';

import '../../helpers/functions.dart';
import '../../helpers/styles.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final String value, title;
  final int status;

  PrivacyPolicyScreen(
      {required this.value, required this.title, this.status = 0});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
 
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
          widget.status == 1 ? " الشروط والأحكام و سياسة الخصوصية" : widget.title,
          style: TextStyle(color: homeColor, fontFamily: "pnuR", fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child:  Text(
           widget.value, style: TextStyle(color: homeColor,fontSize: 18),
              ),
        ),
      ),
    );
  }
}
