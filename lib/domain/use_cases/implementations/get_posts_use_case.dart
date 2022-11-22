



import 'package:proposta_clean_arch/domain/entities/post/post_entity.dart';
import 'package:proposta_clean_arch/domain/exceptions/post/get_posts_exception.dart';
import 'package:proposta_clean_arch/domain/repositories/ipost_repository.dart';
import 'package:proposta_clean_arch/domain/use_cases/interfaces/i_get_posts_use_case.dart';

class GetPostsUseCase implements IGetPostsUseCase{
  late IPostRepository _iPostRepository;
  GetPostsUseCase(IPostRepository postRepository){
    _iPostRepository = postRepository;
  }

  @override
  Future<List<Post>> call() async{
  try {
    return _iPostRepository.getPostsFromDataSource();
  }on GetPostsException catch (e) {
    throw GetPostsException(e.message);
  }catch(e){
    throw Exception();
  }
  }

  
}