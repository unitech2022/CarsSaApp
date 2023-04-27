
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/address_cubit/address_cubit.dart';
import '../../../bloc/order_cubit/order_cubit.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/helper_function.dart';
import '../../../helpers/styles.dart';
import '../../../models/address.dart';
import '../../../widgets/Texts.dart';
import '../../../widgets/custom_button.dart';
import '../../my-address_screen/map_screen.dart';

class MyAddresses extends StatefulWidget {
  @override
  State<MyAddresses> createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  int selectedRadio = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddressCubit.get(context).getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return AddressCubit.get(context).loadGetAddresses
            ? const Center(
          child: CircularProgressIndicator(
            color: homeColor,
            strokeWidth: 3,
          ),
        )
            : AddressCubit.get(context).addresses.isEmpty
            ? Center(
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 30),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     border: Border.all(color: homeColor, width: 1)),
            child: InkWell(
              onTap: () async {
                await pushPage(
                    context: context,
                    page: MapScreen(
                        lable: "",
                        latitude: "",
                        longitude: "",
                        addressId: 1,
                        status: 0,
                        detailsAddress: "",
                        address: Address()));

                setState(() {});
              },
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: homeColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Texts(
                      title: 'إضافة عنوان جديد',
                      fSize: 22,
                      weight: FontWeight.w400,
                      color: homeColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            child: Stack(
              children: [
                Padding(
                    padding:
                    const EdgeInsets.only(top: 10, bottom: 65),
                    child: ListView.builder(
                        itemCount: AddressCubit.get(context)
                            .addresses
                            .length +
                            1,
                        itemBuilder: (ctx, index) {
                          return index ==
                              AddressCubit.get(context)
                                  .addresses
                                  .length
                              ? Container(
                            height: 40,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            // decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     border: Border.all(color: homeColor, width: 1)),
                            child: InkWell(
                              onTap: () async {
                                await pushPage(
                                    context: context,
                                    page: MapScreen(
                                        lable: "",
                                        latitude: "",
                                        longitude: "",
                                        addressId: 1,
                                        status: 0,
                                        detailsAddress: "",
                                        address: Address()));

                                setState(() {});
                              },
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: homeColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Texts(
                                      title: 'إضافة عنوان جديد',
                                      fSize: 22,
                                      weight: FontWeight.w400,
                                      color: homeColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                              : Container(
                            height: 100,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.2,
                                    color: Colors.green)),
                            margin: const EdgeInsets.all(20),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/pin.png',
                                      height: 30,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(
                                      width: 13,
                                    ),
                                    Expanded(
                                      child: Texts(
                                        title:
                                        AddressCubit.get(ctx)
                                            .addresses[index]
                                            .lable,
                                        fSize: 18,
                                        color: Colors.black,
                                        weight: FontWeight.w300,
                                      ),
                                    ),
                                    Expanded(
                                        child: Container()),
                                    Radio<int>(
                                      activeColor: homeColor,
                                      value: AddressCubit.get(
                                          context)
                                          .addresses[index]
                                          .id!,
                                      groupValue:
                                      AddressCubit.get(
                                          context)
                                          .selectedRadio,
                                      onChanged: (int? value) {
                                        AddressCubit.get(
                                            context)
                                            .changeValue(
                                            value!);
                                        print(value);
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),

                                // if(AddressProvider.getInItRead(context).addresses.length>1)
                              ],
                            ),
                          );
                        })),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CustomButton3(
                        text: "التالي",
                        fontFamily: "PNUB",
                        onPress: () {
                          if (AddressCubit.get(context)
                              .selectedRadio ==
                              0) {
                            HelperFunction.slt.notifyUser(
                                color: homeColor,
                                context: context,
                                message:
                                "من فضلك اختار عنوان توصيل ");
                          } else {
                            OrderCubit.get(context)
                                .changeStepperOrder(1);
                          }
                        },
                        redius: 10,
                        color: homeColor,
                        textColor: Colors.white,
                        fontSize: 18,
                        height: 50),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}