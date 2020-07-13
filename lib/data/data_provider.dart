import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:infinite_list/data_model/post_dm.dart';
class DataProvider{
  final httpClient=http.Client();
  Future rawPost() async {
    final response=await callApi();
    return response;
  }

  callApi() async{
    var result=await httpClient.get('https://jsonplaceholder.typicode.com/posts?_start=0&_limit=100');
    if(result.statusCode==200) {
      final data = jsonDecode(result.body) as List;
      return data.map((rawData) {
        print(rawData);
        return Post(
          id: rawData['id'],
          body: rawData['body'],
          title: rawData['title'],
        );
      }).toList();
    }
    else{
      throw Exception('error fetching posts');
    }
  }
}