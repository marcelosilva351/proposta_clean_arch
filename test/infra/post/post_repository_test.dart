


import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:proposta_clean_arch/domain/entities/post/post_entity.dart';
import 'package:proposta_clean_arch/domain/exceptions/post/post_post_exception.dart';
import 'package:proposta_clean_arch/domain/repositories/ipost_repository.dart';
import 'package:proposta_clean_arch/external/posts/post_data_source.dart';
import 'package:proposta_clean_arch/infra/data_sources/ipost_data_source.dart';
import 'package:proposta_clean_arch/infra/repositories/post_repository.dart';

void main(){

  IPostRepository postRepositoryMock = PostRepository(DataSourceMock());


  IPostRepository postRepository = PostRepository(PostDataSource());

  test("Post with mock", () async {
    var result = await postRepositoryMock.postPost(Post(1, "oi", "body"));
    expect(result, true);
  });

  test("post repository impl", () async{
    try {
      var result = await postRepository.postPost(Post(0, "Marcelo", "teste"));
      expect(result, true);
    } on PostPostException catch  (e) {
      print("Erro ao tentar postar");
    }catch (e){
      print("Erro desconhecido");
    }
  });

  group("get posts mock", (){

    test("get posts data source moce", () async{
    List<Post> posts = await postRepositoryMock.getPostsFromDataSource();
    expect(posts[0].title, "teste");
    });

  });

  group("get posts implementation", () {

    test("Get posts dataSource", () async{
    List<Post> posts = await postRepository.getPostsFromDataSource();
    expect(posts.isEmpty, false);
    });


  });

}


class DataSourceMock implements IPostDataSource{
  @override
  Future<bool> postPostOnDataBase(String postToJson) async {
    return true;
  }
  
  @override
  Future<List<dynamic>> getPostsFromDataBase() async{
   String posts = '[{"userId": 1, "id": 1,  "title": "teste","body": "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto"}]';
   var decode = jsonDecode(posts);
   return decode;
  }

}