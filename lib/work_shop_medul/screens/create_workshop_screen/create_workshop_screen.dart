import 'dart:ffi';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carsa/models/address.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc/workshops_cubit/workshop_cubit.dart';
import '../../../bloc/workshops_cubit/workshop_state.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/helper_function.dart';
import '../../../helpers/styles.dart';
import '../../../models/workshop_model.dart';
import '../../../ui/my-address_screen/map_screen.dart';
import '../../../widgets/Texts.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_drop_down2.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/text_widget.dart';
import 'map_screen.dart';



class CreateWorkShopScreen extends StatefulWidget {
  const CreateWorkShopScreen();

  @override
  State<CreateWorkShopScreen> createState() => _CreateWorkShopScreenState();
}

class _CreateWorkShopScreenState extends State<CreateWorkShopScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerWhatsNumber = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();

  File? file;
  String image = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WorkshopCubit.get(context).getCategoriesWork();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerName.dispose();
    _controllerPhone.dispose();
    _controllerDesc.dispose();
    _controllerWhatsNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkshopCubit, WorkshopState>(
      builder: (context, state) {
        if (state is SelectedImageState) {
          file = state.imageSelected;
        }

        if (state is UploadImageSuccess) {
          image = state.image;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              "انشاء الورشة ",
              style: TextStyle(
                  color: homeColor,
                  fontFamily: "pnuB",
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: WorkshopCubit.get(context).loadCategory
              ? const Center(
                  child: CircularProgressIndicator(
                    color: homeColor,
                    strokeWidth: 3,
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: CustomDropDownWidget2(
                          list: WorkshopCubit.get(context).categories,
                          onSelect: (value) {
                            WorkshopCubit.get(context).selectCategory(value);
                          },
                          height: 50,
                          hint: "اختار القسم ",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField2(
                        controller: _controllerName,
                        hint: "اسم الورشة",
                        inputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField2(
                        controller: _controllerDesc,
                        hint: "تفاصيل الورشة",
                        inputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField2(
                        controller: _controllerPhone,
                        hint: "رقم الهاتف",
                        inputType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField2(
                        controller: _controllerWhatsNumber,
                        hint: "رقم واتساب",
                        inputType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final address = Navigator.push(
                            context,
                            // Create the SelectionScreen in the next step.
                            MaterialPageRoute(
                                builder: (context) => SelectMapScreen()),
                          ).then((value) {
                            WorkshopCubit.get(context)
                                .selectAddress(value as AddressModel);
                          });
                        },
                        child: Container(
                          height: 55,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: const Color(0xffF6F6F6),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Texts(
                                  title: WorkshopCubit.get(context)
                                              .addressModel
                                              .label ==
                                          ""
                                      ? "اختار الموقع"
                                      : WorkshopCubit.get(context)
                                          .addressModel
                                          .label,
                                  fSize: 16,
                                  color: Colors.grey,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          HelperFunction.slt
                              .showSheet(context, _selectImage(context));
                        },
                        child: SizedBox(
                            height: 150,
                            width: 150,
                            child: image != ""
                                ? CachedNetworkImage(
                                    imageUrl: baseurlImage + image,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    width: 90,
                                    placeholder: (context, url) =>
                                        const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: homeColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : file == null
                                    ? const Icon(
                                        Icons.camera_alt,
                                        size: 100,
                                      )
                                    : Image.file(
                                        file!,
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      WorkshopCubit.get(context).loadAdd
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
                                  Workshop workshop = Workshop(
                                    categoryId:  WorkshopCubit.get(context).categoryWork!.id!,
                                      name: _controllerName.text,
                                      desc: _controllerDesc.text,
                                      phone:"+966"+ _controllerPhone.text,
                                      image: image,
                                      phoneWhats:"+966"+ _controllerWhatsNumber.text,
                                      address: WorkshopCubit.get(context)
                                          .addressModel
                                          .label,
                                      lat: WorkshopCubit.get(context)
                                          .addressModel
                                          .lat,
                                      lng: WorkshopCubit.get(context)
                                          .addressModel
                                          .lng);

                                  WorkshopCubit.get(context)
                                      .addWorkshop(workshop, context: context);
                                }
                              },
                              text: "انشاء",
                              textColor: Colors.white,
                              fontSize: 14,
                            ),
                    ]),
                  ),
                ),
        );
      },
    );
  }

  bool? isValidate() {
    if (WorkshopCubit.get(context).categoryWork==null) {
      HelperFunction.slt.notifyUser(
          context: context, message: "اختار القسم", color: homeColor);
      return false;
    } else if (_controllerName.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, message: "اكتب اسم الورشة", color: homeColor);
      return false;
    } else if (_controllerDesc.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, message: "اكتب  تفاصيل الورشة ", color: homeColor);
      return false;
    } else if (_controllerPhone.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context, message: "اكتب رقم التواصل", color: homeColor);
      return false;
    } else if (_controllerWhatsNumber.text.isEmpty) {
      HelperFunction.slt.notifyUser(
          context: context,
          message: "اكتب  رقم واتس للتواصل",
          color: homeColor);
      return false;
    } else if (WorkshopCubit.get(context).addressModel.label == "") {
      HelperFunction.slt.notifyUser(
          context: context, message: "اكتب تفاصيل العنوان", color: homeColor);
      return false;
    } else if (WorkshopCubit.get(context).addressModel.lat == 0.0 ||
        WorkshopCubit.get(context).addressModel.lng == 0.0) {
      HelperFunction.slt.notifyUser(
          context: context,
          message: "اختار موقعك من علي الخريطة  ",
          color: homeColor);
      return false;
    } else if (image == "") {
      HelperFunction.slt.notifyUser(
          context: context, message: "اختار صورة الورشة  ", color: homeColor);
      return false;
    } else {
      return true;
    }
  }

  _selectImage(context) => Container(
        height: 280,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 24,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.5),
                  color: const Color(0xFFDCDCDF),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 147,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        pop(context);
                        WorkshopCubit.get(context)
                            .getImage(context, ImageSource.gallery);
                        // printFunction(image);
                        // AuthProvider.getInItRead(context).updateProfile(context,key: "ImageUrl",value:image);
                      },
                      child: Container(
                        height: 147,
                        width: 147,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFF6F2F2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.video_library_outlined,
                              size: 30,
                              color: homeColor,
                            ),
                            const SizedBox(height: 10),
                            TextWidget3(
                                alginText: TextAlign.start,
                                isCustomColor: true,
                                text: "اخترصورة",
                                fontFamliy: "pnuL",
                                fontSize: 18,
                                color: textColor.withOpacity(.5))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () async {
                        pop(context);
                        WorkshopCubit.get(context)
                            .getImage(context, ImageSource.camera);
                      },
                      child: Container(
                        height: 147,
                        width: 147,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFF6F2F2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.video_call,
                              size: 30,
                              color: homeColor,
                            ),
                            const SizedBox(height: 10),
                            TextWidget3(
                                alginText: TextAlign.start,
                                isCustomColor: true,
                                text: "استخدام الكاميرا",
                                fontFamliy: "pnuL",
                                fontSize: 18,
                                color: textColor.withOpacity(.5))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
