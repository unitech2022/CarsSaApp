part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}



class GetProductDataLoad extends ProductState {}
class GetProductDataSuccess extends ProductState {}
class GetProductDataError extends ProductState {}



class GetProductByIdLoad extends ProductState {}
class GetProductByIdSuccess extends ProductState {}
class GetProductByIdError extends ProductState {}

class SearchProductDataLoad extends ProductState {}
class SearchProductDataSuccess extends ProductState {}
class SearchProductDataError extends ProductState {}

class GetCarModelsLoad extends ProductState {}
class GetCarModelsSuccess extends ProductState {}
class GetCarModelsError extends ProductState {}


class GetProductsSuccessStat extends ProductState {
  final List<Product> list ;
  GetProductsSuccessStat(this.list);
}

class GetProductsErrorStat extends ProductState {
  final String error;
  GetProductsErrorStat(this.error);
}

class GetProductsLoadStat extends ProductState {}


