import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/post_cubit/post_cubit.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/helper_function.dart';
import '../../../helpers/styles.dart';
import '../../../models/workshop_model.dart';
import '../../../widgets/custom_button.dart';

class AddOfferScreen extends StatefulWidget {
  final int workshopId, postId;
  const AddOfferScreen({required this.workshopId, required this.postId});

  @override
  State<AddOfferScreen> createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  final TextEditingController _controllerDescOffer = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "اضافة عرض",
          style: TextStyle(
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
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xffF6F6F6),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: _controllerDescOffer,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp("[٠-٩]"))
                    ],
                    onSaved: (newValue) => newValue!,
                    keyboardType: TextInputType.text,
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
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.normal),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      hintText: "وصف العرض",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                PostCubit.get(context).addOfferLoad
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
                          if (_controllerDescOffer.text.isEmpty) {
                            HelperFunction.slt.notifyUser(
                                context: context,
                                message: "اكتب تفاصيل العرض ",
                                color: homeColor);
                          } else {
                            Offer offer = Offer(
                                text: _controllerDescOffer.text,
                                workshopId: widget.workshopId,
                                phone: currentUser.userName,
                                postId: widget.postId);
                            PostCubit.get(context)
                                .addOffer(offer, contetxt: context);
                          }
                        },
                        text: "اضافة",
                        textColor: Colors.white,
                        fontSize: 14,
                      ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
