part of 'home_cubit.dart';

enum HomeStatus { loading, succes, error }

class HomeState {
  HomeState({
    this.status = HomeStatus.loading,
    this.gift = const <GifModel>[],
  });
  final HomeStatus status;
  final List<GifModel> gift;
  final List<GifModel> gifts = <GifModel>[];

  HomeState copyWith({
    HomeStatus? status,
    List<GifModel>? gift,
    required List<GifModel> favoriteGifs,
  }) {
    return HomeState(
      status: status ?? this.status,
      gift: gift ?? this.gift,
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