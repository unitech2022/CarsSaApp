import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/address_cubit/address_cubit.dart';
import '../../../bloc/app_cubit/app_cubit.dart';
import '../../../bloc/cart_cubite/cart_cubit.dart';
import '../../../bloc/order_cubit/order_cubit.dart';
import '../../../helpers/functions.dart';
import '../../../helpers/helper_function.dart';
import '../../../helpers/router.dart';
import '../../../helpers/styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/text_widget.dart';

class ConfirmOrder extends StatelessWidget {
  ConfirmOrder();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [



                TextWidget3(
                  color: homeColor,
                  fontSize: 20,
                  text: "تكلفة التوصيل : "+ AppCubit.get(context)
                      .homeModel
                      .sittings![2]
                      .value! ,
                  fontFamliy: "pnuB",
                  isCustomColor: true,
                  alginText: TextAlign.center,
                  lines: 1,
                ),
                TextWidget3(
                  color: homeColor,
                  fontSize: 20,
                  text: "سعر الضريبة : "+ (CartCubit.get(context).total * .15).toStringAsFixed(2)
                    ,
                  fontFamliy: "pnuB",
                  isCustomColor: true,
                  alginText: TextAlign.center,
                  lines: 1,
                ),
                TextWidget3(
                  color: homeColor,
                  fontSize: 20,
                  text: "اجمالي السعر : "+((CartCubit.get(context).total * .15 )+double.parse(AppCubit.get(context)
                      .homeModel
                      .sittings![2]
                      .value!)+CartCubit.get(context).total).toStringAsFixed(2)
                  ,
                  fontFamliy: "pnuB",
                  isCustomColor: true,
                  alginText: TextAlign.center,
                  lines: 1,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextWidget3(
                  color: Colors.green,
                  fontSize: 15,
                  text: "سيتم توصيل طلبك بعد تحويل المبلغ المستحق للطلب علي رقم حساب  SA5580000463608016160343",
                  fontFamliy: "pnuB",
                  isCustomColor: true,
                  alginText: TextAlign.center,
                  lines: 3,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget3(
                      color: Colors.black,
                      fontSize: 15,
                      text: "نسخ رقم الحساب",
                      fontFamliy: "pnuB",
                      isCustomColor: true,
                      alginText: TextAlign.center,
                      lines: 2,
                    ),
                    IconButton(

                        onPressed: (){
                          Clipboard.setData(new ClipboardData(text: "SA5580000463608016160343")).then((value) {
                            HelperFunction.slt.notifyUser(
                              context: context,color: Colors.green,message: "تم نسخ رقم الحساب"
                            );
                          });
                        }, icon: Icon(Icons.copy))
                  ],
                ),

                 SizedBox(
                  height: 20,
                ),
                OrderCubit.get(context).loadAddOrder
                    ? const SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: homeColor,
                    ),
                  ),
                )
                    : CustomButton3(
                    text: "تأكيد الطلب",
                    fontFamily: "PNUB",
                    onPress: () {
                      // OrderCubit.get(context).changeStepperOrder(2);
                      printFunction(
                          AddressCubit.get(context).selectedRadio);
                      printFunction(CartCubit.get(context).total);
                      //
double total= double.parse(AppCubit.get(context)
    .homeModel
    .sittings![2]
    .value!) +  (CartCubit.get(context).total * .15)+CartCubit.get(context).total;
      printFunction(total);
                      OrderCubit.get(context)
                          .addOrder(
                          price: total,
                          onSuccess: () {
                            HelperFunction.slt.notifyUser(
                                context: context,
                                color: homeColor,
                                message: "تم ارسال طلبك ");

                            CartCubit.get(context).getCarts();
                            AppCubit.get(context).changeNav(0);
                            Navigator.pushReplacementNamed(context, myOrders);
                            OrderCubit.get(context)
                                .changeStepperOrder(0);
                          },
                          addressId:
                          AddressCubit.get(context).selectedRadio)
                          .then((value) {});

                      // HelperFunction.slt.notifyUser(context: context,color: homeColor,message: "تم ارسال طلبك ");
                      // pop(context);
                    },
                    redius: 10,
                    color: homeColor,
                    textColor: Colors.white,
                    fontSize: 18,
                    height: 50),
              ],
            ),
          ),
        );
      },
    );
  }
}