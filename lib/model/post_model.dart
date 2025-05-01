class Post {
  String? name;
  String? img_url;
  String? caption;
  String? date;
  String? id;
  String? caption1;

  Post({this.name, this.img_url, this.caption, this.date,this.id,this.caption1});

  Post.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        img_url = json['img_url'],
        caption = json['caption'],
        date = json['date'],
        id = json['id'],
        caption1 = json['key'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'img_url': img_url,
    'caption': caption,
    'date': date,
    'id': id,
    'caption1': caption1,
  };
}