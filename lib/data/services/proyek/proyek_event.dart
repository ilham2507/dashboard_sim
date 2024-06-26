part of 'proyek_bloc.dart';

@immutable
sealed class ProyekEvent {}

class LoadProyek extends ProyekEvent {}

class LoadRecentProyek extends ProyekEvent {}

class GetProyekById extends ProyekEvent {
  final String userId;

  GetProyekById({required this.userId});
}

class StoreProyek extends ProyekEvent {
  final Map<String, dynamic> proyekData;

  StoreProyek({required this.proyekData});
}

class UpdateProyekById extends ProyekEvent {
  final Map<String, dynamic> proyekData;
  final String userId;

  UpdateProyekById({
    required this.userId,
    required this.proyekData,
  });
}

class DeleteProyekById extends ProyekEvent {
  final String proyekId;

  DeleteProyekById({required this.proyekId});
}

class GetProyekCounts extends ProyekEvent {}

class GetProjectData extends ProyekEvent {}
