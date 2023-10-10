


import 'package:carsa/models/favorite.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit(FavState initialState) : super(initialState);

}
