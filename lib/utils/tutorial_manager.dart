import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/home/view/favorite_page.dart';
import 'package:flutter_bloc_tutorial/home/view/home_page.dart';

class TutorialManager {
  static bool _tutorialShown = false;

  static Future<void> showNavBarTutorial(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_tutorialShown) {
        _showFirstTutorialStep(context);
      }
    });
  }

  static void _showFirstTutorialStep(BuildContext context) {
    _tutorialShown = true;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tutorial de Giphy App'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Este es un tutorial introductorio sobre Giphy app',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el tutorial
              _navigateToSecondStep(context); // Navegar al segundo paso
            },
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }

  static void _navigateToSecondStep(BuildContext context) {
    Navigator.pushNamed(context, FavoritesPage.routeName);
    showSecondTutorialStep(context);
  }

  static Future<void> showSecondTutorialStep(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sección de Favoritos'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Aquí será donde se guarden tus gifs favoritos. Tendrás la posibilidad de compartirlos, descargarlos y verlos en pantalla completa desde aquí.',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el tutorial
              _navigateToThirdStep(context); // Navegar al tercer paso
            },
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }

  static void _navigateToThirdStep(BuildContext context) {
    Navigator.pushNamed(context, HomePage.routeName);
    showThirdTutorialStep(context);
  }

  static Future<void> showThirdTutorialStep(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Función de Likes'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'En cada gif tenemos un botón de "like" para que puedas guardarlo en tu lista de favoritos previamente mostrada.',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el tutorial
              _navigateToFourthStep(context); // Navegar al cuarto paso
            },
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }

  static void _navigateToFourthStep(BuildContext context) {
    Navigator.pushNamed(context, HomePage.routeName);
    showFourthTutorialStep(context);
  }

  static Future<void> showFourthTutorialStep(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Función de Dislikes'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'En cada gif tenemos un botón de "dislike" para que puedas guardarlo en tu lista de favoritos previamente mostrada.',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el tutorial
              _navigateToFifthStep(context); // Navegar al quinto paso
            },
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }

  static void _navigateToFifthStep(BuildContext context) {
    Navigator.pushNamed(context, HomePage.routeName);
    showFifthTutorialStep(context);
  }

  static Future<void> showFifthTutorialStep(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Final del Recorrido 😪'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '¡Felicidades! Has completado el recorrido del tutorial. Ahora estás listo para disfrutar de la aplicación Giphy 😉',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el tutorial
              _tutorialShown = false; // Reiniciar _tutorialShown a false
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
