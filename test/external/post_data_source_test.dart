

import 'package:flutter_test/flutter_test.dart';
import 'package:proposta_clean_arch/external/posts/post_data_source.dart';

void main(){
  var dataSource = PostDataSource();
  test("get posts from api", () async{
    var decode = await dataSource.getPostsFromDataBase();
    expect(decode.isEmpty, false);
  });
}