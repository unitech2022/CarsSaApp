part of 'suggestion_cubit.dart';

@immutable
abstract class SuggestionState {}

class SuggestionInitial extends SuggestionState {}
class GetSuggestionDataLoad extends SuggestionState {}
class GetSuggestionDataSuccess extends SuggestionState {}
class GetSuggestionDataError extends SuggestionState {}


// add  post
class AddSuggestionDataLoad extends SuggestionState {}
class AddSuggestionDataSuccess extends SuggestionState {}
class AddSuggestionDataError extends SuggestionState {}