import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carsa/models/comment.dart';
import 'package:meta/meta.dart';

import '../../helpers/constants.dart';
import 'package:http/http.dart' as http;

import '../../helpers/functions.dart';
part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitial());


  List<Comment> comments = [];
  bool load = false;

  getComments() async {
    comments = [];
    load = true;
    emit(GetCommentDataLoad());

    var headers = {'Authorization': token};

    var request =
    http.MultipartRequest('GET', Uri.parse(baseUrl + getCommentsPoint));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      jsonData.forEach((v) {
        comments.add(Comment.fromJson(v));
      });
      load = false;
      emit(GetCommentDataSuccess());
    } else {
      printFunction("errrrrrrrrrror");
      emit(GetCommentDataError());
    }
  }


  bool loadAdd=false;
  Future addComment({desc,phone}) async {
    loadAdd=true;
    emit(AddCommentDataLoad());

    var headers = {'Authorization': token};
    var request =
    http.MultipartRequest('POST', Uri.parse(baseUrl+addCommentPoint));

    request.fields.addAll({
      'userId': currentUser.id.toString(),
      'images': 'eeeeeeeeeee',
      'desc': desc,
      'Status': '0',
      'phone': phone.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      loadAdd=false;
      emit(AddCommentDataSuccess());
    } else {
      loadAdd=false;
      print(response.statusCode);
      emit(AddCommentDataError());
    }
  }
}
