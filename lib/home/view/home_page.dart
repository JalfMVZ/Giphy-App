import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/home/cubit/home_cubit.dart';
import 'package:flutter_bloc_tutorial/home/view/favorite_page.dart';
import 'package:flutter_bloc_tutorial/home/view/nav_bar.dart';
import 'package:gif_repository/gif_repository.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'HomePage';

  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giphy App"),
        centerTitle: true,
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
      //* al seleccionar la pestaña de Favoritos, mostrar la página de Favoritos
      return const FavoritesPage();
    } else {
      return const SizedBox(); //? Otras pestañas, widget vacío
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
