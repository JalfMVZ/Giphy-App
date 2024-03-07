import 'package:bloc/bloc.dart';
import 'package:gif_repository/gif_repository.dart';

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

      emit(state.copyWith(status: HomeStatus.succes, gift: gifs));
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }

  void toggleLike(int index) {
    final gif = state.gift[index];
    gif.isLiked = !gif.isLiked;
    final updatedGifts = List.of(state.gift)..[index] = gif;
    emit(state.copyWith(gift: updatedGifts));
  }
}
