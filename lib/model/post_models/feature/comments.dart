import 'package:chithi/api/apis.dart';
import 'package:chithi/model/models.dart';
import 'package:chithi/theme/custom_theme.dart';
import 'package:chithi/theme/theme.dart';
import 'package:chithi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Comments extends StatefulWidget {
  const Comments({super.key, required PostModel postModel})
      : _postModel = postModel;
  final PostModel _postModel;

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  List<CommentModel>? comments = [];

  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    comments = await PostAPI.getComments(postModel: widget._postModel);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: comments != null
          ? comments!.isNotEmpty
              ? ScrollConfiguration(
                  behavior: StopScrolling(),
                  child: ListView(
                    children: comments!.map((commentModel) {
                      return CommentTile(
                        commentModel: commentModel,
                      );
                    }).toList(),
                  ),
                )
              : const Center(
                  child:
                      Text("No comments available! Be the first one to start"),
                )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class CommentTile extends ConsumerStatefulWidget {
  const CommentTile({super.key, required CommentModel commentModel})
      : _commentModel = commentModel;
  final CommentModel _commentModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentTileState();
}

class _CommentTileState extends ConsumerState<CommentTile> {
  UserModel? commenterModel;

  @override
  void initState() {
    super.initState();
    getCommenterDet();
  }

  Future<void> getCommenterDet() async {
    commenterModel = await UserAPI.getUserData(widget._commentModel.commenter);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CustomTheme currentTheme = ref.watch(currentThemeProvider);
    bool isDark = currentTheme == CustomTheme.dark;

    if (commenterModel != null) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isDark ? darkPostBgClr : postBgClr,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PROFILE, NAME AND SETTINGS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // PROFILE, NAME
                  Row(
                    children: [
                      // PROFILE PIC OF WHO COMMENTED
                      CircleAvatar(
                        backgroundImage: commenterModel!.profilePicReady(),
                      ),

                      const SizedBox(width: 10),

                      // USERNAME
                      SelectableText(
                        "@${commenterModel!.userName}",
                        style: const TextStyle(fontSize: 15),
                      )
                    ],
                  ),

                  // SETTINGS
                  const Icon(Icons.more_vert),
                ],
              ),

              const SizedBox(height: 10),

              // MAIN COMMENT
              Text(widget._commentModel.content)
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: isDark ? darkPostBgClr : postBgClr,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      );
    }
  }
}
