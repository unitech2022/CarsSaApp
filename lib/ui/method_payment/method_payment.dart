import 'package:carsa/bloc/address_cubit/address_cubit.dart';
import 'package:carsa/bloc/app_cubit/app_cubit.dart';
import 'package:carsa/bloc/cart_cubite/cart_cubit.dart';
import 'package:carsa/bloc/order_cubit/order_cubit.dart';
import 'package:carsa/helpers/helper_function.dart';
import 'package:carsa/helpers/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';
import '../../models/address.dart';
import '../../widgets/Texts.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/text_widget.dart';
import '../my-address_screen/map_screen.dart';
import 'componts/confirm_order.dart';
import 'componts/custom_stepper_container.dart';
import 'componts/my_addresses.dart';
import 'componts/payment_method_setup.dart';

class MethodPaymentScreen extends StatefulWidget {
  final double total;

  MethodPaymentScreen({required this.total});

  @override
  State<MethodPaymentScreen> createState() => _MethodPaymentScreenState();
}

class _MethodPaymentScreenState extends State<MethodPaymentScreen> {
  int currentIndex = 0;

  final List<Widget> _screens = [
    MyAddresses(),
    PaymentMethodSetpp(),
    ConfirmOrder()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
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
            title: const Text(
              "طريقة الدفع",
              style: TextStyle(color: homeColor, fontFamily: "pnuR"),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildContainerStepper(),
              Expanded(
                  child: IndexedStack(
                index: OrderCubit.get(context).currentIndex,
                children: _screens,
              ))
            ],
          ),
        );
      },
    );
  }

  Container buildContainerStepper() {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // OrderCubit.get(context).changeStepperOrder(0);
            },
            child: const CustomStepperContainer(
                text: "بيانات العنوان", isDone: true, number: "1"),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(top: 30),
            height: 2,
            width: double.infinity,
            color: homeColor,
          )),
          const SizedBox(
            width: 4,
          ),
          InkWell(
              onTap: () {
                // OrderCubit.get(context).changeStepperOrder(1);
              },
              child: CustomStepperContainer(
                  number: "2",
                  text: "طريقة الدفع",
                  isDone: (OrderCubit.get(context).currentIndex == 1 ||
                          OrderCubit.get(context).currentIndex == 2)
                      ? true
                      : false)),
          const SizedBox(
            width: 4,
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(top: 30),
            height: 2,
            width: double.infinity,
            color: homeColor,
          )),
          const SizedBox(
            width: 4,
          ),
          InkWell(
              onTap: () {
                // OrderCubit.get(context).changeStepperOrder(2);
              },
              child: CustomStepperContainer(
                  number: "3",
                  text: "التاكيد",
                  isDone: OrderCubit.get(context).currentIndex == 2
                      ? true
                      : false)),
        ],
      ),
    );
  }
}







