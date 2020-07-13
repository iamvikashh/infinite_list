import 'dart:async';
import 'package:infinite_list/data/repository.dart';

import './bloc.dart';
import 'package:bloc/bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  @override
  PostState get initialState => PostInitial();
  Repository repo=Repository();
  @override
  Stream<PostState> mapEventToState(PostEvent event,) async* {
    final currentState=state;
    if (event is  FetchPost && !_hasReachedMax(currentState) ) {
      try{
        if (currentState is PostInitial) {
          final posts=await _fetchPosts();
          yield PostSuccess(posts: posts,hasReachedMax: false);
        }
        if (currentState is PostSuccess) {
          final posts=await _fetchPosts();
          yield posts.isEmpty? currentState.CopyWith(hasReachedMax: true):
                PostSuccess(hasReachedMax: false,posts: currentState.posts+posts);
        }

      }
      catch(error){
        yield PostFailure();
      }
    }
  }

  bool _hasReachedMax(PostState state)=> state is PostSuccess && state.hasReachedMax;

  _fetchPosts()=> repo.getPosts();
}
