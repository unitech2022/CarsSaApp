import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../bloc/order_cubit/order_cubit.dart';
import '../../../helpers/styles.dart';
import '../../../widgets/Texts.dart';
import '../../../widgets/custom_button.dart';

class PaymentMethodSetpp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 65),
                child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (ctx, index) {
                      return Container(
                        height: 80,
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [

                                Radio<int>(
                                  activeColor: homeColor,
                                  value: 0,
                                  groupValue: 0,
                                  onChanged: (int? value) {},
                                ),
                                Texts(
                                  title: "الدفع كاش",
                                  fSize: 20,
                                  color: homeColor,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
Divider()
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
                      OrderCubit.get(context).changeStepperOrder(2);
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
  }
}
