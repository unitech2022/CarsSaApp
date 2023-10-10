import 'dart:convert';

import 'package:carsa/helpers/constants.dart';
import 'package:carsa/models/comment.dart';
import 'package:carsa/models/offer_response.dart';
import 'package:carsa/ui/my_adds_screen/my_adds_screen.dart';
import 'package:carsa/work_shop_medul/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
import '../../models/post.dart';
import '../../models/workshop_model.dart';


part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  static PostCubit get(context) => BlocProvider.of<PostCubit>(context);

  List<Post> posts = [];
  List<Post> myPosts = [];
  bool load = false;

  getPosts({endPoint}) async {
    posts = [];
    load = true;
    emit(GetPostDataLoad());

    var headers = {'Authorization': token};

    var request = http.MultipartRequest('GET', Uri.parse(baseUrl + endPoint));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      posts = [];
      jsonData.forEach((v) {
        posts.add(Post.fromJson(v));
      });
      load = false;
      emit(GetPostDataSuccess(posts));
    } else {
      printFunction("errrrrrrrrrror" + response.statusCode.toString());
      emit(GetPostDataError());
    }
  }

  getMyPosts({endPoint}) async {
    myPosts = [];
    load = true;
    emit(GetPostDataLoad());

    // var headers = {'Authorization': token};

    var request = http.MultipartRequest('GET', Uri.parse(baseUrl + endPoint));
    request.fields.addAll({'userId': currentUser.id.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      jsonData.forEach((v) {
        myPosts.add(Post.fromJson(v));
      });
      load = false;
      emit(GetPostDataSuccess(myPosts));
    } else {
      printFunction("errrrrrrrrrror");
      emit(GetPostDataError());
    }
  }

  bool loadAdd = false;

  Future addPost(Post post) async {
    // printFunction(currentUser.userName!);
    loadAdd = true;
    emit(AddPostDataLoad());

    var headers = {'Authorization': token};
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + addPostPoint));

    request.fields.addAll({
      'userId': currentUser.id.toString(),
      'images': post.images!,
      'desc': post.desc!,
       'lat': "${locData.latitude.toString()}",
      'lng': "${locData.longitude.toString()}",
      'phone': currentUser.userName!,
      'ModelCar': post.modelCar!,
      'ColorCar': post.colorCar!,
      'NameCar': post.nameCar!
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      loadAdd = false;
      emit(AddPostDataSuccess());
    } else {
      loadAdd = false;
      print(response.statusCode);
      emit(AddPostDataError());
    }
  }

  bool loadDelete = false;

  Future deletePost(int id) async {
    loadDelete = true;
    emit(DeletePostDataLoad());
    final headers = {
      "Authorization": token,

      // If  needed
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + '/post/delete-post'));
    request.fields.addAll({'id': id.toString()});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonsDataString;

      // get Carts
      loadDelete = false;
      getMyPosts(endPoint: "/post/get-my-Posts");
      getPosts(endPoint: getPostsPoint);
      emit(DeletePostDataSuccess());

      //
    } else {
      loadDelete = false;
      printFunction("errrrrrrrrrror");
      emit(DeletePostDataError());
    }
  }

  //update

  bool loadUpdate = false;

  updatePost(Post post) async {
    loadUpdate = true;
    emit(UpdatePostDataLoad());

    var headers = {'Authorization': token};
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + '/post/update-post'));
    request.fields.addAll({
      'userId': post.userId!,
      'images': post.images!,
      'desc': post.desc!,
      'phone': currentUser.userName!,
      'ModelCar': post.modelCar!,
      'ColorCar': post.colorCar!,
      'NameCar': post.nameCar!,
      "id": post.id.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 204) {
      // String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonDecode(jsonsDataString);
      loadUpdate = false;
      printFunction(response.statusCode.toString());
      // print(homeModel.categories!.length);
      
      emit(UpdatePostDataSuccess());
    } else {
      loadUpdate = false;
      printFunction(response.statusCode);
      emit(UpdatePostDataError());
    }
  }

  List<ResponseComment> comments = [];
  bool loadComments = false;

  getComments({postId}) async {
    comments = [];
    loadComments = true;
    printFunction("srrrrrrrrrrror");
    emit(GetCommentDataLoad());

    var headers = {'Authorization': token};

    var request = http.MultipartRequest('GET', Uri.parse(getCommentsPoint));
    request.headers.addAll(headers);

    request.fields.addAll({'postId': postId.toString()});

    http.StreamedResponse response = await request.send();
    printFunction("${response.statusCode}");
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      jsonData.forEach((v) {
        comments.add(ResponseComment.fromJson(v));
      });
      loadComments = false;
      emit(GetCommentDataSuccess());
    } else {
      loadComments = false;
      printFunction("errrrrrrrrrror");
      emit(GetCommentDataError());
    }
  }

  bool loadAddComment = false;

  Future addComment({desc, phone, postId}) async {
    loadAdd = true;
    emit(AddPostDataLoad());

    var headers = {'Authorization': token};
    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + addCommentPoint));

    request.fields.addAll(
        {'text': desc, 'sellerId': 'ثق', 'postId': postId, 'phone': phone});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      loadAdd = false;
      emit(AddPostDataSuccess());
    } else {
      loadAdd = false;
      print(response.statusCode);
      emit(AddPostDataError());
    }
  }

  // getOfferById
  OfferResponse? offerResponse;
  bool getOfferLoad = false;
  Future getOfferDetails({offerId}) async {
    getOfferLoad = true;
    emit(GetOfferDetailsLoad());
    var headers = {'Authorization': token};

    var request =
        http.MultipartRequest('GET', Uri.parse('$baseUrl/comment/get-comment-byId'));
    request.fields.addAll({'commentId': offerId.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      offerResponse = OfferResponse.fromJson(jsonData);
      getOfferLoad = false;
      emit(GetOfferDetailsSuccess());
    } else {
      getOfferLoad = false;
      print(response.reasonPhrase);
      emit(GetOfferDetailsError());
    }
  }



 bool acceptOfferLoad = false;
  Future acceptOffer({offerId,context}) async {
    acceptOfferLoad = true;
     emit(AcceptOfferLoad());
    var headers = {'Authorization': token};

    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/comment/accept-comment'));

    request.fields.addAll({'id': offerId.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      // getMyPosts(endPoint: "/post/get-my-Posts");
      pushPage(context: context,page: MyAddsScreen());
      acceptOfferLoad = false;
       HelperFunction.slt.notifyUser(
              context: context, color: Colors.green, message: "تم قبول الطلب سوف يتم التواصل معك");
       
       emit(AcceptOfferSuccess());
    } else {
      acceptOfferLoad = false;
      print(response.reasonPhrase);
       emit(AcceptOfferError());
    }
  }



  bool getPostLoad = false;
  PostResponseProvider? postResponse;
  Future getPostDetails({id}) async {
    getPostLoad = true;
    emit(GetPostDataProviderLoad());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + '/post/get-post-byId'));
    request.fields.addAll({'id': id.toString(),'userId':currentUser.id!});

    http.StreamedResponse response = await request.send();
    printFunction("${response.statusCode} getPost");
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      getPostLoad = false;
      postResponse = PostResponseProvider.fromJson(jsonData);
      emit(GetPostDataProviderSuccess(postResponse!));
    } else {
      getPostLoad = false;
      emit(GetPostDataProviderError());
    }
  }

  bool addOfferLoad = false;
  Future addOffer(Offer offer, {contetxt}) async {
    addOfferLoad = true;
    emit(AddCommentDataLoad());
    var request = http.MultipartRequest(
        'POST', Uri.parse(baseUrl + '/comment/add-comment'));
    request.fields.addAll({
      'text': offer.text!,
      'userId':currentUser.id!,
      'workshopId': offer.workshopId.toString(),
      'postId': offer.postId.toString(),
      'phone': currentUser.userName.toString()
    });

    http.StreamedResponse response = await request.send();
    printFunction("${response.statusCode} addOffer");
    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      addOfferLoad = false;

      pushPage(context: contetxt, page:  HomeScreenWorkShop());
      HelperFunction.slt.notifyUser(
          context: contetxt,
          message: "تم اضافة العرض بنجاح ",
          color: Colors.green);
      emit(AddCommentDataSuccess());
    } else {
      addOfferLoad = false;
      emit(AddCommentDataError());
    }
  }



}
