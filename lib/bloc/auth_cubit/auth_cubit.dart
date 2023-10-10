import 'dart:convert';

import 'package:carsa/helpers/functions.dart';
import 'package:carsa/helpers/helper_function.dart';

import 'package:carsa/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../helpers/constants.dart';
import '../../models/setting_model.dart';
import '../../ui/otp_screen/otp_screen.dart';
import '../../ui/sign_up_screen/sign_up_screen.dart';

part 'auth_state.dart';

// todo : validate email error
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  checkUserName({phone, context, code}) async {
    emit(CheckUserAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + checkUserNamePoint));
    request.fields.addAll({'phone': phone});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      int status = jsonData["status"];
      if (status == 0) {
        pushPage(
            page: SignUpScreen(
              phone: phone.split(code)[1],
              code: code,
            ),
            context: context);

        //
      } else {
        pushPage(
            page: OtpScreen(phone: phone, code: jsonData["code"]),
            context: context);

        //
      }

      emit(CheckUserAuthStateSuccess(
          phone: phone, code: jsonData["code"], status: jsonData["status"]));
    } else {
      printFunction("errrrrrrrrrror");
      emit(CheckUserAuthStateError());
    }
  }

  Future getCode({phone, context}) async {
    emit(GetCodeLoading());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + getCodePoint));
    request.fields.addAll({'phone': phone});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);

      emit(GetCodeSuccess(phone: phone, code: jsonData["code"]));
    } else if (response.statusCode == 401) {
      HelperFunction.slt.notifyUser(
          context: context, color: Colors.red, message: "الرقم غير مسجل");
      emit(GetCodeError());
    } else {
      HelperFunction.slt
          .notifyUser(context: context, color: Colors.red, message: "هناك خطأ في الخادم");
      emit(GetCodeError());
    }
  }

  bool isValidate = false;

  validateUser({username, code, fullName}) async {
    emit(ValidateAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + validatePoint));
    request.fields
        .addAll({'email': "email" + code.toString(), 'userName': username});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonsDataString);

      registerUser(code: code, userName: username, fullName: fullName);
    } else if (response.statusCode == 400) {
      String jsonsDataString = await response.stream.bytesToString();
      // final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonsDataString);
      emit(ValidateAuthStateError(jsonsDataString));
    } else {
      printFunction(response.statusCode);
      emit(ValidateAuthStateError("حدث خطأ"));
    }
  }

  registerUser({fullName, code, userName, role}) async {
    emit(RegisterAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + registerPoint));
    request.fields.addAll({
      'fullName': fullName,
      'email': "email" + code.toString(),
      "code": code.toString(),
      'userName': userName,
      'knownName': 'askdkalshkjsa',
      'Role': "user",
      'password': 'Abc123@'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      emit(
          RegisterAuthStateSuccess(code: jsonData["code"], userName: userName));
    } else {
      printFunction(response.reasonPhrase);
      emit(RegisterAuthStateError());
    }
  }

  UserModel user = UserModel();

  loginUser({code, userName}) async {
    emit(LoginAuthStateLoad());

    var request =
        http.MultipartRequest('POST', Uri.parse(baseUrl + loginPoint));
    request.fields.addAll({'code': code, 'userName': userName});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonsDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonsDataString);
      printFunction(jsonData);
      UserResponse userResponse = UserResponse.fromJson(jsonData);
      token = "Bearer " + userResponse.token!;
      currentUser = user = userResponse.user!;

      // if(data['driver']!=null) currentUser.driver = Driver.fromJson(data['driver']);
      await saveToken();
      printFunction("currentUser${token}");

      printFunction(userResponse.token);

      emit(LoginAuthStateSuccess(userResponse));
    } else {
      printFunction("errrrrrrrrrror");
      emit(LoginAuthStateError());
    }
  }

  bool isChecked = false;

  changeCheckBox(bool checked) {
    isChecked = checked;
    printFunction(isChecked);
    emit(ChangeCheckBox());
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
