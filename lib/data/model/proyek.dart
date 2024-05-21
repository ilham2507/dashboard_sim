import 'task_proyek.dart';

class Proyek {
  int? id;
  int? userId;
  String? nama;
  String? detail;
  String? manager;
  String? file;
  String? start;
  String? finish;
  int? nilai;
  String? klien;
  String? createdAt;
  String? updatedAt;
  List<TaskProyek>? taskProyek;

  Proyek({
    this.id,
    this.userId,
    this.nama,
    this.detail,
    this.manager,
    this.file,
    this.start,
    this.finish,
    this.nilai,
    this.klien,
    this.createdAt,
    this.updatedAt,
    this.taskProyek,
  });

  factory Proyek.fromJson(Map<String, dynamic> json) {
    return Proyek(
      id: json['id'],
      userId: json['user_id'],
      nama: json['nama'],
      detail: json['detail'],
      manager: json['manager'],
      file: json['file'],
      start: json['start'],
      finish: json['finish'],
      nilai: json['nilai'],
      klien: json['klien'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      taskProyek: json['task_proyek'] != null
          ? (json['task_proyek'] as List)
              .map((v) => TaskProyek.fromJson(v))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['nama'] = nama;
    data['detail'] = detail;
    data['manager'] = manager;
    data['file'] = file;
    data['start'] = start;
    data['finish'] = finish;
    data['nilai'] = nilai;
    data['klien'] = klien;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (taskProyek != null) {
      data['task_proyek'] = taskProyek!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
