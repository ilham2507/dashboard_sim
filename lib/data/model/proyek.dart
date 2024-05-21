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

  Proyek(
      {this.id,
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
      this.updatedAt});

  Proyek.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    nama = json['nama'];
    detail = json['detail'];
    manager = json['manager'];
    file = json['file'];
    start = json['start'];
    finish = json['finish'];
    nilai = json['nilai'];
    klien = json['klien'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['nama'] = this.nama;
    data['detail'] = this.detail;
    data['manager'] = this.manager;
    data['file'] = this.file;
    data['start'] = this.start;
    data['finish'] = this.finish;
    data['nilai'] = this.nilai;
    data['klien'] = this.klien;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProyekList {
  List<Proyek>? proyek;

  ProyekList({this.proyek});

  ProyekList.fromJson(Map<String, dynamic> json) {
    if (json['proyek'] != null) {
      proyek = <Proyek>[];
      json['proyek'].forEach((v) {
        proyek!.add(new Proyek.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.proyek != null) {
      data['proyek'] = this.proyek!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
