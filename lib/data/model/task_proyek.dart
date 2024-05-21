import 'package:drawer/data/model/penerima_proyek.dart';
import 'package:drawer/data/model/user.dart';

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
  List<PenerimaProyek>? penerimaProyek;

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
    this.penerimaProyek,
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
      penerimaProyek: json['penerima_proyek'] != null
          ? (json['penerima_proyek'] as List)
              .map((v) => PenerimaProyek.fromJson(v))
              .toList()
          : [],
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
    if (penerimaProyek != null) {
      data['penerima_proyek'] = penerimaProyek!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
