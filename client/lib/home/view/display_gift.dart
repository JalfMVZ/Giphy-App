import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DisplayUploadedGifs extends StatefulWidget {
  static const String routeName = 'DisplayGifs';

  const DisplayUploadedGifs({Key? key}) : super(key: key);

  @override
  _DisplayUploadedGifsState createState() => _DisplayUploadedGifsState();
}

class _DisplayUploadedGifsState extends State<DisplayUploadedGifs> {
  late List<File> _gifFiles;
  bool _areGifsLoaded = false;

  @override
  void initState() {
    super.initState();
    _gifFiles = [];
    _loadGifs();
  }

  Future<void> _loadGifs() async {
    setState(() {
      _areGifsLoaded = false;
    });

    final directory = await getApplicationDocumentsDirectory();
    final gifDirectory = Directory('${directory.path}/uploaded_gifs');

    if (await gifDirectory.exists()) {
      final files = gifDirectory.listSync().whereType<File>().toList();
      setState(() {
        _gifFiles = files;
        _areGifsLoaded = true;
      });
    }
  }

  Future<void> _deleteGif(int index) async {
    final deletedFile = _gifFiles.removeAt(index);
    await deletedFile.delete();
    setState(() {});
  }

  Future<void> _refreshGifs() async {
    setState(() {
      _areGifsLoaded = false;
      _gifFiles.clear();
    });
    await _loadGifs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GIFs Subidos'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshGifs,
        child: _areGifsLoaded
            ? _gifFiles.isEmpty
                ? const Center(child: Text('No hay GIFs subidos.'))
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      itemCount: _gifFiles.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Eliminar GIF'),
                                  content: const Text(
                                      '¿Estás seguro de que quieres eliminar este GIF?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _deleteGif(index);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Eliminar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              _gifFiles[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
