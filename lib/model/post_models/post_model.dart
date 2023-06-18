import 'package:cloud_firestore/cloud_firestore.dart';

import './post_types.dart';

class PostModel {
  // attributes
  String? caption;
  String postedBy;
  List likedBy;
  PostType postType;
  String postId;
  DateTime postedOn;
  String? content;
  List<String>? contents;

  PostModel({
    required this.caption,
    required this.likedBy,
    required this.postType,
    required this.postedBy,
    required this.postId,
    required this.postedOn,
    this.content,
    this.contents,
  });

  static PostModel fromMap(Map<String, dynamic> data) {
    PostType postType = convertToPostTypeFromInt(data['postType']);

    // transfer into datetime from timestamp
    Timestamp time = data['postedOn'];
    DateTime postedOn = time.toDate();

    return PostModel(
      caption: data['caption'],
      likedBy: data['likedBy'],
      postType: postType,
      postedBy: data['postedBy'],
      postId: data['postId'],
      postedOn: postedOn,
      content: data['content'],
      contents: data['contents'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'caption': caption,
      'postedBy': postedBy,
      'likedBy': likedBy,
      "postType": convertToIntFromPostType(postType),
      'postId': postId,
      'postedOn': Timestamp.fromDate(postedOn),
      "content": content,
      "contents": contents,
    };
  }

  PostModel copyWith({
    String? caption,
    String? postedBy,
    List? likedBy,
    PostType? postType,
    String? postId,
    DateTime? postedOn,
    String? content,
    List<String>? contents,
  }) {
    return PostModel(
      caption: caption ?? this.caption,
      likedBy: likedBy ?? this.likedBy,
      postType: postType ?? this.postType,
      postedBy: postedBy ?? this.postedBy,
      postId: postId ?? this.postId,
      postedOn: postedOn ?? this.postedOn,
      content: content ?? this.content,
      contents: contents ?? this.contents,
    );
  }
}