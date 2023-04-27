import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carsa/models/order.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../helpers/constants.dart';
import '../../helpers/functions.dart';
import '../../models/cart.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of<OrderCubit>(context);

  List<ResponseOrder> orders = [];

  // List<int> quantities = [];
  // List<double> prices = [];
  bool loadOrders = false;
  getOrders() async {
    loadOrders = true;
    emit(GetOrderGetDataLoad());

    var headers = {
      "Authorization": token,

      // If  needed
    };

    final dio = Dio(BaseOptions(
        baseUrl: baseUrl, headers: headers, responseType: ResponseType.plain));
    final response = await dio.get(getOrdersPoint);

    if (response.statusCode == 200) {
      printFunction(response.statusCode);
      var decode = jsonDecode(response.data.toString());
      printFunction(decode);
      orders = [];
      decode.forEach((v) {
        orders.add(ResponseOrder.fromJson(v));
      });
      loadOrders = false;
      emit(GetOrderLoadDataSuccess(orders));
    } else {
      loadOrders = false;
      printFunction("errrrrrrrrrror");
      emit(GetOrderLoadDataError());
    }
  }

  List<Cart> orderDetail = [];
bool loadOrderDetails=false;
  getOrderDetails({orderId}) async {
    orderDetail = [];
    loadOrderDetails=true;
    emit(GetOrderDetailsLoad());

    var headers = {
      "Authorization": token,

      // If  needed
    };

    var request =
        http.MultipartRequest('GET', Uri.parse(baseUrl + getOrderDetailsPoint));
    request.fields.addAll({'orderId': orderId.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      orderDetail = [];
      jsonData.forEach((v) {
        orderDetail.add(Cart.fromJson(v));
      });
      loadOrderDetails=false;
      emit(GetOrderDetailsSuccess(orderDetail));
    } else {
      loadOrderDetails=false;
      printFunction("errrrrrrrrrror");
      emit(GetOrderLoadDataError());
    }
  }

  bool loadAddOrder = false;

  Future addOrder({price,addressId,onSuccess}) async {
    loadAddOrder = true;
    emit(AddOrderGetDataLoad());

    var headers = {
      'Authorization': token
    };
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl+addOrderPoint));
    request.fields.addAll({
      'Price': '$price',
      'Status': '0',
      'SellerId': 'eee',
      'addressId': '$addressId'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      loadAddOrder = false;
      printFunction(jsonData);
      onSuccess();
      emit(AddOrderLoadDataSuccess());
    } else {
      loadAddOrder = false;
      print(response.statusCode);
      emit(AddOrderLoadDataError());
    }
  }


  Future deleteOrder(int id) async {

    emit(DeleteOrderGetDataLoad());


    final params = {
      "id": "$id",
    };

    http.StreamedResponse response =
        await httpPost(id, params, deleteCartPoint);
    //
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonsDataString;


      emit(DeleteOrderLoadDataSuccess(jsonData));

      /*     // get Carts

      final dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: headers,
          responseType: ResponseType.plain));
      final responseCarts = await dio.get(getCartsPoint);

      if (responseCarts.statusCode == 200) {
        carts = [];
        printFunction(responseCarts.statusCode);
        var decode = jsonDecode(responseCarts.data.toString());
        printFunction(decode);

        decode.forEach((v) {
          carts.add(Cart.fromJson(v));
        });
        quantities = [];
        prices = [];
        carts.forEach((element) {
          quantities.add(element.quantity!);
          prices.add(double.parse("${element.price}"));
        });
        emit(DeleteCartLoadDataSuccess(jsonData));

      }*/

      //
    } else {
      printFunction("errrrrrrrrrror");
      emit(DeleteOrderLoadDataError());
    }
  }




int currentIndex=0;
changeStepperOrder(int index){
    currentIndex=index;
    emit(ChangeStepperOrderStae());
}


  Future<http.StreamedResponse> httpPost(
      int id, Map<String, String> params, endPoint) async {
    final headers = {
      "Authorization": token,

      // If  needed
    };
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl + endPoint));
    request.fields.addAll({'id': "$id"});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
}
