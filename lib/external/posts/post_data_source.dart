

import 'dart:convert';

import 'package:proposta_clean_arch/domain/exceptions/post/post_post_exception.dart';
import 'package:proposta_clean_arch/infra/data_sources/ipost_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:proposta_clean_arch/infra/dtos/post_dto.dart';
class PostDataSource implements IPostDataSource{

  @override
  Future<bool> postPostOnDataBase(String postToJson)  async{
   var url = "https://jsonplaceholder.typicode.com/posts";  
   try {
    var response = await http.post(Uri.parse(url), body: postToJson, headers: { 'Content-type': 'application/json; charset=UTF-8',});
    if(response.statusCode == 201){
      return true;
    }
    return false;
     
   }on PostPostException catch (e) {
     throw PostPostException("Erro ao tentar postar post");
   }catch(e){
    throw Exception();
   }
  }
  
  @override
  Future<List<dynamic>> getPostsFromDataBase() async{
      var url = "https://jsonplaceholder.typicode.com/posts";  
   try {
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    throw PostPostException("Erro ao tentar postar post");
     
   }on PostPostException catch (e) {
     throw PostPostException("Erro ao tentar postar post");
   }catch(e){
    throw Exception();
   }
  }
  




}