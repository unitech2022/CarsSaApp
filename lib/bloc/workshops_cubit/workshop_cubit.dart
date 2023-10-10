import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:carsa/bloc/workshops_cubit/workshop_state.dart';
import 'package:carsa/models/response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../helpers/constants.dart';
import 'package:http/http.dart' as http;
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../models/address.dart';
import '../../models/home_model.dart';
import '../../models/rate_response.dart';
import '../../models/workshop_model.dart';
import '../../work_shop_medul/screens/home_screen/home_screen.dart';

class WorkshopCubit extends Cubit<WorkshopState> {
  WorkshopCubit() : super(WorkshopStateInitial());
  static WorkshopCubit get(context) => BlocProvider.of<WorkshopCubit>(context);

  WorkshopModel? workshopModel;
  Future getWorkshopsByUserId() async {
    emit(GetWorkshopDataByUserIdLoad());



    var request = http.MultipartRequest(
        'GET', Uri.parse(baseUrl+'/workshops/get-workshop-by-userId'));

    request.fields.addAll({'userId': currentUser.id.toString()});

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      workshopModel = WorkshopModel.fromJson(jsonData);
      emit(GetWorkshopDataByUserIdSuccess(workshopModel!));
    } else if (response.statusCode == 404) {
      emit(GetWorkshopDataByUserIdNotFound());
    } else {
      print(response.reasonPhrase);
      emit(GetWorkshopDataByUserIdError("حدث خطأ"));
    }
  }



  bool loadCategories = false;
  List<CategoryWork> categories = [];
  Future getCategoriesWork() async {
    loadCategories = true;
    categories = [];
    print("CategoryWORKShops");

    emit(GetCategoriesLoad());

    final response = await Dio().get(getCategoriesWorkshopsPath);
    print(response.statusCode.toString() + "CategoryWORKShops");
    if (response.statusCode == 200) {
      print(response.data);
      categories = [];
      response.data.forEach((e) {
        categories.add(CategoryWork.fromJson(e));
      });
      loadCategories = false;
      emit(GetCategoriesSuccess());
    } else {
      loadCategories = false;
      emit(GetCategoriesError());
    }
  }

  bool loadworks = false;
  ResponseModel? responseModel;
  Future getWorkshopsByCaiId({catId, page}) async {
    loadworks = true;
    emit(GetWorkshopDataByCatIdLoad());

    print("stassssssss");

    var request = http.MultipartRequest(
        'GET', Uri.parse('$baseUrl/workshops/get-workshop-by-CatId'));

    request.fields.addAll({
      'itemsPerPage': '10',
      'latUser': "${locData.latitude.toString()}",
      'lngUser': '${locData.longitude.toString()}',
      'page': page.toString(),
      'categoryId': catId.toString()
    });

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData.toString() + "WWWWWWWWW");
      loadworks = false;
      responseModel = ResponseModel.fromJson(jsonData);
      emit(GetWorkshopDataByCatIdSuccess(responseModel!));
    } else {
      // loadworks = false;
      print(response.reasonPhrase);
      emit(GetWorkshopDataByCatIdError(response.statusCode.toString()));
    }
  }

  //get workshop by  id
  WorkshopDetailsModel? workshops;
  bool loadDetails = false;
  Future getWorksById(id) async {
    loadDetails = true;
    emit(GetWorkshopByIdLoad());
    var request = http.MultipartRequest(
        'GET', Uri.parse('$baseUrl/workshops/get-workshop-by-id'));
    request.fields.addAll({'id': id.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData.toString() + "getWork");
      loadDetails = false;
      workshops = WorkshopDetailsModel.fromJson(jsonData);
      emit(GetWorkshopByIdSuccess(WorkshopDetailsModel.fromJson(jsonData)));
    } else {
      print(response.reasonPhrase);
      emit(GetWorkshopByIdError(response.reasonPhrase.toString()));
    }
  }

//add rate
  bool loadAddRate = false;
  Future addRate(Rate rate, context) async {
    loadAddRate = true;
    emit(AddRateWorkshopLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/rate/add-rate'));
    request.fields.addAll({
      'WorkshopId': rate.workshopId.toString(),
      'UserId': currentUser.id.toString(),
      'Comment': rate.comment!,
      'Stare': rate.stare.toString()
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData.toString() + "WWWWWWWWW");
      loadAddRate = false;
      pop(context);
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.green, message: jsonData["message"]);
      getWorksById(rate.workshopId);
      emit(AddRateWorkshopSuccess(jsonData["message"]));
    } else {
      loadAddRate = false;
      print(response.statusCode.toString() + "add rate");
      emit(AddRateWorkshopError());
    }
  }

//get rates
  List<RateResponse> rates = [];
  Future getRates({workshopId}) async {
    emit(RatingWorkshopLoad());

    var request =
        http.MultipartRequest('GET', Uri.parse('$baseUrl/rate/get-rates'));
    request.fields.addAll({'workShopId': workshopId.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData.toString() + "WWWWWWWWW");
      jsonData.forEach((v) {
        rates.add(RateResponse.fromJson(v));
      });
      emit(RatingWorkshopSuccess(rates));
    } else {
      print(response.statusCode.toString() + "add rate");
      emit(RatingWorkshopError());
    }
  }

// update rate
  Future updateRate({workshopId, star, id}) async {
    emit(UpdateRateWorkshopLoad());
    var request =
        http.MultipartRequest('PUT', Uri.parse('$baseUrl/rate/update-rate'));
    request.fields.addAll({
      'WorkshopId': workshopId.toString(),
      'star': star.toString(),
      'id': id.toString()
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData.toString() + "WWWWWWWWW");
      emit(UpdateRateWorkshopSuccess(jsonData['message']));
    } else {
      print(response.statusCode.toString());
      emit(UpdateRateWorkshopError());
    }
  }

  int currentIndex = 1;
  changeIndex(newIndex) {
    currentIndex = newIndex;
    emit(ChangeIndexState());
  }

// provider
//add workshop
  bool loadAdd = false;
  Future addWorkshop(Workshop workshop, {context}) async {
    loadAdd = true;
    emit(AddWorkshopLoad());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + '/workshops/add-workshop'));
    request.fields.addAll({
      'categoryId': workshop.categoryId.toString(),
      'name': workshop.name!,
      'image': workshop.image!,
      'userId': currentUser.id!,
      'desc': workshop.desc!,
      'address': workshop.address!,
      'Lat': workshop.lat.toString(),
      'Lng': workshop.lng.toString(),
      'phone': workshop.phone.toString(),
      'phoneWhats': workshop.phoneWhats.toString()
    });

    http.StreamedResponse response = await request.send();

    print(response.statusCode.toString() + "addWork");
    if (response.statusCode == 200) {
      // String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonDecode(jsonsDataString);

      loadAdd = false;
      pushPage(context: context, page:  HomeScreenWorkShop());
      emit(AddWorkshopSuccess());
    } else {
      loadAdd = false;
      emit(AddWorkshopError());
    }
  }

  bool loadCategory = false;

 
  // images
  Future getImage(context, imageProvider) async {
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(
      source: imageProvider,
      imageQuality: 5,
    );
    if (pickedFile != null) {
      File? imagePath = File(pickedFile.path);
      emit(SelectedImageState(imagePath));
      uploadImage(imagePath);
      imagePath = null;
    } else {
      print('No image selected.');
    }
  }

  AddressModel addressModel = AddressModel(label: "", lat: 0.0, lng: 0.0);

  selectAddress(AddressModel newAddress) {
    addressModel = newAddress;
    emit(SelectAddressState());
  }

  CategoryWork? categoryWork;
  selectCategory(CategoryWork newCategoryWork) {
    categoryWork = newCategoryWork;
    emit(SelectAddressState());
  }

  bool loadImage = false;

  Future<dynamic> uploadImage(file) async {
    loadImage = true;
    emit(UploadImageLoad());
    const url = baseUrl + uploadImagePoint;
    var request = http.MultipartRequest("POST", Uri.parse(url));

    var multipartFile = await http.MultipartFile.fromPath(
      "file",
      file.path,
    );
    request.files.add(multipartFile);
    http.StreamedResponse response = await request.send();
    var postBody = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      emit(UploadImageSuccess(postBody.body.toString()));

      //update profile

    } else {
      emit(UploadImageError());
      return "a.jpg";
    }
  }


}





//'http://localhost:5000/workshops/get-workshop-by-CatId?itemsPerPage=10&page=1&categoryId'