// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UploadGifForm extends StatefulWidget {
  static const String routeName = 'UploadGifForm';

  const UploadGifForm({super.key});

  @override
  _UploadGifFormState createState() => _UploadGifFormState();
}

class _UploadGifFormState extends State<UploadGifForm> {
  final TextEditingController _gifNameController = TextEditingController();
  final TextEditingController _gifDescriptionController =
      TextEditingController();

  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir GIF'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Subir GIF',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _gifNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del GIF',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _gifDescriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción del GIF',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _selectImage,
                child: const Text('Seleccionar imagen'),
              ),
              const SizedBox(height: 10),
              if (_selectedFile != null) ...[
                Image.file(_selectedFile!),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _uploadGif,
                  child: const Text('Subir GIF'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadGif() async {
    try {
      if (_selectedFile == null) {
        throw Exception('No se ha seleccionado ningún archivo');
      }

      final directory = await getApplicationDocumentsDirectory();
      final gifDirectory = Directory('${directory.path}/uploaded_gifs');
      if (!await gifDirectory.exists()) {
        await gifDirectory.create(recursive: true);
      }

      // Generar un nombre de archivo único basado en el timestamp actual
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${gifDirectory.path}/uploaded_gif_$timestamp.gif';

      await _selectedFile!.copy(filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Archivo subido correctamente')),
      );

      setState(() {
        _selectedFile = null;
        _gifNameController.clear();
        _gifDescriptionController.clear();
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al subir el archivo: $error')),
      );
    }
  }
}
