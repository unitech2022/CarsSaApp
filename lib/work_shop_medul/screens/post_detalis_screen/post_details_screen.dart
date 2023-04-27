import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/post_cubit/post_cubit.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/styles.dart';
import '../../../widgets/Texts.dart';
import '../../../widgets/custom_button.dart';
import '../add_offer_screen/add_offer_screen.dart';



class PostDetailsScreen extends StatefulWidget {
  final int postId, workShopId;
  const PostDetailsScreen(
      { required this.postId, required this.workShopId});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  void initState() {
    super.initState();
    PostCubit.get(context).getPostDetails(id: widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text(
              "اعلان رقم ${widget.postId}",
              style: const TextStyle(
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
                color: homeColor,
              ),
            ),
          ),
          body: PostCubit.get(context).getPostLoad
              ? const Center(
                  child: CircularProgressIndicator(
                    color: homeColor,
                    strokeWidth: 3,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Texts(
                          fSize: 16,
                          weight: FontWeight.bold,
                          color: Colors.black,
                          title: "صاحب الاعلان",
                          lines: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Colors.grey, width: 1.5)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    imageUrl: PostCubit.get(context)
                                                .postResponse!
                                                .user!
                                                .imageUrl !=
                                            null
                                        ? baseurlImage +
                                            PostCubit.get(context)
                                                .postResponse!
                                                .user!
                                                .imageUrl!
                                        : "not",
                                    width: 50,
                                    height: 50,
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Texts(
                                      fSize: 16,
                                      weight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.6),
                                      title: PostCubit.get(context)
                                          .postResponse!
                                          .user!
                                          .fullName,
                                      lines: 1,
                                    ),
                                    PostCubit.get(context)
                                                .postResponse!
                                                .post!
                                                .acceptedOfferId !=
                                            0
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Texts(
                                                fSize: 14,
                                                weight: FontWeight.normal,
                                                color: Colors.grey,
                                                title: PostCubit.get(context)
                                                    .postResponse!
                                                    .user!
                                                    .userName,
                                                lines: 1,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    luncherUrl(Uri.parse(
                                                        'tel://${PostCubit.get(context).postResponse!.user!.userName}'));
                                                  },
                                                  icon: const Icon(
                                                    Icons.call,
                                                    color: Colors.blueAccent,
                                                  ))
                                            ],
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        Texts(
                          fSize: 16,
                          weight: FontWeight.bold,
                          color: homeColor,
                          title: "تفاصيل الاعلان",
                          lines: 1,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        DetailsCar(
                          title: "اسم السيارة ",
                          value: PostCubit.get(context)
                              .postResponse!
                              .post!
                              .nameCar!,
                        ),
                        const Divider(),
                        DetailsCar(
                          title: " لون السيارة ",
                          value: PostCubit.get(context)
                              .postResponse!
                              .post!
                              .colorCar!,
                        ),
                        const Divider(),
                        DetailsCar(
                          title: "موديل السيارة ",
                          value: PostCubit.get(context)
                              .postResponse!
                              .post!
                              .modelCar!,
                        ),
                        const Divider(),
                        DetailsCar(
                          title: "تفاصيل المشكلة ",
                          value:
                              PostCubit.get(context).postResponse!.post!.desc!,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        PostCubit.get(context)
                                        .postResponse!
                                        .post!
                                        .acceptedOfferId ==
                                    0 &&
                                !PostCubit.get(context).postResponse!.isOffer!
                            ? PostCubit.get(context).addOfferLoad
                                ? const SizedBox(
                                    height: 50,
                                    width: 46,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: homeColor,
                                        strokeWidth: 3,
                                      ),
                                    ),
                                  )
                                : CustomButton(
                                    height: 50,
                                    fontFamily: "pnuM",
                                    color: homeColor,
                                    redius: 10.0,
                                    isCustomColor: true,
                                    onPress: () async {
                                      pushPage(
                                          context: context,
                                          page: AddOfferScreen(
                                            workshopId: widget.workShopId,
                                            postId: PostCubit.get(context)
                                                .postResponse!
                                                .post!
                                                .id!,
                                          ));
                                    },
                                    text: "اضافة عرض",
                                    textColor: Colors.white,
                                    fontSize: 14,
                                  )
                            : Texts(
                                fSize: 16,
                                weight: FontWeight.bold,
                                color: Colors.red,
                                title: "تم تقديم عرض علي هذا الاعلان ",
                                lines: 10,
                                align: TextAlign.center,
                              ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class DetailsCar extends StatelessWidget {
  final String title, value;
  DetailsCar({ required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Texts(
            fSize: 16,
            weight: FontWeight.bold,
            color: Colors.black,
            title: title,
            lines: 1,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Texts(
              fSize: 16,
              weight: FontWeight.bold,
              color: Colors.grey,
              title: value,
              lines: 10,
              align: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
