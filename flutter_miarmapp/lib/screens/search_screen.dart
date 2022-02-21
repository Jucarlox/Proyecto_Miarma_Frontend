import 'package:flutter/material.dart';
import 'package:flutter_miarmapp/models/CategoryStoryItem.dart';
import 'package:flutter_miarmapp/search_json.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getSearch(),
    );
  }

  Widget getSearch() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SafeArea(
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 15,
              ),
              Container(
                width: size.width - 30,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black.withOpacity(0.3),
                      )),
                  style: TextStyle(color: Colors.black.withOpacity(0.3)),
                  cursorColor: Colors.black.withOpacity(0.3),
                ),
              ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const SizedBox(
          height: 15,
        ),
        Wrap(
          spacing: 1,
          runSpacing: 1,
          children: List.generate(searchImage.length, (index) {
            return Container(
              width: (size.width - 3) / 3,
              height: (size.width - 3) / 3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(searchImage[index]),
                      fit: BoxFit.cover)),
            );
          }),
        )
      ],
    ));
  }
}
