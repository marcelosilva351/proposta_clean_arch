


import 'dart:convert';

import 'package:proposta_clean_arch/domain/entities/post/post_entity.dart';

class PostDto extends Post{
  PostDto(super.userId, super.title, super.body);


 String toJson(){
    return json.encode({
      "userId" : userId, 
      "title" : title,
      "body" : body
    });
  } 

  static Post fromJson(Map<String,dynamic> json){
    var postFromJson =  Post(json["userId"], json["title"], json["body"]);
    postFromJson.id = json["id"];
    return postFromJson;
  }

}