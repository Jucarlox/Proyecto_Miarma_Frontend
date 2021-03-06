import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/profile_bloc/profile_bloc.dart';
import 'package:flutter_miarmapp/models/Profile.dart';
import 'package:flutter_miarmapp/repository/post_repository/constants.dart';

import 'package:flutter_miarmapp/repository/profile.repository/profile_repository.dart';
import 'package:flutter_miarmapp/repository/profile.repository/profile_repository_impl.dart';

import 'package:flutter_miarmapp/ui/widgets/error_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileRepository userRepository;

  @override
  void initState() {
    // TODO: implement initState
    userRepository = ProfileRepositoryImpl();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProfileBloc(userRepository)
          ..add(FetchProfileWithType(Constant.nowPlaying));
      },
      child: Scaffold(body: _createPublics(context)),
    );
  }
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
        return _profile(context, state.public);
      } else {
        return const Text('Not support');
      }
    },
  );
}

Widget _profile(BuildContext context, VisualizarPerfilResponse user) {
  return SafeArea(
    child: Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(user.avatar
                            .toString()
                            .replaceFirst('localhost', '10.0.2.2'))),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            TextButton(
                              onPressed: null,
                              child: Text(
                                user.postList.length.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Text("posts"),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                /*Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FollowPage()));*/
                              },
                              child: Text(
                                "0",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Text(
                              "followers",
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  /*Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FollowPage()));*/
                                },
                                child: Text("0",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                            Text("following"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(user.nick.toString()),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    user.nick,
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
            Container(
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                width: 320,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.black),
                    )))

            /* Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 120.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        onPressed: () {},
                        child: const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),*/
          ],
        ),
        const Divider(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.table_chart_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.person_search)),
          ],
        ),
        const SizedBox(
          width: 20,
        ),

        /*Image(  image: NetworkImage(user.publicaciones.elementAt(0).file.toString().replaceFirst('localhost', '10.0.2.2')),
                        
                        ),*/
        Flexible(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: user.postList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: Colors.white,
                    child: Image(
                      image: NetworkImage(user.postList
                          .elementAt(index)
                          .fileScale
                          .toString()
                          .replaceFirst('localhost', '10.0.2.2')),
                      fit: BoxFit.cover,
                    ));
              }),
        ),
        /*Container(
                width: 120,
                height: 150,
                child: Image(
                  image: AssetImage('assets/images/luismi.png'),
                  fit: BoxFit.contain,
                )),*/
        const SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}
