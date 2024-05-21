import 'package:drawer/data/model/user.dart';

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

class TaskProyek {
  int? id;
  int? proyekId;
  int? userId;
  int? penerimaProyekId;
  String? tugas;
  String? catatan;
  String? pekerja;
  String? start;
  String? deadline;
  String? status;
  int? nilai;
  String? createdAt;
  String? updatedAt;
  User? user;

  TaskProyek({
    this.id,
    this.proyekId,
    this.userId,
    this.penerimaProyekId,
    this.tugas,
    this.catatan,
    this.pekerja,
    this.start,
    this.deadline,
    this.status,
    this.nilai,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory TaskProyek.fromJson(Map<String, dynamic> json) {
    return TaskProyek(
      id: json['id'],
      proyekId: json['proyek_id'],
      userId: json['user_id'],
      penerimaProyekId: json['penerimaProyek_id'],
      tugas: json['tugas'],
      catatan: json['catatan'],
      pekerja: json['pekerja'],
      start: json['start'],
      deadline: json['deadline'],
      status: json['status'],
      nilai: json['nilai'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['proyek_id'] = proyekId;
    data['user_id'] = userId;
    data['penerimaProyek_id'] = penerimaProyekId;
    data['tugas'] = tugas;
    data['catatan'] = catatan;
    data['pekerja'] = pekerja;
    data['start'] = start;
    data['deadline'] = deadline;
    data['status'] = status;
    data['nilai'] = nilai;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
