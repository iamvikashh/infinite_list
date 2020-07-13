import 'package:equatable/equatable.dart';
import 'package:infinite_list/data_model/post_dm.dart';

abstract class PostState extends Equatable {
  const PostState();
}
class PostInitial extends PostState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PostFailure extends PostState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PostSuccess extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  const PostSuccess({this.posts, this.hasReachedMax});

  PostSuccess CopyWith({List<Post> posts, bool hasReachedMax}) {
    return PostSuccess(posts: posts ?? this.posts,hasReachedMax: hasReachedMax??this.hasReachedMax);
  }


  @override
  String toString() {
    return 'PostSuccess{posts: $posts, hasReachedMax: $hasReachedMax}';
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
