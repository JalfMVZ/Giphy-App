import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:file_picker/file_picker.dart';

class UserList extends StatefulWidget {
  static const String routeName = 'UserList';

  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<dynamic> users = [];
  List<dynamic> filteredUsers = [];
  bool isLoading = true;
  String selectedFilter = 'Todos';
  List<String> filterOptions = ['Todos'];
  bool isAscending = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      setState(() {
        users = List.from(json.decode(response.body));
        filteredUsers = List.from(users);
        isLoading = false;
        Set<String> cities =
            Set.from(users.map((user) => user['address']['city']));
        filterOptions.addAll(cities);
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  void _applyFilter(String? filter) {
    setState(() {
      selectedFilter = filter ?? 'Todos';
      if (selectedFilter == 'Todos') {
        filteredUsers = List.from(users);
      } else {
        filteredUsers = users.where((user) {
          return user['address']['city']
              .toLowerCase()
              .contains(selectedFilter.toLowerCase());
        }).toList();
      }
    });
  }

  void _toggleSortingOrder() {
    setState(() {
      isAscending = !isAscending;
      filteredUsers.sort((a, b) {
        final aName = a['name'] as String;
        final bName = b['name'] as String;
        return isAscending ? aName.compareTo(bName) : bName.compareTo(aName);
      });
    });
  }

  void _searchUsers(String query) {
    List<dynamic> searchResults = users.where((user) {
      return user['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredUsers = searchResults;
    });
  }

  Future<void> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Table.fromTextArray(
            data: <List<String>>[
              <String>[
                'Nombre',
                'Correo Electrónico',
                'Ciudad',
                'Calle',
                'Teléfono'
              ],
              for (var user in filteredUsers)
                [
                  user['name'],
                  user['email'],
                  user['address']['city'],
                  user['address']['street'],
                  user['phone']
                ]
            ],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/user_list.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PDF generado exitosamente!'),
        duration: Duration(seconds: 2),
      ),
    );
    Printing.sharePdf(bytes: await pdf.save(), filename: 'user_list.pdf');
  }

  void _showUserDetailsPanel(BuildContext context, Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Detalles del Usuario',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailItem('Nombre', user['name']),
                _buildDetailItem('Ciudad', user['address']['city']),
                _buildDetailItem('Email', user['email']),
                _buildDetailItem('Calle', user['address']['street']),
                _buildDetailItem('Teléfono', user['phone']),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Mostrar Ubicación'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(String label, dynamic value) {
    Widget itemWidget;
    if (label == 'Coordenadas') {
      itemWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                'Latitud: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                value['lat'],
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Longitud: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                value['lng'],
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      );
    } else {
      itemWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const Divider(),
        ],
      );
    }
    return itemWidget;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          DropdownButton<String>(
            value: selectedFilter,
            onChanged: _applyFilter,
            items: filterOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          IconButton(
            icon: Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: _toggleSortingOrder,
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _generatePDF,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar por nombre',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchUsers,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(filteredUsers[index]['name']),
                  subtitle: Text(filteredUsers[index]['email']),
                  onTap: () {
                    _showUserDetailsPanel(context, filteredUsers[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
