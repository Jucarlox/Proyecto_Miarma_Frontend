import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/profile_bloc/profile_bloc.dart';
import 'package:flutter_miarmapp/models/Profile.dart';
import 'package:flutter_miarmapp/repository/post_repository/constants.dart';
import 'package:flutter_miarmapp/repository/profile.repository/profile_repository.dart';
import 'package:flutter_miarmapp/repository/profile.repository/profile_repository_impl.dart';
import 'package:flutter_miarmapp/screens/home_screen.dart';
import 'package:flutter_miarmapp/screens/profile_screen.dart';
import 'package:flutter_miarmapp/screens/search_screen.dart';
import 'package:flutter_miarmapp/ui/widgets/error_page.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen()
  ];

  late ProfileRepository userRepository;

  @override
  void initState() {
    // TODO: implement initState
    userRepository = ProfileRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProfileBloc(userRepository)
          ..add(FetchProfileWithType(Constant.nowPlaying));
      },
      child: Scaffold(
          body: pages[_currentIndex],
          bottomNavigationBar: _createPublics(context)),
    );
  }

  Widget _buildBottomBar(
      BuildContext context, VisualizarPerfilResponse perfilResponse) {
    return Container(
        decoration: BoxDecoration(
            border: const Border(
          top: BorderSide(
            color: Color(0xfff1f1f1),
            width: 1.0,
          ),
        )),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Icon(Icons.home,
                  color: _currentIndex == 0
                      ? Colors.black
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            GestureDetector(
              child: Icon(Icons.search,
                  color: _currentIndex == 1
                      ? Colors.black
                      : const Color(0xff999999)),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: _currentIndex == 2
                              ? Colors.black
                              : Colors.transparent,
                          width: 1),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(perfilResponse.avatar
                              .toString()
                              .replaceFirst('localhost', '10.0.2.2')))),
                ))
          ],
        ));
  }

  Widget _createPublics(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context
                  .watch<ProfileBloc>()
                  .add(FetchProfileWithType(Constant.nowPlaying));
            },
          );
        } else if (state is ProfileFetched) {
          return _buildBottomBar(context, state.public);
        } else {
          return const Text('Not support');
        }
      },
    );
  }
}
