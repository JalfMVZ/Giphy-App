import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

class CaptureScreenWidget extends StatefulWidget {
  const CaptureScreenWidget({super.key});

  @override
  _CaptureScreenWidgetState createState() => _CaptureScreenWidgetState();
}

class _CaptureScreenWidgetState extends State<CaptureScreenWidget> {
  GlobalKey previewContainer = GlobalKey();
  int originalSize = 800;

  // Datos JSON de ejemplo
  final String jsonData = '''
    [
      {"nombre": "Juan", "edad": 30},
      {"nombre": "María", "edad": 25},
      {"nombre": "Pedro", "edad": 40}
    ]
  ''';

  // Método para cargar y analizar el JSON
  List<Map<String, dynamic>> parseJsonData() {
    return List<Map<String, dynamic>>.from(json.decode(jsonData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RepaintBoundary(
                key: previewContainer,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey,
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('Edad')),
                    ],
                    rows: _buildTableRows(parseJsonData()),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _shareTableImage,
                child: const Text('Compartir Captura'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir las filas de la tabla
  List<DataRow> _buildTableRows(List<Map<String, dynamic>> data) {
    return data.map((item) {
      return DataRow(cells: [
        DataCell(Text(item['nombre'])),
        DataCell(Text(item['edad'].toString())),
      ]);
    }).toList();
  }

  void _shareTableImage() async {
    RenderRepaintBoundary boundary = previewContainer.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    ShareFilesAndScreenshotWidgets().shareFile(
      'Compartir Captura',
      'table_image.png',
      pngBytes,
      'image/png',
      text: 'Compartir esta captura',
    );
  }
}
