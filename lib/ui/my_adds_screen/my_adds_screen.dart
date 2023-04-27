import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/helpers/constants.dart';
import 'package:carsa/ui/my_adds_screen/update_my_add_screen.dart';
import 'package:carsa/ui/workshops_screen/offers_screen/offers_screen.dart';
import 'package:carsa/ui/workshops_screen/update_add/update_my_add.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/post_cubit/post_cubit.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../../models/post.dart';
import '../../models/workshop_model.dart';
import '../../widgets/Texts.dart';
import '../../widgets/text_widget.dart';
import '../workshops_screen/deltils_add_screen.dart';

class MyAddsScreen extends StatefulWidget {
  const MyAddsScreen({Key? key}) : super(key: key);

  @override
  State<MyAddsScreen> createState() => _MyAddsScreenState();
}

class _MyAddsScreenState extends State<MyAddsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostCubit.get(context).getMyPosts(endPoint: "/post/get-my-Posts");
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
              title: const Text(
                "خدمات الورش",
                style: TextStyle(
                    color: homeColor,
                    fontFamily: "pnuB",
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: PostCubit.get(context).load
                ? const Center(
                    child: CircularProgressIndicator(
                      color: homeColor,
                      strokeWidth: 3,
                    ),
                  )
                :PostCubit.get(context).myPosts.isEmpty?
            Center(
              child: TextWidget3(
                color: homeColor,
                fontSize: 26,
                text: "لاتوجد خدمات لديك",
                fontFamliy: "pnuR",
                isCustomColor: true,
                alginText: TextAlign.center,
                lines: 1,
              ),
            ):
            ListView.builder(
                padding: EdgeInsets.only(top: 30),
                    itemCount: PostCubit.get(context).myPosts.length,
                    itemBuilder: (ctx, index) {
                      Post post = PostCubit.get(context).myPosts[index];
                      DateTime now =
                          DateTime.parse(post.createdAt.toString());
                      String formattedDate =
                          DateFormat('yyyy-MM-dd – kk:mm').format(now);
                      return InkWell(
                          onTap: () {
                            pushPage(
                                context: context,
                                page: OffersScreen(post.id!));
                          },
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                             padding: const EdgeInsets.all(10),
                            margin: paddingOnly(
                                top: 0, bottom: 10, left: 0, right: 0),
                            child: Column(
                             
                              children: [
                                Row(
                                 
                                  children: [
                                    CachedNetworkImage(imageUrl: post.images=="not"?
                                    baseurlImage+"a.jpeg":baseurlImage+post.images!,
                                    width: 100,height: 100,
                                    errorWidget: (context, url, error) => 
                                      Icon(Icons.photo,size: 50,color: Color.fromARGB(180, 158, 158, 158),
                                    ),),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextWidget3(
                                                  alginText: TextAlign.center,
                                                  isCustomColor: true,
                                                  text: post.nameCar!,
                                                  fontFamliy: "pnuB",
                                                  fontSize: 15,
                                                  lines: 4,
                                                  color: Colors.black.withOpacity(.6)),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(50),
                                                      color: post.acceptedOfferId==0?Color.fromARGB(255, 236, 124, 6):
                                                      Colors.green
                                                    ),
                                                    child:  TextWidget3(
                                                alginText: TextAlign.right,
                                                isCustomColor: true,
                                                text: post.acceptedOfferId==0?"تلقي العروض" : "تم القبول",
                                                fontFamliy: "pnuB",
                                                fontSize: 11,
                                                lines: 1,
                                                color: Colors.white),
                                             ),
                                                  
                                            ],
                                          ),
                                           TextWidget3(
                                              alginText: TextAlign.center,
                                              isCustomColor: true,
                                              text: "${post.nameCar!} - ${post.colorCar} -  ${post.modelCar!}",
                                              fontFamliy: "pnuB",
                                              fontSize: 15,
                                              lines: 4,
                                              color: Colors.grey.withOpacity(.6)),
                                             SizedBox(
                                              width: 240,
                                               child: TextWidget3(
                                                alginText: TextAlign.right,
                                                isCustomColor: true,
                                                text: post.desc!,
                                                fontFamliy: "pnuB",
                                                fontSize: 15,
                                                lines: 3,
                                                color: Colors.grey.withOpacity(.6)),
                                             ),
                                       
                                        
                                        
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                               SizedBox(height: 10,),
                            post.acceptedOfferId==0?    SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Center(
                                        child: TextButton(
                                          onPressed: () {
                                          pushPage(page: UpdateMyAdd(post),context: context);
                                          },
                                          child: Text('تعديل',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "pnuB",
                                                  color: Colors.green)),
                                        ),
                                      )),
                                      Container(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                          child: Center(
                                        child: TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  // return object of type Dialog
                                                  return BlocConsumer<
                                                      PostCubit,
                                                      PostState>(
                                                    listener: (context, state) {
                                                      // TODO: implement listener
                                                    },
                                                    builder: (context, state) {
                                                      return Container(
                                                        // height: 200,
                                                        child: AlertDialog(
                                                          title: Texts(
                                                              fSize: 18,
                                                              color: Colors.red,
                                                              title: "هل أنت متأكد من أنك تريد حذف هذا الاعلان",
                                                              weight: FontWeight
                                                                  .bold),
                                                          content: Texts(
                                                              fSize: 18,
                                                              color:
                                                                  Colors.black,
                                                              title:
                                                                  post
                                                                  .nameCar!,
                                                              weight: FontWeight
                                                                  .bold),
                                                          actions: <Widget>[
                                                            // usually buttons at the bottom of the dialog
                                                            SizedBox(
                                                              height: 40,
                                                              child: PostCubit.get(
                                                                          context)
                                                                      .loadDelete
                                                                  ? const Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        color:
                                                                            homeColor,
                                                                        strokeWidth:
                                                                            3,
                                                                      ),
                                                                    )
                                                                  : TextButton(
                                                                      child: Text(
                                                                          "حذف",
                                                                          style: const TextStyle(
                                                                              color:
                                                                                  Colors.red)),
                                                                      onPressed:
                                                                          () {
                                                                        PostCubit.get(
                                                                                context)
                                                                            .deletePost(post
                                                                                
                                                                                .id!)
                                                                            .then(
                                                                                (value) {
                                                                          pop(context);
                                                                        });
                                                                      },
                                                                    ),
                                                            ),
                                                            SizedBox(
                                                              height: 40,
                                                              child: TextButton(
                                                                child:
                                                                    Text("الغاء"),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context, 0);
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                });
                                          },
                                          child: Text('حذف',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "pnuB",
                                                  color: Colors.red)),
                                        ),
                                      )),
                                    ],
                                  ),
                                )
                             :SizedBox() ],
                            ),
                          ));
                    }));
      },
    );
  }
}
