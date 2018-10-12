class ImageModel{
  String id;
  String url;
  String title;

  ImageModel({this.id, this.url, this.title});

factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['idTeam'] as String,
      url: json['strTeamBadge'] as String,
      title: json['strTeam'] as String,
  
    );
  
  }

  @override
    String toString() {
      // TODO: implement toString
      return 'id : $id, url : $url, title : $title';
    }

}