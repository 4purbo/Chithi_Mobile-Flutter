import 'package:chithi/model/models.dart';
import 'package:flutter/material.dart';
import './only_text_post.dart';

class Post extends StatelessWidget {
  const Post({super.key, required this.postModel});
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    if (postModel.postType == PostType.textOnly) {
      return OnlyTextPost(postModel: postModel);
    } else {
      return Container();
    }
  }
}