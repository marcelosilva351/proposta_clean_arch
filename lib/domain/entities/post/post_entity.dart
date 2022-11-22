

class Post{
  int? id;
  int userId;
  String title;
  String body;
  Post(this.userId,this.title,this.body);


  bool checkTitle(){
    if(title == ""){
      return false;
    }
    return true;
  }

}