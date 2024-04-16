import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/home/cubit/home_cubit.dart';
import 'package:flutter_bloc_tutorial/home/view/display_gift.dart';
import 'package:flutter_bloc_tutorial/home/view/favorite_page.dart';
import 'package:flutter_bloc_tutorial/home/view/nav_bar.dart';
import 'package:flutter_bloc_tutorial/home/view/userlist.dart';
import 'package:flutter_bloc_tutorial/preferences/pref_usuarios.dart';
import 'package:flutter_bloc_tutorial/services/bloc/notifications_bloc.dart';
import 'package:flutter_bloc_tutorial/utils/capturescreen.dart';
import 'package:flutter_bloc_tutorial/utils/not.dart';
import 'package:flutter_bloc_tutorial/utils/tutorial_manager.dart';
import 'package:flutter_bloc_tutorial/utils/upload_gif.dart';
import 'package:gif_repository/gif_repository.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'HomePage';

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    // TutorialManager.showNavBarTutorial(context);
  }

  @override
  Widget build(BuildContext context) {
    context.read<NotificationsBloc>().requestPermission();
    var prefs = PreferenciesUsers();
    print('TOKEN: ' + prefs.token);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giphy App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: () {
              Navigator.pushNamed(context, UploadGifForm.routeName);
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            HomeCubit(context.read<GifRepository>())..getData(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return _buildBody(state);
          },
        ),
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            if (_currentIndex != index) {
              _currentIndex = index;
            }
          });
        },
      ),
    );
  }

  Widget _buildBody(HomeState state) {
    if (_currentIndex == 0) {
      return const HomeView();
    } else if (_currentIndex == 1) {
      return const FavoritesPage();
    } else if (_currentIndex == 2) {
      return const DisplayUploadedGifs();
    } else if (_currentIndex == 3) {
      return const UserList();
    } else if (_currentIndex == 4) {
      return const ContadorPage();
    } else {
      return const SizedBox();
    }
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case HomeStatus.succes:
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              itemCount: state.gift.length,
              itemBuilder: (context, index) {
                final gif = state.gift[index];
                return GestureDetector(
                  onTap: () {
                    context.read<HomeCubit>().toggleLike(index);
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          gif.url,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: IconButton(
                          icon: Icon(
                            gif.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: gif.isLiked ? Colors.red : Colors.white,
                          ),
                          onPressed: () {
                            context.read<HomeCubit>().toggleLike(index);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          case HomeStatus.error:
            return const Center(child: Text("Error"));
          default:
            return Container();
        }
      },
    );
  }
}
