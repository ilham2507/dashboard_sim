part of 'proyek_bloc.dart';

@immutable
sealed class ProyekState {}

final class ProyekInitial extends ProyekState {}

class ProyekLoading extends ProyekState {}

class ProyekLoaded extends ProyekState {
  final List<Proyek> proyeks;
  ProyekLoaded(this.proyeks);
}

class ProyekError extends ProyekState {
  final String error;
  ProyekError(this.error);
}

class ProyekByIdLoaded extends ProyekState {
  final Proyek proyek;
  final bool loadedById;
  ProyekByIdLoaded(this.proyek, {this.loadedById = true});
}

class ProyekStoring extends ProyekState {}

class ProyekStored extends ProyekState {}

class ProyekUpdated extends ProyekState {
  final Proyek proyek;

  ProyekUpdated(this.proyek);
}

class ProyekDeleted extends ProyekState {}
