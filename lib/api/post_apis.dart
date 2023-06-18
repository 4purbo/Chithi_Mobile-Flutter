import 'package:chithi/constants/back-end/firebase_constants.dart';
import 'package:chithi/model/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostAPI {
  // like apis

  // like a post api
  static Future<void> likePost({
    required PostModel postModel,
  }) async {
    List liked = postModel.likedBy;

    liked.add(Usr().crntUsr!.uid);

    PostModel newPostModel = postModel.copyWith(
      likedBy: liked,
    );

    await firePostsCollec.doc(postModel.postId).set(newPostModel.toMap());
  }

  // dislike a post api
  static Future<void> dislikePost({
    required PostModel postModel,
  }) async {
    List liked = postModel.likedBy;

    liked.remove(Usr().crntUsr!.uid);

    PostModel newPostModel = postModel.copyWith(
      likedBy: liked,
    );

    await firePostsCollec.doc(postModel.postId).set(newPostModel.toMap());
  }

  // comment apis

  // get comments
  static Future<List<CommentModel>> getComments({
    required PostModel postModel,
  }) async {
    const String commentCollecId = "comments";
    List<CommentModel> comments = [];

    QuerySnapshot<Map<String, dynamic>> result = await firePostsCollec
        .doc(postModel.postId)
        .collection(commentCollecId)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> data in result.docs) {
      Map<String, dynamic> mapData = data.data();

      // PostModel post = PostModel.fromMap(mapData);
      CommentModel commentModel = CommentModel.fromMap(mapData);

      comments.add(commentModel);
    }

    return comments;
  }
}
