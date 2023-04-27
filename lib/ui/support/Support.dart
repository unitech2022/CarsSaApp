import 'dart:convert';
import 'package:carsa/helpers/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';

import '../../models/SupportMessage.dart';
import '../../widgets/Texts.dart';
import '../../widgets/loading.dart';
import 'package:http/http.dart' as http;

class Support extends StatefulWidget {

  @override
  State<Support> createState() => _SupportState();
}


class _SupportState extends State<Support> {
  List<SupportMessage> messages=[];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController listScrollController = ScrollController();
  String textMessage = "";
  final TextEditingController _textEditingController= new TextEditingController();



  animateToBottom() {
    if (listScrollController.hasClients) {
      final position = listScrollController.position.maxScrollExtent;
      listScrollController.animateTo(
        position,
        duration: Duration(milliseconds: 700),
        curve: Curves.easeOut,
      );
    }
  }



  getMessages() async {
    bool isOnline = await HelperFunction.slt.checkInternet(context);
    if(!isOnline){
      return;
    }
    if(!isRegistered())return;
    showLoadingDialog(context);
    final url = baseUrl+"/support/get-user-messages";
    final response = await http.post(Uri.parse(url),body: {"userId":currentUser.id});
    pop(context);
    print(response.body);
    if (response.statusCode == 200) {

      var data= jsonDecode(response.body);
      data.forEach((e){
        messages.add(SupportMessage.fromJson(e));
      });
      setState(() {

      });

    } else {
      // pop(context);
      print(response.statusCode.toString()+"errrrrrrrrrrr");
    }
  }

  addMessage(SupportMessage message) async {
    bool isOnline = await HelperFunction.slt.checkInternet(context);
    if(!isOnline){
      return;
    }
    if(!isRegistered())return;
    final url = baseUrl+"/support/add-message";
    final response = await http.post(Uri.parse(url),body: message.toJson());
    print(response.body);
    if (response.statusCode == 200) {

    } else {
      // pop(context);
    }
  }

  initFirebase() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      getMessages();
    });
  }

 

  @override
  void initState() {
    super.initState();
    initFirebase();
    getMessages();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(

        backgroundColor: homeColor,
        title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Texts(fSize: 18,title: "الدعم الفني",weight: FontWeight.bold,color: Colors.white),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width:5,color:      Color(0xFFF2F4F3),
                )
            ),
            child: Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 0.2,color: homeColor)
                ),

                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/logo.png',height: 40,width: 40,fit: BoxFit.cover,))
            ),
          ),
        ],
      ),),
      body:Container(
        color: Colors.black12.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: Column(

            children: [
              // widget Content Chat
              Expanded(
                child: ListView.builder(
                    itemCount:
                    messages
                        .length,

                    shrinkWrap: true,
                    itemBuilder: (_, index) {

                      return messages[index].sender=="user"? Wrap(
                        children: [
                          Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                margin: EdgeInsets.only(right: 0,left: 120,top: 30),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: homeColor.withOpacity(0.5)
                                ),
                                child: Texts(
                                  fSize: 15,
                                  lines: 3,
                                  title: messages[index].message,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisSize: MainAxisSize.min,

                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  currentUser.imageUrl == null
                                      ? Icon(
                                    Icons.account_circle,
                                    size: 30,
                                    color: Colors.green,
                                  )
                                      : ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(70),
                                          child: LoadPhoto2(
                                              "https://app.matbakh24.com/uploads/"+  currentUser.imageUrl!, 30)),
                                  SizedBox(width: 10,),

                                  Texts(
                                    fSize: 9,
                                    lines: 3,
                                    color: Colors.black54,
                                    title: HelperFunction.slt.formateData(messages[index].date),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ):Wrap(
                        children: [
                          Container(
                            width:MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.end,

                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  margin: EdgeInsets.only(right: 0,top: 30),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white
                                  ),
                                  child: Texts(
                                    fSize: 15,
                                    lines: 3,
                                    title: messages[index].message,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisSize: MainAxisSize.min,

                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.supervised_user_circle_outlined,
                                      size: 30,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 10,),

                                    Texts(
                                      fSize: 9,
                                      lines: 3,
                                      color: Colors.black54,
                                      title: HelperFunction.slt.formateData(messages[index].date),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }),
              ),


              //build widget send Message
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xff707070).withOpacity(.3),
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    // build button attachment
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: _textEditingController,
                        onChanged: (v) {
                          textMessage = v.toString();
                        },
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          fontFamily: 'pnuR',
                          fontSize: 15,
                          color: Color(0xff707070),
                          fontWeight: FontWeight.w700,
                        ),
                        decoration:  InputDecoration(
                          focusedErrorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          hintText: "نص الرسالة".tr(),
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 8,horizontal: 20),
                          floatingLabelBehavior:
                          FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // build button send
                    IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          _textEditingController.text = "";

                          SupportMessage message = new SupportMessage( message: textMessage, userId: currentUser.id!, sender: "user",date: DateTime.now().toString());
                          addMessage(message);
                          messages.add(message);
                          setState(() {

                          });
                          animateToBottom();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: homeColor,
                        )),
                    const SizedBox(
                      width: 10,
                    ),

                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }




}
