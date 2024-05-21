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
