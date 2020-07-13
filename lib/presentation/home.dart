
import 'package:flutter/material.dart';
import 'package:infinite_list/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list/bloc/post_event.dart';
import 'package:infinite_list/bloc/post_state.dart';
import 'package:infinite_list/data_model/post_dm.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController scrollController=ScrollController();
  final scrollThreshold=200;
  PostBloc postBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_onScroll);
    postBloc=BlocProvider.of<PostBloc>(context)..add(FetchPost());
  }
  void _onScroll(){
    final maxScroll=scrollController.position.maxScrollExtent;
    final currentScroll=scrollController.position.pixels;
    if (maxScroll-currentScroll<=scrollThreshold) {
    postBloc.add(FetchPost());
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is PostInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PostFailure) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is PostSuccess) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.posts.length
                  ? BottomLoader()
                  : PostWidget(post: state.posts[index]);
            },
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
            controller: scrollController,
          );
        }
      },
    );
  }
}
class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${post.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}