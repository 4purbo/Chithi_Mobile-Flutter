class CommentModel {
  String commenter;
  String content;
  List likedBy;
  List dislikedBy;
  String commentId;

  CommentModel({
    required this.commenter,
    required this.content,
    required this.dislikedBy,
    required this.likedBy,
    required this.commentId,
  });

  CommentModel copyWith({
    String? commenter,
    String? content,
    List? likedBy,
    List? dislikedBy,
    String? commentId,
  }) {
    return CommentModel(
      commenter: commenter ?? this.commenter,
      content: content ?? this.content,
      dislikedBy: dislikedBy ?? this.dislikedBy,
      likedBy: likedBy ?? this.likedBy,
      commentId: commentId ?? this.commentId,
    );
  }

  static CommentModel fromMap(Map<String, dynamic> data) {
    return CommentModel(
      commenter: data['commenter'],
      content: data['content'],
      dislikedBy: data['dislikedBy'],
      likedBy: data['likedBy'],
      commentId: data['commentId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "commenter": commenter,
      "content": content,
      "likedBy": likedBy,
      "dislikedBy": dislikedBy,
      "commentId": commentId,
    };
  }
}
