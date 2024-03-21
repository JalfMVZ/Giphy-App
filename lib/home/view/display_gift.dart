import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/home/cubit/home_cubit.dart';
import 'package:path_provider/path_provider.dart';

class DisplayUploadedGifs extends StatefulWidget {
  static const String routeName = 'DisplayGifs';

  const DisplayUploadedGifs({super.key});

  @override
  _DisplayUploadedGifsState createState() => _DisplayUploadedGifsState();
}

class _DisplayUploadedGifsState extends State<DisplayUploadedGifs> {
  late List<File> _gifFiles;
  String _selectedFilter = 'Fecha de Subida';

  @override
  void initState() {
    super.initState();
    _gifFiles = [];
    _loadGifs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadGifs();
  }

  Future<void> _loadGifs() async {
    final directory = await getApplicationDocumentsDirectory();
    final gifDirectory = Directory('${directory.path}/uploaded_gifs');

    if (await gifDirectory.exists()) {
      final files = gifDirectory.listSync().whereType<File>().toList();
      setState(() {
        _gifFiles = files;
      });
    }
  }

  void _deleteGif(int index) {
    context.read<HomeCubit>().deleteUploadedGif(_gifFiles[index]);
    setState(() {
      _gifFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GIFs Subidos'),
        actions: [
          DropdownButton<String>(
            value: _selectedFilter,
            onChanged: (String? newValue) {
              setState(() {
                _selectedFilter = newValue!;
              });
            },
            items: <String>[
              'Fecha de Subida',
              'Tamaño',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: _gifFiles.isEmpty
          ? const Center(child: Text('No hay GIFs subidos.'))
          : GridView.builder(
              itemCount: _gifFiles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              onPressed: () => Navigator.of(context).pop(),
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
    );
  }
}
