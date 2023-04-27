import 'dart:convert';

import 'package:carsa/helpers/constants.dart';
import 'package:carsa/models/car_mode.dart';
import 'package:carsa/models/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../helpers/functions.dart';
import '../../models/response_pagination.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of<ProductCubit>(context);

  List<Product> products = [];
  bool load = false;
  bool loadPage = false;
  getProductsByCategory(int id, {endpoint}) async {
    products = [];
    load = true;
    emit(GetProductDataLoad());
    var request = http.MultipartRequest('GET', Uri.parse(baseUrl + endpoint));
    request.fields.addAll({'categoryId': id.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      jsonData.forEach((v) {
        products.add(Product.fromJson(v));
      });
      load = false;
      emit(GetProductDataSuccess());
    } else {
      printFunction("errrrrrrrrrror" + response.statusCode.toString());
      emit(GetProductDataError());
    }
  }

  int totalPages = 0;

  ResponsePagination? responsePagination;
  getProductsByCategoryPage(int id, {carId,endpoint, page, status = 0}) async {
    if (status == 0) {
      load = true;
    } else {
      loadPage = true;
    }

    print(endpoint+"=====> end point");
    emit(GetProductDataLoad());
    var request = http.MultipartRequest('GET', Uri.parse(baseUrl + endpoint));

 // if( status!=0 ){
   print("carModeId");
   request.fields.addAll({
     'categoryId': id.toString(),
     'page': page.toString(),
     'ItemsPerPage': "20",
     "carModeId" :carId.toString()
   });
 // }else {
 //   print("categoryId");
 //   request.fields.addAll({
 //     'categoryId': id.toString(),
 //     'page': page.toString(),
 //     'ItemsPerPage': "20"
 //     // "carModeId" :carId.toString()
 //   });
 // }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);

      if (status == 0) {
        responsePagination = ResponsePagination.fromJson(jsonData);
        load = false;
      } else {
        ResponsePagination responsePagination2 =
            ResponsePagination.fromJson(jsonData);
        responsePagination!.totalPage = responsePagination2.totalPage;
        responsePagination!.items!.addAll(responsePagination2.items!);
        loadPage = false;
      }
      emit(GetProductDataSuccess());
    } else {
      printFunction("errrrrrrrrrror" + response.statusCode.toString());
      emit(GetProductDataError());
    }
  }

  List<Product> searchProducts = [];
  bool loadSearch = false;

  searchProductsData({name}) async {
    searchProducts = [];
    loadSearch = true;
    emit(SearchProductDataLoad());
    var request =
        http.MultipartRequest('GET', Uri.parse(baseUrl + searchProductsPoint));
    request.fields.addAll({'name': name});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      jsonData.forEach((v) {
        searchProducts.add(Product.fromJson(v));
      });
      loadSearch = false;
      emit(SearchProductDataSuccess());
    } else {
      loadSearch = false;
      printFunction("errrrrrrrrrror");
      emit(SearchProductDataError());
    }
  }

  bool loadGetProducts = false;
  List<Product> listAllProducts = [];

  getAllProducts() async {
    loadGetProducts = true;
    listAllProducts = [];
    emit(GetProductsLoadStat());
    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl + "/product/get-products"));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        listAllProducts.add(Product.fromJson(e));
      });
      loadGetProducts = false;
      emit(GetProductsSuccessStat(listAllProducts));
    } else {
      print(response.statusCode);
      loadGetProducts = false;
      emit(GetProductsErrorStat("Error"));
    }
  }

// carModel  data
  bool loadCarModels = false;
  List<CarModel> carModels = [];
  getCarModels({carId}) async {
    carModels = [];
    loadCarModels = true;
    emit(GetCarModelsLoad());
    var request = http.MultipartRequest('GET',
        Uri.parse(baseUrl + '/carModel/get-carModels-by-carId?carId=$carId'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        carModels.add(CarModel.fromJson(e));
      });
       loadCarModels = false;
      emit(GetCarModelsSuccess());
    } else {
      loadCarModels = false;
      print(response.reasonPhrase);
      emit(GetCarModelsError());
    }
  }


}
