import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/Asistente/chat_screen.dart';
import 'package:flutter_bloc_tutorial/home/cubit/home_cubit.dart';
import 'package:flutter_bloc_tutorial/home/view/favorite_page.dart';
import 'package:flutter_bloc_tutorial/preferences/pref_usuarios.dart';
import 'package:flutter_bloc_tutorial/home/view/home_page.dart';
import 'package:flutter_bloc_tutorial/pages/auth/login_page.dart';
import 'package:flutter_bloc_tutorial/pages/auth/register_page.dart';
import 'package:gif_repository/gif_repository.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart'; // Asegúrate de importar flutter_dotenv
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();
  await PreferenciesUsers.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final prefs = PreferenciesUsers();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => GifRepository(),
        child: BlocProvider(
          create: (context) =>
              HomeCubit(context.read<GifRepository>())..getData(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.dark, // tema claro o oscuro
            initialRoute: prefs.ultimaPagina, // Set the initial route here
            routes: {
              LoginPage.routeName: (context) => const LoginPage(),
              RegisterPage.routeName: (context) => RegisterPage(),
              HomePage.routeName: (context) => const HomePage(),
              FavoritesPage.routeName: (context) => const FavoritesPage(),
              ChatScreen.routeName: (context) => const ChatScreen(),
            },
          ),
        ));
  }
}
