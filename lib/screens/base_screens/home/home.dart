import 'dart:math' as maths;
import 'dart:developer';

import 'package:chithi/constants/back-end/firebase_constants.dart';
import 'package:chithi/model/models.dart';
import 'package:chithi/screens/screens.dart';
import 'package:chithi/utils/utils.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required UserModel crntUserModel})
      : _crntUserModel = crntUserModel;
  // ignore: unused_field
  final UserModel _crntUserModel;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> posts = [];
  List<int> takenIndexes = [];

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  Future<void> getPosts() async {
    var result = await firePostsCollec.get();

    posts.clear();

    for (var i = 0; i < result.docs.length; i++) {
      int index = maths.Random().nextInt(result.docs.length);

      while (takenIndexes.contains(index)) {
        index = maths.Random().nextInt(result.docs.length);
      }

      takenIndexes.add(index);
      log(takenIndexes.toString());

      Map<String, dynamic> mapData = result.docs[index].data();

      PostModel post = PostModel.fromMap(mapData);

      posts.add(Post(postModel: post));
    }

    setState(() {});

    log(posts.toString());

    takenIndexes.clear();
  }

  Future<void> refresh() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Base()));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: Scaffold(
        // later wrap it in nested way
        appBar: AppBar(
          title: const Text("Chithi"),
          centerTitle: false,
        ),

        // later add posts and so on.....
        body: posts.isEmpty
            ? const Center(
                child: Text("Nothing available!!"),
              )
            : ScrollConfiguration(
                behavior: StopScrolling(),
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: posts[index],
                  ),
                ),
              ),
      ),
    );
  }
}
