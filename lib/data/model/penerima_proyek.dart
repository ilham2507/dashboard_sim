import 'package:drawer/data/model/user.dart';

class PenerimaProyek {
  int? id;
  int? userId;
  int? taskProyekId;
  String? createdAt;
  String? updatedAt;
  User? user;

  PenerimaProyek({
    this.id,
    this.userId,
    this.taskProyekId,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory PenerimaProyek.fromJson(Map<String, dynamic> json) {
    return PenerimaProyek(
      id: json['id'],
      userId: json['user_id'],
      taskProyekId: json['task_proyek_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['task_proyek_id'] = taskProyekId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
