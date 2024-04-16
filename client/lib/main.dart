import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/Asistente/chat_screen.dart';
import 'package:flutter_bloc_tutorial/home/cubit/home_cubit.dart';
import 'package:flutter_bloc_tutorial/home/view/display_gift.dart';
import 'package:flutter_bloc_tutorial/home/view/favorite_page.dart';
import 'package:flutter_bloc_tutorial/home/view/userlist.dart';
import 'package:flutter_bloc_tutorial/local_notifications/local_notifications.dart';
import 'package:flutter_bloc_tutorial/preferences/pref_usuarios.dart';
import 'package:flutter_bloc_tutorial/home/view/home_page.dart';
import 'package:flutter_bloc_tutorial/pages/auth/login_page.dart';
import 'package:flutter_bloc_tutorial/pages/auth/register_page.dart';
import 'package:flutter_bloc_tutorial/services/bloc/notifications_bloc.dart';
import 'package:flutter_bloc_tutorial/utils/upload_gif.dart';
import 'package:gif_repository/gif_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenciesUsers.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await LocalNotification.initializeLocalNotifications();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => NotificationsBloc()),
  ], child: MyApp()));
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
            themeMode: ThemeMode.dark,
            initialRoute: prefs.ultimaPagina,
            routes: {
              LoginPage.routeName: (context) => const LoginPage(),
              RegisterPage.routeName: (context) => RegisterPage(),
              HomePage.routeName: (context) => const HomePage(),
              FavoritesPage.routeName: (context) => const FavoritesPage(),
              ChatScreen.routeName: (context) => const ChatScreen(),
              UploadGifForm.routeName: (context) => const UploadGifForm(),
              UserList.routeName: (context) => const UserList(),
              DisplayUploadedGifs.routeName: (context) =>
                  const DisplayUploadedGifs(),
            },
          ),
        ));
  }
}
