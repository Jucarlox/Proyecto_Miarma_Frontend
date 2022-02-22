import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_miarmapp/bloc/post_bloc/post_bloc.dart';
import 'package:flutter_miarmapp/models/PublicPost.dart';
import 'package:flutter_miarmapp/repository/post_repository/constants.dart';
import 'package:flutter_miarmapp/repository/post_repository/movie_repository.dart';
import 'package:flutter_miarmapp/repository/post_repository/movie_repository_impl.dart';
import 'package:flutter_miarmapp/ui/widgets/error_page.dart';
import 'package:flutter_miarmapp/ui/widgets/error_page.dart';
import 'package:flutter_miarmapp/widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostRepository postRepository;

  @override
  void initState() {
    super.initState();
    postRepository = PostRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PostBloc(postRepository)
          ..add(FetchPostWithType(Constant.popular));
      },
      child: Scaffold(body: _createPopular(context)),
    );
  }

  Widget story(String image, name) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(0.1),
            width: 76,
            height: 76,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFc05ba6), width: 3)),
            child: ClipOval(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: TextStyle(
                color: Colors.black.withOpacity(.8),
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget post(String image, name) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpeg'),
            ),
            title: Text(
              name,
              style: TextStyle(
                  color: Colors.black.withOpacity(.8),
                  fontWeight: FontWeight.w400,
                  fontSize: 21),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
          Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(Icons.favorite_border, size: 31),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.comment_sharp, size: 31),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.send, size: 31),
                  ],
                ),
                const Icon(Icons.bookmark_border, size: 31)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Text(
              'liked by you and 385 others',
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
            ),
          )
        ],
      ),
    );
  }

  Widget _createPopular(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostFetchError) {
          return ErrorPage(
            message: state.message,
            retry: () {
              context
                  .watch<PostBloc>()
                  .add(FetchPostWithType(Constant.popular));
            },
          );
        } else if (state is PostFetched) {
          return _createPopularView(context, state.public);
        } else {
          return const Text('Not support');
        }
      },
    );
  }

  Widget _createPopularView(BuildContext context, List<PublicResponse> movies) {
    final contentHeight = (MediaQuery.of(context).size.height) * 0.85;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20.0, right: 16.0),
          height: 48.0,
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  'Popular',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward, color: Colors.red),
            ],
          ),
        ),
        SizedBox(
          height: contentHeight,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return _createPopularViewItem(context, movies[index]);
            },
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => const VerticalDivider(
              color: Colors.transparent,
              width: 6.0,
            ),
            itemCount: movies.length,
          ),
        ),
      ],
    );
  }

  Widget _createPopularViewItem(BuildContext context, PublicResponse post) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.withOpacity(.3)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                imageUrl: post.user.avatar.replaceAll(
                    "http://localhost:8080", "http://10.0.2.2:8080"),
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              post.title,
              style: TextStyle(
                  color: Colors.black.withOpacity(.8),
                  fontWeight: FontWeight.w400,
                  fontSize: 21),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
          CachedNetworkImage(
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            imageUrl: post.fileScale
                .replaceAll("http://localhost:8080", "http://10.0.2.2:8080"),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    Icon(Icons.favorite_border, size: 31),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.comment_sharp, size: 31),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.send, size: 31),
                  ],
                ),
                const Icon(Icons.bookmark_border, size: 31)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Text(
              'liked by you and 385 others',
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(.8)),
            ),
          )
        ],
      ),
    );
  }
}
