part of 'home_cubit.dart';

enum HomeStatus { loading, succes, error }

class HomeState {
  final HomeStatus status;
  final List<GifModel> gift;
  final List<File>? uploadedGifs;

  HomeState({
    this.status = HomeStatus.loading,
    this.gift = const <GifModel>[],
    this.uploadedGifs,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<GifModel>? gift,
    required List<GifModel> favoriteGifs,
    List<File>? uploadedGifs,
  }) {
    return HomeState(
      status: status ?? this.status,
      gift: gift ?? this.gift,
      uploadedGifs: uploadedGifs ?? this.uploadedGifs,
    );
  }
}




/* 
fecth
cuando carga, exito, error
- Servicio se conecta a la Api > 
- Repositorio usa el servicio
- Cubit usa el repositorio
*/