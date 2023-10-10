import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/post_cubit/post_cubit.dart';
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../helpers/styles.dart';

import '../../models/workshop_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class UpdateMyAddScreen extends StatefulWidget {
  final Post post;

  UpdateMyAddScreen(this.post);

  @override
  State<UpdateMyAddScreen> createState() => _UpdateMyAddScreenState();
}

class _UpdateMyAddScreenState extends State<UpdateMyAddScreen> {
  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerPhone.text = widget.post.phone!;
    _controllerDesc.text = widget.post.desc!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is UpdatePostDataSuccess) {
          Future.delayed(Duration.zero, () {
            HelperFunction.slt.notifyUser(
                color: homeColor,
                context: context,
                message: "تم تعديل الاعلان ينجاج");
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
              "اضافة اعلان",
              style: TextStyle(
                  color: homeColor,
                  fontFamily: "pnuB",
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "تعديل الاعلان",
                    style: const TextStyle(
                        fontSize: 22,
                        color: homeColor,
                        fontFamily: "pnuB",
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "وصف الاعلان",
                      style: const TextStyle(
                          fontSize: 16,
                          color: homeColor,
                          fontFamily: "pnuB",
                          fontWeight: FontWeight.bold),
                    ),
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
                      controller: _controllerDesc,
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
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        hintText: "وصف الاعلان",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "رقم الهاتف",
                      style: TextStyle(
                          fontSize: 16,
                          color: homeColor,
                          fontFamily: "pnuB",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField2(
                    controller: _controllerPhone,
                    hint: "رقم الهاتف",
                    inputType: TextInputType.number,
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
                              Post post = Post(
                                phone: _controllerPhone.text,
                                desc: _controllerDesc.text,
                                id: widget.post.id!,
                                status: widget.post.status!,
                                userId: widget.post.userId,
                              );
                              PostCubit.get(context)
                                  .updatePost(post)
                                  .then((value) {
                                PostCubit.get(context)
                                    .getPosts(endPoint: "/post/get-my-Posts");
                                pop(context);
                              });
                            }
                          },
                          text: "اضافة",
                          textColor: Colors.white,
                          fontSize: 14,
                        ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool? isValidate() {
    if (_controllerDesc.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, message: "اكتب وصف الاعلان", color: homeColor);
      return false;
    } else if (_controllerPhone.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, message: "اكتب رقم الهاتف", color: homeColor);
      return false;
    } else {
      return true;
    }
  }
}
