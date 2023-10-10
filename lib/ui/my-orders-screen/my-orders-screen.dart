import 'package:carsa/bloc/order_cubit/order_cubit.dart';
import 'package:carsa/helpers/router.dart';
import 'package:carsa/models/order.dart';
import 'package:carsa/ui/my-orders-screen/details_order.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/functions.dart';
import '../../helpers/styles.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

List<String> _status = ["قيد الانتظار", "جارى التنفيذ", "تم التسليم", "منتهى"];

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrderCubit.get(context).getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, nav);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: homeColor,
                  ),
                ),
                title: const Text(
                  "طلباتي'",
                  style: TextStyle(color: homeColor, fontFamily: "pnuR"),
                ),
              ),
              body: OrderCubit.get(context).loadOrders
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: homeColor,
                        strokeWidth: 3,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      itemCount: OrderCubit.get(context).orders.length,
                      itemBuilder: (_, i) {
                        ResponseOrder order = OrderCubit.get(context).orders[i];

                        DateTime now =
                            DateTime.parse(order.order!.createdAt.toString());
                        String formattedDate =
                            DateFormat('yyyy-MM-dd – kk:mm').format(now);
                        return Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichTextOrder(
                                    value: "${order.order!.id}",
                                    lable: "رقم الطلب : ",
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  RichTextOrder(
                                    value:
                                        order.order!.price.toStringAsFixed(2),
                                    lable: "المبلغ الكلي  : ",
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text("عنوان التوصيل : ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "pnuR",
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                                  .withOpacity(.5))),

                                      SizedBox(
                                        width: 108,
                                        child: Text(order.address!.lable ?? "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "pnuR",
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 14)),
                                      )
                                    ],
                                  ),
                                  RichTextOrder(
                                    value: _status[order.order!.status!],
                                    lable: "حالة الطلب : ",
                                    color: order.order!.status == 0
                                        ? Colors.green
                                        : order.order!.status == 1
                                            ? Colors.deepOrange
                                            : Colors.red,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  RichTextOrder(
                                    value: formattedDate,
                                    lable: "تاريح الطلب : ",
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                ],
                              ),
                              MaterialButton(
                                  color: homeColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  onPressed: () {
                                    pushPage(
                                        context: context,
                                        page: DetailsOrder(order.order!.id!));
                                  },
                                  child: const Text(
                                    "تفاصيل الطلب",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: "pnuB",
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        );
                      })),
        );
      },
    );
  }
}

class RichTextOrder extends StatelessWidget {
  final String lable, value;
 final Color color;

  RichTextOrder(
      {required this.lable, required this.value, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: lable,
        style: TextStyle(
            fontSize: 14,
            fontFamily: "pnuR",
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(.5)),
        children: [
          TextSpan(
              text: value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "pnuR",
                  color: color,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14)),
        ],
      ),
    );
  }
}
