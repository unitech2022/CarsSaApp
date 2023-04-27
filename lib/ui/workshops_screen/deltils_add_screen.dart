import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/bloc/post_cubit/post_cubit.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/models/comment.dart';
import 'package:carsa/ui/workshops_screen/add_post_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import 'package:expandable/expandable.dart';
import '../../models/post.dart';
import '../../models/workshop_model.dart';
import '../../widgets/text_widget.dart';

class DetailsAddsScreen extends StatefulWidget {
  Post post;

  DetailsAddsScreen(this.post);

  @override
  State<DetailsAddsScreen> createState() => _DetailsAddsScreenState();
}

class _DetailsAddsScreenState extends State<DetailsAddsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostCubit.get(context).getComments(postId: widget.post.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: homeColor,
                ),
              ),
              title: RichText(
                text: TextSpan(
                  text: 'اعلان رقم ',
                  style: const TextStyle(
                      color: homeColor,
                      fontFamily: "pnuB",
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(text: widget.post.id.toString()),
                  ],
                ),
              )),
          floatingActionButton: currentUser.id == widget.post.userId
              ? const SizedBox()
              : FloatingActionButton.extended(
                  onPressed: () {
                    pushPage(
                        context: context, page: AddPostScreen());
                    // Add your onPressed code here!
                  },
                  label: const Text('اضافة عرض'),
                  icon: const Icon(Icons.local_offer_outlined),
                  backgroundColor: Colors.pink,
                ),
          body: SingleChildScrollView(
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 50),
          //     child: SizedBox(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           const Text(
          //             "وصف الاعلان",
          //             style: TextStyle(
          //                 fontSize: 16,
          //                 color: homeColor,
          //                 fontFamily: "pnuB",
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           const SizedBox(
          //             height: 10,
          //           ),
          //           TextWidget3(
          //               alginText: TextAlign.center,
          //               isCustomColor: true,
          //               text: widget.post.desc!,
          //               fontFamliy: "pnuB",
          //               fontSize: 18,
          //               lines: 4,
          //               color: Colors.black),
          //           const Spacing(),
          //           const Text(
          //             "رقم الهاتف",
          //             style: TextStyle(
          //                 fontSize: 16,
          //                 color: homeColor,
          //                 fontFamily: "pnuB",
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           const SizedBox(
          //             height: 10,
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               TextWidget3(
          //                   alginText: TextAlign.center,
          //                   isCustomColor: true,
          //                   text: widget.post.phone!,
          //                   fontFamliy: "pnuB",
          //                   fontSize: 18,
          //                   lines: 4,
          //                   color: Colors.black),
          //               currentUser.id == widget.post.userId
          //                   ? const SizedBox()
          //                   : IconButton(
          //                       onPressed: () {
          //                         launch(('tel://${widget.post.phone!}'));


          //                       },
          //                       icon: const Icon(
          //                         Icons.call,
          //                         color: Colors.green,
          //                       ))
          //             ],
          //           ),
          //           const Spacing(),
          //           const Text(
          //             "العروض",
          //             style: TextStyle(
          //                 fontSize: 16,
          //                 color: homeColor,
          //                 fontFamily: "pnuB",
          //                 fontWeight: FontWeight.bold),
          //           ),
          //           const SizedBox(
          //             height: 10,
          //           ),
          //           PostCubit.get(context).loadComments
          //               ? const SizedBox(
          //                   width: double.infinity,
          //                   child: Center(
          //                     child: CircularProgressIndicator(
          //                       color: homeColor,
          //                       strokeWidth: 3,
          //                     ),
          //                   ),
          //                 )
          //               : ListView.builder(
          //                   shrinkWrap: true,
          //                   physics: const NeverScrollableScrollPhysics(),
          //                   itemCount: PostCubit.get(context).comments.length,
          //                   itemBuilder: (_, i) {
          //                     Comment comment =
          //                         PostCubit.get(context).comments[i];

          //                     DateTime now =
          //                         DateTime.parse(comment.createdAt.toString());
          //                     String formattedDate =
          //                         DateFormat('yyyy-MM-dd – kk:mm').format(now);
          //                     return SizedBox(
          //                         child: Card(
          //                             elevation: 1,
          //                             color: Colors.white,
          //                             margin: const EdgeInsets.symmetric(
          //                                 horizontal: 5, vertical: 5),
          //                             shape: RoundedRectangleBorder(
          //                                 borderRadius:
          //                                     BorderRadius.circular(10)),
          //                             child: ExpandablePanel(
          //                               header: Padding(
          //                                 padding: const EdgeInsets.symmetric(
          //                                     horizontal: 5, vertical: 10),
          //                                 child: Row(
          //                                     mainAxisAlignment:
          //                                         MainAxisAlignment.start,
          //                                     crossAxisAlignment:
          //                                         CrossAxisAlignment.center,
          //                                     children: [
          //                                       ClipRRect(
          //                                           borderRadius: BorderRadius
          //                                               .circular(50),
          //                                           child: comment.imageUrl ==
          //                                                   null
          //                                               ? const Icon(
          //                                                   Icons.person,
          //                                                   size: 30,
          //                                                 )
          //                                               : CachedNetworkImage(
          //                                                   imageUrl:
          //                                                       baseurlImage +
          //                                                           comment
          //                                                               .imageUrl!,
          //                                                   height: 50,
          //                                                   width: 50,
          //                                                   fit: BoxFit.cover,
          //                                                   placeholder: (context,
          //                                                           url) =>
          //                                                       const CircularProgressIndicator(),
          //                                                   errorWidget: (context,
          //                                                           url,
          //                                                           error) =>
          //                                                       const Icon(Icons
          //                                                           .person))),
          //                                       const SizedBox(
          //                                         width: 10,
          //                                       ),
          //                                       Column(
          //                                         mainAxisAlignment:
          //                                             MainAxisAlignment.center,
          //                                         crossAxisAlignment:
          //                                             CrossAxisAlignment.start,
          //                                         children: [
          //                                           TextWidget(
          //                                               width: 200,
          //                                               text: comment.userName!,
          //                                               fontFamliy: "pnuB",
          //                                               fontSize: 15,
          //                                               color: secondColor),
          //                                           const SizedBox(
          //                                             height: 5,
          //                                           ),
          //                                           TextWidget(
          //                                               width: 120,
          //                                               text: formattedDate,
          //                                               fontFamliy: "pnuB",
          //                                               fontSize: 13,
          //                                               color: Colors.black
          //                                                   .withOpacity(.5)),
          //                                         ],
          //                                       ),
          //                                       const SizedBox(
          //                                         height: 5,
          //                                       ),
          //                                     ]),
          //                               ),
          //                               theme: const ExpandableThemeData(
          //                                   iconColor: homeColor),
          //                               collapsed: const SizedBox(),
          //                               expanded: Container(
          //                                 width: double.infinity,
          //                                 padding: const EdgeInsets.all(3.0),
          //                                 child: Column(
          //                                   crossAxisAlignment:
          //                                       CrossAxisAlignment.start,
          //                                   children: [
          //                                     TextWidget(
          //                                       text: comment.text!,
          //                                       fontFamliy: "pnuB",
          //                                       fontSize: 15,
          //                                       color: Colors.black
          //                                           .withOpacity(.7),
          //                                       width: double.infinity,
          //                                     ),
          //                                     const Spacing(),
          //                                     (currentUser.id ==
          //                                                 widget.post.userId ||
          //                                             currentUser.id !=
          //                                                 comment.userId)
          //                                         ? Row(
          //                                             mainAxisAlignment:
          //                                                 MainAxisAlignment.end,
          //                                             children: [
          //                                               IconButton(
          //                                                   onPressed: () {
          //                                                     launch('whatsapp://send?phone=${comment.phone}');
          //                                                   },
          //                                                   icon: const Icon(
          //                                                     Icons.whatsapp,
          //                                                     color:
          //                                                         Colors.green,
          //                                                   )),
          //                                               IconButton(
          //                                                   onPressed: () {
          //                                                     launch(('tel://${comment.phone}'));
          //                                                   },
          //                                                   icon: const Icon(
          //                                                     Icons.call,
          //                                                     color: Colors
          //                                                         .lightBlueAccent,
          //                                                   )),
          //                                             ],
          //                                           )
          //                                         : const SizedBox()
          //                                   ],
          //                                 ),
          //                               ),
          //                             )));
          //                   })
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ));
      },
    );
  }



  openWhatsapp(phoneNumber,BuildContext context) async {
    var whatsapp = "$phoneNumber";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=hello";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    }}
}

class Spacing extends StatelessWidget {
  const Spacing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
