import 'package:chithi/api/apis.dart';
import 'package:chithi/constants/back-end/firebase_constants.dart';
import 'package:chithi/constants/front-end/frontend_constants.dart';
import 'package:chithi/model/models.dart';
import 'package:chithi/theme/custom_theme.dart';
import 'package:chithi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readmore/readmore.dart';

import 'package:chithi/model/post_models/feature/comments.dart';

class OnlyTextPost extends ConsumerStatefulWidget {
  const OnlyTextPost({super.key, required this.postModel});
  final PostModel postModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnlyTextPostState();
}

class _OnlyTextPostState extends ConsumerState<OnlyTextPost> {
  // variables
  UserModel? posterModel;

  bool showMore = false;
  bool isLiked = true;

  // functions
  @override
  void initState() {
    super.initState();
    getPosterModel();
    isLiked = widget.postModel.likedBy.contains(Usr().crntUsr!.uid);
  }

  Future<void> getPosterModel() async {
    posterModel = await UserAPI.getUserData(widget.postModel.postedBy);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CustomTheme currentTheme = ref.watch(currentThemeProvider);
    bool isDark = currentTheme == CustomTheme.dark;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: isDark ? darkPostBgClr : postBgClr,
          borderRadius: const BorderRadius.all(Radius.circular(10))),

      // INSIDE THE CHILD THE BODY OF THE POST WILL BE THERE
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // having the row of user Details like profile pic, userName
          Row(
            children: [
              CircleAvatar(
                backgroundImage: posterModel == null
                    ? const AssetImage(Assets.defaultProfilePic)
                    : posterModel!.profilePicReady(),
              ),
              const SizedBox(
                width: 10,
              ),

              // USERNAME & DISPLAY NAME
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    posterModel == null
                        ? "Chithi User"
                        : posterModel!.displayName,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SelectableText(
                    posterModel == null
                        ? "@user_name"
                        : "@${posterModel!.userName}",
                    style: const TextStyle(
                      color: customWhite,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // MAIN CONTENT TEXT

          ReadMoreText(
            widget.postModel.content!,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'show more',
            trimExpandedText: '',
            style: const TextStyle(color: Colors.white),
            moreStyle: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 15),

          // BAR FOR COMMENT, REACTIONS AND SHARE

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // LIKE BUTTON

              OutlinedButton.icon(
                onPressed: () {
                  if (isLiked) {
                    PostAPI.dislikePost(postModel: widget.postModel);
                  } else {
                    PostAPI.likePost(postModel: widget.postModel);
                  }

                  setState(() {
                    isLiked = !isLiked;
                  });
                },
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : null,
                ),
                label: Text(isLiked
                    ? widget.postModel.likedBy.length.toString()
                    : "Like"),
                style: OutlinedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),

              const SizedBox(
                width: 10,
              ),

              // COMMENT BUTTON

              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Comments(
                        postModel: widget.postModel,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.comment,
                ),
                label: const Text("Comment"),
                style: OutlinedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),

              const SizedBox(
                width: 10,
              ),

              // SHARE BUTTON

              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text("Share"),
                style: OutlinedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
