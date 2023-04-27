import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/ui/navigation/navigation_screen.dart';
import 'package:carsa/ui/workshops_screen/offers_screen/offer_details/offer_details.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/post_cubit/post_cubit.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/styles.dart';
import '../../../models/comment.dart';
import '../../../widgets/Texts.dart';

class OffersScreen extends StatefulWidget {
  final int postId;

  OffersScreen(this.postId);
  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.postId.toString());
    PostCubit.get(context).getComments(postId: widget.postId.toString());
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
              actions: [
                IconButton(
                    onPressed: () {
                      pushPage(context: context, page: NavigationScreen());
                    },
                    icon: Icon(
                      Icons.home,
                      color: homeColor,
                    ))
              ],
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
                  text: "العــروض",
                  style: const TextStyle(
                      color: homeColor,
                      fontFamily: "pnuB",
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                   
                  ],
                ),
              )),
          body: PostCubit.get(context).loadComments
              ? const SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: homeColor,
                      strokeWidth: 3,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: PostCubit.get(context).comments.length,
                  itemBuilder: (_, i) {
                    ResponseComment responseComment =
                        PostCubit.get(context).comments[i];

                    DateTime now = DateTime.parse(
                        responseComment.comment!.createdAt.toString());
                    String formattedDate =
                        DateFormat('yyyy-MM-dd – kk:mm').format(now);
                    return GestureDetector(
                      onTap: () {
                        pushPage(
                            context: context,
                            page: OfferDetailsScreen(
                                responseComment.comment!.id!));
                      },
                      child: SizedBox(
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.5)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                      imageUrl: baseurlImage +
                                          responseComment.imageUrlWorkShop!,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Texts(
                                          fSize: 16,
                                          weight: FontWeight.bold,
                                          color: Colors.black,
                                          title: responseComment.nameWorkShop,
                                          lines: 1,
                                        ),
                                        Texts(
                                          fSize: 12,
                                          weight: FontWeight.bold,
                                          color: Colors.grey,
                                          title: formattedDate,
                                          lines: 1,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                        width: 240,
                                        child: Texts(
                                          fSize: 16,
                                          weight: FontWeight.normal,
                                          color: Colors.grey,
                                          title:
                                              "قدمت هذه الورشة عرضا علي طلبك ",
                                          lines: 2,
                                        ))
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        );
      },
    );
  }
}
