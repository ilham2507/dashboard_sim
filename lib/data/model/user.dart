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
  final Role role;

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
      role: Role.fromJson(json['role']),
    );
  }
}

class UserList {
  List<User>? _users;

  UserList({List<User>? users}) {
    if (users != null) {
      this._users = users;
    }
  }

  List<User>? get users => _users;
  set users(List<User>? users) => _users = users;

  UserList.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      _users = <User>[];
      json['users'].forEach((v) {
        _users!.add(new User.fromJson(v));
      });
    }
  }
}

class Role {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Role(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.updatedAt});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
