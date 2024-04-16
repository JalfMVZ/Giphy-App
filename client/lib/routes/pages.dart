import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/home/view/favorite_page.dart';
import 'package:flutter_bloc_tutorial/home/view/home_page.dart';
import 'package:flutter_bloc_tutorial/pages/auth/login_page.dart';
import 'package:flutter_bloc_tutorial/pages/auth/register_page.dart';
import 'package:flutter_bloc_tutorial/routes/routes.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.HomePage: (_) => const HomePage(),
    Routes.Favorites: (_) => const FavoritesPage(),
    Routes.Login: (_) => const LoginPage(),
    Routes.Register: (_) => RegisterPage(),
  };
}
