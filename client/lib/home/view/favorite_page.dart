// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/home/cubit/home_cubit.dart';
// import 'package:flutter_bloc_tutorial/utils/tutorial_manager.dart';
import 'package:gif_repository/gif_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class FavoritesPage extends StatelessWidget {
  static const String routeName = 'Favorites';

  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final favoriteGifs = homeCubit.favoriteGifs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.8,
          ),
          itemCount: favoriteGifs.length,
          itemBuilder: (context, index) {
            final gif = favoriteGifs[index];
            return GestureDetector(
              onTap: () {
                _showActionsPanel(context, gif);
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12.0),
                        ),
                        child: Image.network(
                          gif.url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showActionsPanel(BuildContext context, GifModel gif) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.fullscreen),
                title: const Text('Ver'),
                onTap: () {
                  _viewFullScreen(context, gif);
                },
              ),
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('Descargar'),
                onTap: () {
                  _downloadGif(context, gif);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Compartir'),
                onTap: () {
                  _shareGif(context, gif);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _downloadGif(BuildContext context, GifModel gif) async {
    try {
      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/$gif.gif');
      final request = await HttpClient().getUrl(Uri.parse(gif.url));
      final response = await request.close();
      await response.pipe(file.openWrite());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('GIF descargado'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al descargar el GIF'),
        ),
      );
    }
    Navigator.pop(context);
  }

  void _shareGif(BuildContext context, GifModel gif) async {
    try {
      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/$gif.gif');
      final request = await HttpClient().getUrl(Uri.parse(gif.url));
      final response = await request.close();
      final bytes = await response
          .fold<List<int>>([], (prev, elem) => prev..addAll(elem));
      await file.writeAsBytes(bytes);

      Share.shareFiles([file.path]);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al compartir el GIF'),
        ),
      );
    }
    Navigator.pop(context);
  }

  void _viewFullScreen(BuildContext context, GifModel gif) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Image.network(
              gif.url,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
