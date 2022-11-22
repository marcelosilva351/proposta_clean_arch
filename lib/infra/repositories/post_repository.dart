import 'dart:ffi';

import 'package:proposta_clean_arch/domain/entities/post/post_entity.dart';
import 'package:proposta_clean_arch/domain/exceptions/post/post_post_exception.dart';
import 'package:proposta_clean_arch/domain/repositories/ipost_repository.dart';
import 'package:proposta_clean_arch/infra/data_sources/ipost_data_source.dart';
import 'package:proposta_clean_arch/infra/dtos/post_dto.dart';

class PostRepository implements IPostRepository{
  late IPostDataSource _postDataSource;
  PostRepository(IPostDataSource postDataSource){
    _postDataSource = postDataSource;
  }
  @override
  Future<bool> postPost(Post postTopost) async {
    var postToPostDto = PostDto(postTopost.userId, postTopost.title, postTopost.body);
    try {
      return _postDataSource.postPostOnDataBase(postToPostDto.toJson());
    } on PostPostException catch (e) {
      throw PostPostException(e.message);
    }catch(e){
      throw Exception("Erro desconhecido");
    }
  }
  
  @override
  Future<List<Post>> getPostsFromDataSource() async{
    List<Post> postsReturn = [];
    var postsFromDataBase = await _postDataSource.getPostsFromDataBase();
    for(var post in postsFromDataBase){
      var postAdd = PostDto.fromJson(post);
      postsReturn.add(postAdd);
    }
    return postsReturn;
  }
  
}