// ignore_for_file: omit_local_variable_types, public_member_api_docs

import 'package:gif_repository/src/models/gif_model.dart';
import 'package:gif_services/gif_services.dart';

/// {@template gif_repository}
/// My new Flutter package
/// {@endtemplate}
class GifRepository {
  /// {@macro gif_repository}
  GifRepository({GifServices? gifServices})
      : _gifServices = gifServices ?? GifServices();

  final GifServices _gifServices;

  Future<List<GifModel>> getUrls() async {
    final List<GifModel> urls = [];
    try {
      final listUrls = await _gifServices.fetchGifs();
      for (final url in listUrls) {
        urls.add(GifModel(url));
      }
      return urls;
    } catch (_) {
      throw Exception();
    }
  }
}
