import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gif_repository/gif_repository.dart';
import 'package:path_provider/path_provider.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.gifRepository) : super(HomeState());

  final GifRepository gifRepository;

  List<GifModel> get favoriteGifs =>
      state.gift.where((gif) => gif.isLiked).toList();

  Future<void> getData() async {
    try {
      final gifUrls = await gifRepository.getUrls();
      final gifs = gifUrls.map((gif) => GifModel(gif.url)).toList();

      emit(state
          .copyWith(status: HomeStatus.succes, gift: gifs, favoriteGifs: []));
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.error, favoriteGifs: []));
    }
  }

  void toggleLike(int index) {
    final gif = state.gift[index];
    gif.isLiked = !gif.isLiked;
    final updatedGifts = List.of(state.gift)..[index] = gif;
    emit(state.copyWith(gift: updatedGifts, favoriteGifs: []));
  }

  Future<void> uploadGif() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        // Obtener el directorio de documentos en el dispositivo
        final directory = await getApplicationDocumentsDirectory();
        // Construir la ruta del archivo donde se guardará
        final filePath = '${directory.path}/uploaded_gifs/uploaded_gif.gif';
        // Copiar el archivo seleccionado al directorio de documentos
        await file.copy(filePath);
        // Puedes imprimir la ruta del archivo para verificar que se haya guardado correctamente
        print('Archivo guardado en: $filePath');
        // Notificar que la carga ha sido exitosa
        emit(state.copyWith(status: HomeStatus.succes, favoriteGifs: []));
      }
    } catch (error) {
      // Manejar cualquier error que pueda ocurrir durante la selección de la imagen o el video
      emit(state.copyWith(status: HomeStatus.error, favoriteGifs: []));
    }
  }

  Future<void> deleteUploadedGif(File gifFile) async {
    try {
      if (state.uploadedGifs != null) {
        final updatedGifs = List<File>.from(state.uploadedGifs!)
          ..remove(gifFile);
        emit(state.copyWith(uploadedGifs: updatedGifs, favoriteGifs: []));
        await gifFile.delete();
      }
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.error, favoriteGifs: []));
    }
  }
}
