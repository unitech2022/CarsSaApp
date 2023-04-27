part of 'fav_cubit.dart';

@immutable
abstract class FavState {}

class FavInitial extends FavState {}

class AddFavGetDataLoad extends FavState {}
class AddFavLoadDataSuccess extends FavState {
}
class AddFavLoadDataError extends FavState {}



class GetFavGetDataLoad extends FavState {}
class GetFavLoadDataSuccess extends FavState {

  final List<Favorite> carts;

  GetFavLoadDataSuccess(this.carts);
}
class GetFavLoadDataError extends FavState {}






class ChangeFavSuccess extends FavState {}

class AddFavSuccessLoad extends FavState {}
class ChangeFavSuccessError extends FavState {}

