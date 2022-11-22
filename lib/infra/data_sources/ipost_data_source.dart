


import 'package:proposta_clean_arch/domain/entities/post/post_entity.dart';
import 'package:proposta_clean_arch/infra/dtos/post_dto.dart';

abstract class IPostDataSource{
  Future<bool> postPostOnDataBase(String postToJson);
  Future<List<dynamic>> getPostsFromDataBase();
}