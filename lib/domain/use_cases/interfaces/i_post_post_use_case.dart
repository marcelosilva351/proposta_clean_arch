



import 'package:proposta_clean_arch/domain/entities/post/post_entity.dart';

abstract class IPostPostUseCase{
  Future<bool> call(Post postTopost);
}