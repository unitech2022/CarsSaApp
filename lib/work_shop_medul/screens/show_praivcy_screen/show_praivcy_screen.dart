import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../helpers/functions.dart';
import '../../../helpers/styles.dart';

class ShowPrivacyScreen extends StatefulWidget {
  final String value, title;
 

  ShowPrivacyScreen(
      {required this.value, required this.title});

  @override
  State<ShowPrivacyScreen> createState() => _ShowPrivacyScreenState();
}

class _ShowPrivacyScreenState extends State<ShowPrivacyScreen> {
 
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
          widget.title,
          style: TextStyle(color: homeColor, fontFamily: "pnuR", fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child:  Text(
                widget.value,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "pnuB", fontSize: 16, color: homeColor),
                ),
        ),
      ),
    );
  }
}
