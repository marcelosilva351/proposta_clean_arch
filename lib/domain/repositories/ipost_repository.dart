import 'package:proposta_clean_arch/domain/entities/post/post_entity.dart';

abstract class IPostRepository{
  Future<bool> postPost(Post postTopost);
  Future<List<Post>> getPostsFromDataSource();
}