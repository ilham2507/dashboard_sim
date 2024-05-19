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
  final String fotoProfile;
  final String token;

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
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['data']['id'],
      name: json['data']['name'],
      nip: json['data']['nip'],
      email: json['data']['email'],
      emailVerifiedAt: json['data']['email_verified_at'] != null
          ? DateTime.parse(json['data']['email_verified_at'])
          : null,
      username: json['data']['username'],
      jenisKelamin: json['data']['jenis_kelamin'],
      tanggalLahir: DateTime.parse(json['data']['tanggal_lahir']),
      noTelp: json['data']['no_telp'],
      alamat: json['data']['alamat'],
      createdAt: DateTime.parse(json['data']['created_at']),
      updatedAt: DateTime.parse(json['data']['updated_at']),
      roleId: json['data']['role_id'],
      fotoProfile: json['data']['foto_profile'],
      token: json['token'],
    );
  }
}
