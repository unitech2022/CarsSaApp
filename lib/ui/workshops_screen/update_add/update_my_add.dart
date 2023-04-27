import 'package:carsa/bloc/post_cubit/post_cubit.dart';
import 'package:carsa/helpers/functions.dart';
import 'package:carsa/helpers/helper_function.dart';
import 'package:carsa/helpers/styles.dart';
import 'package:carsa/models/post.dart';
import 'package:carsa/ui/my_adds_screen/my_adds_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/workshop_model.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../login_screen/login_screen.dart';

class UpdateMyAdd extends StatefulWidget {
  final Post post;

  UpdateMyAdd(this.post);

  @override
  State<UpdateMyAdd> createState() => _UpdateMyAddState();
}

class _UpdateMyAddState extends State<UpdateMyAdd> {
  final TextEditingController _controllerNameCar = TextEditingController();
  final TextEditingController _controllerModelCar = TextEditingController();
  final TextEditingController _controllerColorCar = TextEditingController();
  final TextEditingController _controllerDescProblem = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerNameCar.dispose();
    _controllerModelCar.dispose();
    _controllerColorCar.dispose();
    _controllerDescProblem.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controllerColorCar.text = widget.post.colorCar!;
    _controllerNameCar.text = widget.post.nameCar!;
    _controllerModelCar.text = widget.post.modelCar!;
    _controllerDescProblem.text = widget.post.desc!;

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is AddPostDataSuccess) {
          Future.delayed(Duration.zero, () {
            HelperFunction.slt.notifyUser(
                color: homeColor,
                context: context,
                message: "تم تعديل الاعلان ينجاج");
            pushPage(context: context, page: MyAddsScreen());
          });
        }

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
            centerTitle: true,
            title: const Text(
              "تعديل اعلان",
              style: TextStyle(
                  color: homeColor,
                  fontFamily: "pnuB",
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: isRegistered()
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        // Text(
                        //   "اكتب ما تحتاج له سيارتك ",
                        //   style: const TextStyle(
                        //       fontSize: 22,
                        //       color: homeColor,
                        //       fontFamily: "pnuB",
                        //       fontWeight: FontWeight.bold),
                        // ),
                        // const SizedBox(
                        //   height: 40,
                        // ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: Text(
                        //     widget.status == 1 ? "وصف الاعلان" : "وصف العرض",
                        //     style: const TextStyle(
                        //         fontSize: 16,
                        //         color: homeColor,
                        //         fontFamily: "pnuB",
                        //         fontWeight: FontWeight.bold),
                        //   ),
                        // ),

                        CustomTextField2(
                          controller: _controllerNameCar,
                          hint: "اسم السيارة",
                          inputType: TextInputType.text,
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField2(
                          controller: _controllerModelCar,
                          hint: "موديل السيارة",
                          inputType: TextInputType.text,
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField2(
                          controller: _controllerColorCar,
                          hint: "لون السيارة",
                          inputType: TextInputType.text,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color(0xffF6F6F6),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: _controllerDescProblem,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp("[٠-٩]"))
                            ],
                            onSaved: (newValue) => newValue!,
                            keyboardType: TextInputType.emailAddress,
                            maxLines: null,
                            onChanged: (value) {},
                            validator: (value) {
                              return (value != null && value.isEmpty)
                                  ? 'مطلوب *'
                                  : null;
                            },
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontFamily: "pnuM"),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              hintText: "وصف المشكلة",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        PostCubit.get(context).loadUpdate
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
                                  if (isValidate()!) {
                                    // if (widget.status == 1) {
                                    Post post = Post(
                                        id: widget.post.id,
                                        userId: widget.post.userId,
                                        phone: widget.post.phone,
                                        nameCar: _controllerNameCar.text,
                                        modelCar: _controllerModelCar.text,
                                        colorCar: _controllerColorCar.text,
                                        images: widget.post.images,
                                        desc: _controllerDescProblem.text);
                                    PostCubit.get(context)
                                        .updatePost(post)
                                        .then((value) {
                                      // PostCubit.get(context).getPosts(endPoint: getPostsPoint);
                                    pop(context);
                                    });
                                    // } else {
                                    //   PostCubit.get(context)
                                    //       .addComment(
                                    //           desc: _controllerDesc.text,
                                    //           postId: widget.post.id.toString(),
                                    //           phone: _controllerPhone.text.trim())
                                    //       .then((value) {
                                    //     PostCubit.get(context).getComments(postId: widget.post.id);
                                    //     pop(context);
                                    //   });
                                    // }
                                  }
                                },
                                text: "تعديل",
                                textColor: Colors.white,
                                fontSize: 14,
                              ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: CustomButton3(
                        text: "الانتقال الي صفحة التسجيل",
                        fontFamily: "PNUB",
                        onPress: () {
                          pushPage(page: LoginScreen(), context: context);
                        },
                        redius: 10,
                        color: homeColor,
                        textColor: Colors.white,
                        fontSize: 18,
                        height: 50),
                  ),
                ),
        );
      },
    );
  }

  bool? isValidate() {
    if (_controllerNameCar.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, message: "اكتب اسم السيارة", color: homeColor);
      return false;
    } else if (_controllerModelCar.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, message: "اكتب موديل السيارة", color: homeColor);
      return false;
    } else if (_controllerColorCar.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, message: "اكتب لون السيارة", color: homeColor);
      return false;
    } else if (_controllerDescProblem.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, message: "اكتب وصف المشكلة", color: homeColor);
      return false;
    } else {
      return true;
    }
  }
}
