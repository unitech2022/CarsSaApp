import 'dart:convert';


import 'package:carsa/models/favorite.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../helpers/constants.dart';
import '../../helpers/functions.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit(FavState initialState) : super(initialState);

}
