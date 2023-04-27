import 'dart:convert';
import 'dart:io';

import 'package:carsa/helpers/functions.dart';

import 'package:carsa/models/home_model.dart';
import 'package:carsa/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../helpers/constants.dart';
import '../../models/favorite.dart';
import '../../models/setting_model.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  HomeModel homeModel = HomeModel();

  Map<int, int> favorites = {};

  bool load = false;

  getHomeData() async {
    load = true;
    emit(HomeGetDataLoad());
    var headers = {
      'Content-Type': 'application/json',

      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
      // If needed
      'Access-Control-Allow-Headers': 'X-Requested-With,content-type',
      // If needed
      'Access-Control-Allow-Credentials': true
      // If  needed
    };

    final dio = Dio(BaseOptions(baseUrl: baseUrl, headers: headers));
    final response = await dio.get(
      home+"?userId=${currentUser.id}",
    );

    if (response.statusCode == 200) {
      var decode = jsonDecode(response.toString());

      print(decode.toString());

      homeModel = HomeModel.fromJson(decode);
      // print(homeModel.user!.id.toString() + "hddddddddd");

      homeModel.products!.forEach((element) {});


      if(homeModel.user!=null)   userModel = currentUser = homeModel.user!;

      printFunction("userModel.id${currentUser.userName}");
      printFunction(homeModel.categories!.length);
      load = false;
      emit(HomeLoadDataSuccess(homeModel));
    } else {
      printFunction("errrrrrrrrrror");
      emit(HomeLoadDataError());
    }
  }

  List<Favorite> favoritesData = [];

  bool loadFav = false;

  getFavorites() async {
    loadFav = true;
    favoritesData = [];
    emit(GetFavGetDataLoad());

    var headers = {
      "Authorization": token,

      // If  needed
    };

    final dio = Dio(BaseOptions(
        baseUrl: baseUrl, headers: headers, responseType: ResponseType.plain));
    final response = await dio.get(getFavPoint);

    if (response.statusCode == 200) {
      printFunction(response.statusCode);
      var decode = jsonDecode(response.data.toString());
      printFunction(decode);
      favoritesData = [];
      decode.forEach((v) {
        favoritesData.add(Favorite.fromJson(v));
      });
      favoritesData.forEach((element) {
        favorites.addAll({element.productId!: element.productId!});
      });
      printFunction(favorites);
      printFunction("favoritesData${favoritesData.length}");
      loadFav = false;
      emit(GetFavLoadDataSuccess(favoritesData));
    } else {
      printFunction("errrrrrrrrrror");
      emit(GetFavLoadDataError());
    }
  }

  Future changeFavorite(int productId, context) async {
    if (isRegistered()) {
      favorites.containsValue(productId)
          ? favorites.remove(productId)
          : favorites.addAll({productId: productId});

      emit(AddFavSuccessLoad());

      var headers = {'Authorization': token};
      var request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + addFavPoint));
      request.fields.addAll({
        "ProductId": productId.toString(),
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String jsonsDataString = await response.stream.bytesToString();
        final jsonData = jsonDecode(jsonsDataString);

        printFunction(jsonData);
        getFavorites();
        emit(ChangeFavSuccess());
      } else {
        favorites.containsValue(productId)
            ? favorites.remove(productId)
            : favorites.addAll({productId: productId});

        emit(ChangeFavSuccessError());
      }
    } else {
      showSnakeBar(context: context);
    }
  }

  Future<http.StreamedResponse> httpPost(
      int id, Map<String, String> params, endPoint) async {
    final headers = {
      "Authorization": token,

      // If  needed
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + deleteCartPoint));
    request.fields.addAll({'id': "$id"});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  UserModel userModel = UserModel();

  bool loadUserDetails = false;

  Future getUserDetails() async {
    loadUserDetails = true;
    emit(GetUserDetails());
    var headers = {'Authorization': token};
    var request =
        http.Request('POST', Uri.parse(baseUrl + getUserDetailsPoint));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);

      Map<String, dynamic> json = {
        "id": jsonData["user"]['id'],
        "userName": jsonData["user"]['userName'],
        "fullName": jsonData["user"]['fullName'],
        "imageUrl": jsonData["user"]['imageUrl'],
        "status": jsonData["user"]['status'],
        "role": jsonData["user"]['role'],
      };
      userModel = UserModel.fromJson(json);

      printFunction("userModel.id${userModel.status}");
      loadUserDetails = false;
      emit(GetUserDetails());

      print(jsonData);
    } else {
      print(response.reasonPhrase);
    }
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
      return "a.jpg";
    }
  }

  Future getImage(context, imageProvider) async {
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(
      source: imageProvider,
      imageQuality: 5,
    );
    if (pickedFile != null) {
      File? imagePath = File(pickedFile.path);
      emit(PickedImage(imagePath));
      imagePath = null;
    } else {
      print('No image selected.');
    }
  }

  bool loadUpdate = false;

  Future updateProfile({name, phone, image}) async {
    loadUpdate = true;
    emit(UpdateProfileLoad());
    var headers = {'Authorization': token};
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + updateUserDetailsPoint));
    request.fields.addAll({
      'FullName': name,
      'Email': 'add@gmail.com',
      'Phone': phone,
      'ImageUrl': image
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      loadUpdate = false;
      emit(UpdateProfileSuccess("تم التعديل بنجاح"));
    } else {
      loadUpdate = false;
      print(response.reasonPhrase);
      emit(UpdateProfileError("فشلت العملية"));
    }
  }

  int currentIndex = 0;

  changeNav(int index) {
    currentIndex = index;

    emit(ChangeNav());
  }

  List<SittingModel> sittings = [];

  bool loadSittings = false;

  getSitting() async {
    loadSittings = true;
    sittings = [];
    emit(GetDataLoadLoad());
    var request =
        http.Request('GET', Uri.parse(baseUrl + '/sitting/get-sittings'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      var responseBody = await response.stream.bytesToString();
      print(response);
      final data = jsonDecode(responseBody);
      data.forEach((e) {
        sittings.add(SittingModel.fromJson(e));
      });
      print("" + sittings[0].name!);
      loadSittings = false;
      emit(GetDataLoadSuccess());
    } else {
      print(response.statusCode.toString());
      loadSittings = false;
      emit(GetDataLoadLoad());
    }
  }


}
