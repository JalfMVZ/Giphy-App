// ignore_for_file: avoid_print

import 'package:gif_services/gif_services.dart';

void main() async {
  final gifServices = GifServices();
  try {
    final urls = await gifServices.fetchGifs();
    for (final url in urls) {
      print(url);
    }
  } catch (e) {
    print('Error: $e');
  }
}
