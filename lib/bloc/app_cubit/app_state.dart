part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}


class HomeGetDataLoad extends AppState {}
class HomeLoadDataSuccess extends AppState {

  final HomeModel homeModel;

  HomeLoadDataSuccess(this.homeModel);

}
class HomeLoadDataError extends AppState {}
// checkBox;


//fav

class GetFavGetDataLoad extends AppState {}
class GetFavLoadDataSuccess extends AppState {

  final List<Favorite> carts;

  GetFavLoadDataSuccess(this.carts);
}
class GetFavLoadDataError extends AppState {}

class ChangeNav extends AppState {}




class ChangeFavSuccess extends AppState {}

class AddFavSuccessLoad extends AppState {}
class ChangeFavSuccessError extends AppState {}

// user
class GetUserDetails extends AppState{}
class UpdateUserProfile extends AppState{}

//image
class UploadImageLoad extends AppState{


}
class UploadImageSuccess extends AppState{
final String imageUpload;

UploadImageSuccess(this.imageUpload);
}

class PickedImage extends AppState{
  final File imagePath;

  PickedImage(this.imagePath);
}


//update User
class UpdateProfileLoad extends AppState{


}
class UpdateProfileSuccess extends AppState{
final String meassge;

UpdateProfileSuccess(this.meassge);
}
class UpdateProfileError extends AppState{
  final String meassge;

  UpdateProfileError(this.meassge);

}


class GetDataLoadLoad extends AppState {}
class GetDataLoadSuccess extends AppState {
}
class GetDataLoadError extends AppState {}

