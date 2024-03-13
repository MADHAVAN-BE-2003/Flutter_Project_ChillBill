import 'dart:convert';

class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class logindata {
  final bool status;
  final String msg;

  const logindata({
    required this.status,
    required this.msg,
  });

  factory logindata.fromJson(Map<String, dynamic> json) {
    return logindata(
      status: json['valid'],
      msg: json['msg'],
    );
  }
}
