// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/pages/auth/login_page.dart';
import 'package:flutter_bloc_tutorial/utils/auth.dart';

class SingOut extends StatefulWidget {
  const SingOut({super.key});

  @override
  _SingOut createState() => _SingOut();
}

class _SingOut extends State<SingOut> {
  // En la función _showProfileMenu de ProfileMenu
  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.black.withOpacity(0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Cerrar sesión'),
                  onTap: () async {
                    Navigator.pop(context);
                    await AuthService().signOut();
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed(LoginPage.routeName);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.exit_to_app, size: 28),
      onPressed: () {
        _showProfileMenu(context);
      },
    );
  }
}
