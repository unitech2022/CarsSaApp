import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:carsa/ui/navigation/navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


import '../../helpers/constants.dart';
import 'package:http/http.dart' as http;

import '../../helpers/functions.dart';
import '../../helpers/helper_function.dart';
part 'suggestion_state.dart';

class SuggestionCubit extends Cubit<SuggestionState> {
  SuggestionCubit() : super(SuggestionInitial());
  static SuggestionCubit get(context) => BlocProvider.of<SuggestionCubit>(context);

  bool loadAdd=false;
  Future addSuggestion(BuildContext context,{phone,userName,message}) async {
    loadAdd=true;
    emit(AddSuggestionDataLoad());

    var request = http.MultipartRequest('POST', Uri.parse(baseUrl+'/suggestions/add-suggestions'));
    request.fields.addAll({
      'UserEmail': 'anmdmd@hjdcjk',
      'UserName': userName,
      'UserId': currentUser.id!,
      'UserPhone': phone,
      'Message':message
    });



    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());

      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      loadAdd=false;

      replacePage(page: NavigationScreen(), context: context);
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.green, message: "تم ارسال الرسالة ");
      emit(AddSuggestionDataSuccess());
    } else {
      loadAdd=false;
      print(response.statusCode);
      emit(AddSuggestionDataError());
    }
  }
}
