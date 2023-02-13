
class Music {
  String id;
  String image;
  String path;
  String name;
  String title;
  String length;

  Music.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        image = map["image"],
        path = map["path"],
        name = map["name"],
        title = map["title"],
        length = map["length"];

  Music.fromSnapshot(data) : this.fromMap(data as Map<String, dynamic>);

}