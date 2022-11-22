

import 'dart:io';

import 'package:proposta_clean_arch/domain/entities/post/post_entity.dart';
import 'package:proposta_clean_arch/domain/exceptions/post/get_posts_exception.dart';
import 'package:proposta_clean_arch/domain/exceptions/post/post_post_exception.dart';
import 'package:proposta_clean_arch/domain/repositories/ipost_repository.dart';
import 'package:proposta_clean_arch/domain/use_cases/implementations/get_posts_use_case.dart';
import 'package:proposta_clean_arch/domain/use_cases/implementations/post_post_use_case.dart';
import 'package:proposta_clean_arch/domain/use_cases/interfaces/i_get_posts_use_case.dart';
import 'package:proposta_clean_arch/domain/use_cases/interfaces/i_post_post_use_case.dart';
import 'package:proposta_clean_arch/external/posts/post_data_source.dart';
import 'package:proposta_clean_arch/infra/repositories/post_repository.dart';

void main() async{  
  IPostRepository postRepository = PostRepository(PostDataSource());
  bool compileProgram = true;
  while(compileProgram){
    print("Digite 1 para Postar");
    print("Digite 2 para obter todos os posts");
    print("Digite 3 para sair");

    String userChoice = stdin.readLineSync()!;
    switch(userChoice){
      case "1":
      await postPost(postRepository);
      break;
      case "2":
      await getPost(postRepository);
      break;
      case "3":
      compileProgram = false;
      break;
    }
  }
}

//get posts 
getPost(IPostRepository postRepository) async {
  IGetPostsUseCase useCaseGetPosts = GetPostsUseCase(postRepository);
  try {
    List<Post> posts =await useCaseGetPosts();
    for(var post in posts){
      print("USER ID: ${post.userId}");
      print("TITULO: ${post.title}");
      print("CONTEUDO: ${post.body}");

    }
  }on GetPostsException catch (e) {
    print(e.message);
  }catch(e){
    print("Erro desconhecido");
  }
}

//Post a post
postPost(IPostRepository postRepository)async{
  var postPostUseCase = PostPostUseCase(postRepository);
  try {
    bool resultPost = await postPostUseCase(getPostToPost());
    if(resultPost){
      print("------------------");
      print("POSTADO COM SUCESSO!");
    }else{
      print("Não foi possivel postar");
    }
    print("-----------------");
  }on PostPostException catch (e) {
    print(e.message);
  }catch(e){
    print("Erro desconhecido");
  }
}
Post getPostToPost(){

  print("Digite o id do usuario");
  int userId = int.parse(stdin.readLineSync()!);
  print("Digite o titulo da postagem");
  String title = stdin.readLineSync()!;
  print("Digite o conteudo da postagem");
  String body = stdin.readLineSync()!;
  var postToPost = Post(userId, title, body);
  return postToPost;
}