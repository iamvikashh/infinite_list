import 'package:infinite_list/data_model/post_dm.dart';

import 'data_provider.dart';

class Repository{
  DataProvider dataProvider=DataProvider();
  List<Post> post;
  Future getPosts() async {
  post = await dataProvider.rawPost();
  return post;
  }
}