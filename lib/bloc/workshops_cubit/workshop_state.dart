import 'dart:io';

import 'package:carsa/models/home_model.dart';
import 'package:carsa/models/rate_response.dart';
import 'package:carsa/models/workshop_model.dart';

import '../../models/response.dart';

abstract class WorkshopState {}

class WorkshopStateInitial extends WorkshopState {}

class GetCategoriesLoad extends WorkshopState {}

class GetCategoriesSuccess extends WorkshopState {}

class GetCategoriesError extends WorkshopState {}

class GetWorkshopByIdLoad extends WorkshopState {}

class GetWorkshopByIdSuccess extends WorkshopState {
  final WorkshopDetailsModel workshops;
  GetWorkshopByIdSuccess(this.workshops);
}

class GetWorkshopByIdError extends WorkshopState {
  final String message;
  GetWorkshopByIdError(this.message);
}

// get worksShops By Category id
class GetWorkshopDataByCatIdLoad extends WorkshopState {}

class GetWorkshopDataByCatIdSuccess extends WorkshopState {
  final ResponseModel responseModel;

  GetWorkshopDataByCatIdSuccess(this.responseModel);
}

class GetWorkshopDataByCatIdError extends WorkshopState {
  final String message;
  GetWorkshopDataByCatIdError(this.message);
}

// add  post
class AddWorkshopDataLoad extends WorkshopState {}

class AddWorkshopDataSuccess extends WorkshopState {}

class AddWorkshopDataError extends WorkshopState {}

class ChangeIndexState extends WorkshopState {}

// get Rating
class RatingWorkshopLoad extends WorkshopState {}

class RatingWorkshopSuccess extends WorkshopState {
  final List<RateResponse> rats;
  RatingWorkshopSuccess(this.rats);
}

class RatingWorkshopError extends WorkshopState {}

// add rate
class AddRateWorkshopLoad extends WorkshopState {}

class AddRateWorkshopSuccess extends WorkshopState {
  final String message;
  AddRateWorkshopSuccess(this.message);
}

class AddRateWorkshopError extends WorkshopState {}

// update rate
class UpdateRateWorkshopLoad extends WorkshopState {}

class UpdateRateWorkshopSuccess extends WorkshopState {
  final String message;
  UpdateRateWorkshopSuccess(this.message);
}

class UpdateRateWorkshopError extends WorkshopState {}



class AddWorkshopLoad extends WorkshopState {}

class AddWorkshopSuccess extends WorkshopState {}

class AddWorkshopError extends WorkshopState {}



class SelectedImageState extends WorkshopState {
  final File imageSelected;

  SelectedImageState(this.imageSelected);
}

class UploadImageLoad extends WorkshopState {}

class UploadImageSuccess extends WorkshopState {
  final String image;
  UploadImageSuccess(this.image);
}

class UploadImageError extends WorkshopState {}

//others
class SelectAddressState extends WorkshopState {}


class GetWorkshopDataByUserIdLoad extends WorkshopState {}

class GetWorkshopDataByUserIdSuccess extends WorkshopState {
  final WorkshopModel responseModel;

  GetWorkshopDataByUserIdSuccess(this.responseModel);
}

class GetWorkshopDataByUserIdError extends WorkshopState {
  final String message;
  GetWorkshopDataByUserIdError(this.message);
}
class GetWorkshopDataByUserIdNotFound extends WorkshopState {}
