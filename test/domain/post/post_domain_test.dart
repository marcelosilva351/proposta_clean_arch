


import 'package:flutter_test/flutter_test.dart';
import 'package:proposta_clean_arch/domain/exceptions/post/post_post_exception.dart';
import 'package:proposta_clean_arch/domain/entities/post/post_entity.dart';
import 'package:proposta_clean_arch/domain/repositories/ipost_repository.dart';
import 'package:proposta_clean_arch/domain/use_cases/implementations/get_posts_use_case.dart';
import 'package:proposta_clean_arch/domain/use_cases/implementations/post_post_use_case.dart';
import 'package:proposta_clean_arch/domain/use_cases/interfaces/i_get_posts_use_case.dart';
import 'package:proposta_clean_arch/domain/use_cases/interfaces/i_post_post_use_case.dart';
import 'package:proposta_clean_arch/external/posts/post_data_source.dart';
import 'package:proposta_clean_arch/infra/repositories/post_repository.dart';

void main(){


  IPostPostUseCase postPostUseCase = PostPostUseCase(repoMock());
  IGetPostsUseCase getPostsUseCaseMock = GetPostsUseCase(repoMock());
  IGetPostsUseCase getPostsImpl = GetPostsUseCase(PostRepository(PostDataSource()));
  test("Check if title if empty", () async{
    var postEmpty;
    try {
      await postPostUseCase(Post(0, "", "body"));
    } 
    on PostPostException catch(e){
      postEmpty = e.message;
    }
    catch (e) {
      postEmpty = "Erro desconhecido"; 
    }


    expect(postEmpty, "O titulo não pode ser nulo");
  });


  test("post true", ()async {
    Post postToPost = Post(0, "title", "body");
    postToPost.id = 1;
    var result = await postPostUseCase(postToPost);
    expect(result, true);
  });


  test("post false", ()async {
    Post postToPost = Post(0, "title", "body");
    postToPost.id = 0;
    var result = await postPostUseCase(postToPost);
    expect(result, false);
  });


  group("get posts mock", (){
    test("Get posts from mock", ()async{ 
      var posts = await getPostsUseCaseMock();
      expect(posts[0].title, "Teste");

    });

  });


  group("get posts impl", (){
    test("Get posts from repo", () async{
      List<Post> posts = await getPostsImpl();
      expect(posts[0].id, 1);
    });
  });


}


class repoMock implements IPostRepository{
  @override
  Future<bool> postPost(Post postTopost) async{
    if(postTopost.id == 1){
      return true;
    }
    return false;
  }
  
  @override
  Future<List<Post>> getPostsFromDataSource() async {
    var listReturn = [Post(0, "Teste", "Teste")];
    return listReturn;
  }

}