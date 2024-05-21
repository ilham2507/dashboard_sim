import 'package:bloc/bloc.dart';
import 'package:drawer/data/model/proyek.dart';
import 'package:drawer/data/services/proyek/proyek_service.dart';
import 'package:meta/meta.dart';

part 'proyek_event.dart';
part 'proyek_state.dart';

class ProyekBloc extends Bloc<ProyekEvent, ProyekState> {
  final ProyekServices proyekServices;

  ProyekBloc({required this.proyekServices}) : super(ProyekInitial()) {
    on<LoadProyek>((event, emit) async {
      emit(ProyekLoading());
      try {
        final res = await proyekServices.getProyek();
        emit(ProyekLoaded(res));
      } catch (e) {
        emit(ProyekError(e.toString()));
      }
    });
  }
}
