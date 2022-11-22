



import 'package:proposta_clean_arch/domain/exceptions/post/post_post_exception.dart';
import 'package:proposta_clean_arch/domain/entities/post/post_entity.dart';
import 'package:proposta_clean_arch/domain/repositories/ipost_repository.dart';
import 'package:proposta_clean_arch/domain/use_cases/interfaces/i_post_post_use_case.dart';

class PostPostUseCase implements IPostPostUseCase{
  late IPostRepository _postRepository;
  PostPostUseCase(IPostRepository postRepository){
    _postRepository = postRepository;
  }
  @override
  Future<bool> call(Post postTopost) async{
    if(!postTopost.checkTitle()){
      throw PostPostException("O titulo não pode ser nulo");
    }
    return _postRepository.postPost(postTopost);
  }
  
}