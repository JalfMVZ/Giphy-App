import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/utils/sing_out.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const NavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, color: Colors.white),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_album, color: Colors.white),
          label: 'Mis GIFs',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white), label: 'Perfil'),
        BottomNavigationBarItem(
            icon: Icon(Icons.photo, color: Colors.white), label: 'Prueba'),
        BottomNavigationBarItem(
          icon: SingOut(),
          label: '',
        ),
      ],
    );
  }
}
