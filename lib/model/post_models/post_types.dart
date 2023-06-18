enum PostType {
  textOnly,
  imageOnly,
  imageMany,
  videoOnly,
  videoMany,
  imageWithVideo,
}

PostType convertToPostTypeFromInt(int postTypeValue) {
  if (postTypeValue == PostType.textOnly.index) {
    return PostType.textOnly;
  } else if (postTypeValue == PostType.imageOnly.index) {
    return PostType.imageOnly;
  } else if (postTypeValue == PostType.videoOnly.index) {
    return PostType.videoOnly;
  } else {
    return PostType.imageWithVideo;
  }
}

int convertToIntFromPostType(PostType postType) {
  if (postType == PostType.imageOnly) {
    return PostType.imageOnly.index;
  }

  if (postType == PostType.imageWithVideo) {
    return PostType.imageWithVideo.index;
  }

  if (postType == PostType.textOnly) {
    return PostType.textOnly.index;
  } else {
    return PostType.videoOnly.index;
  }
}