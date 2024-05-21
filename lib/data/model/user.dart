import 'package:drawer/data/model/role.dart';

class User {
  final int id;
  final String name;
  final String nip;
  final String email;
  final DateTime? emailVerifiedAt;
  final String username;
  final String jenisKelamin;
  final DateTime tanggalLahir;
  final String noTelp;
  final String alamat;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int roleId;
  final String? fotoProfile;
  final Role? role;

  User({
    required this.id,
    required this.name,
    required this.nip,
    required this.email,
    required this.emailVerifiedAt,
    required this.username,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.noTelp,
    required this.alamat,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.fotoProfile,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      nip: json['nip'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      username: json['username'],
      jenisKelamin: json['jenis_kelamin'],
      tanggalLahir: DateTime.parse(json['tanggal_lahir']),
      noTelp: json['no_telp'],
      alamat: json['alamat'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      roleId: json['role_id'],
      fotoProfile: json['foto_profile'],
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nip'] = nip;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt?.toIso8601String();
    data['username'] = username;
    data['jenis_kelamin'] = jenisKelamin;
    data['tanggal_lahir'] = tanggalLahir.toIso8601String();
    data['no_telp'] = noTelp;
    data['alamat'] = alamat;
    data['created_at'] = createdAt.toIso8601String();
    data['updated_at'] = updatedAt.toIso8601String();
    data['role_id'] = roleId;
    data['foto_profile'] = fotoProfile;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}
