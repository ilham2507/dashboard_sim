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

    on<GetProyekById>((event, emit) async {
      emit(ProyekLoading());
      try {
        final user = await proyekServices.getProyekById(event.userId);
        emit(ProyekByIdLoaded(user));
      } catch (e) {
        emit(ProyekError(e.toString()));
      }
    });

    on<StoreProyek>((event, emit) async {
      emit(ProyekStoring());
      try {
        final Map<String, String> proyekData = event.proyekData
            .map((key, value) => MapEntry(key, value.toString()));
        await proyekServices.storeProyek(proyekData);
        emit(ProyekStored());
      } catch (e) {
        emit(ProyekError(e.toString()));
      }
    });

    on<UpdateProyekById>((event, emit) async {
      emit(ProyekLoading());
      try {
        final Map<String, String> proyekData = event.proyekData
            .map((key, value) => MapEntry(key, value.toString()));
        await proyekServices.updateProyekById(event.userId, proyekData);
        final updatedUser = await proyekServices.getProyekById(event.userId);
        emit(ProyekUpdated(updatedUser));
      } catch (e) {
        emit(ProyekError(e.toString()));
      }
    });

    on<DeleteProyekById>((event, emit) async {
      emit(ProyekLoading());
      try {
        await proyekServices.deleteProyekById(event.proyekId);
        emit(ProyekDeleted());
      } catch (e) {
        emit(ProyekError(e.toString()));
      }
    });
  }
}
