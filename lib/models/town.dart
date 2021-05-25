class Town{
  final int id;
  final int townNo;
  final String townName;
  final String mobileNo;

  Town(this.id,this.townName,this.townNo,this.mobileNo);

  factory Town.fromMap(Map<String, dynamic> json){
    return Town(json['id'], json['townNo'],json['townName'],json['mobileNo']);
  }

  factory Town.fromJson(Map<String, dynamic> json){
    return Town(json['id'], json['townNo'],json['townName'],json['mobileNo']);
  }
}