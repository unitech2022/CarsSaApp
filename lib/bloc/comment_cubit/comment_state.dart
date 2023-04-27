part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}


class GetCommentDataLoad extends CommentState {}
class GetCommentDataSuccess extends CommentState {}
class GetCommentDataError extends CommentState {}


// add  post
class AddCommentDataLoad extends CommentState {}
class AddCommentDataSuccess extends CommentState {}
class AddCommentDataError extends CommentState {}