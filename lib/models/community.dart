class Community {
  final String id;
  final String name;
  final String description;
  final int memberCount;
  final String iconCode;
  final bool isJoined;

  const Community({
    required this.id,
    required this.name,
    required this.description,
    required this.memberCount,
    required this.iconCode,
    this.isJoined = false,
  });

  Community copyWith({
    bool? isJoined,
    int? memberCount,
  }) {
    return Community(
      id: id,
      name: name,
      description: description,
      memberCount: memberCount ?? this.memberCount,
      iconCode: iconCode,
      isJoined: isJoined ?? this.isJoined,
    );
  }
}

class CommunityPost {
  final String id;
  final String authorName;
  final String authorCollege;
  final String authorAvatar;
  final String content;
  final String timeAgo;
  final int likes;
  final int comments;
  final bool isLiked;

  const CommunityPost({
    required this.id,
    required this.authorName,
    required this.authorCollege,
    required this.authorAvatar,
    required this.content,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    this.isLiked = false,
  });

  CommunityPost copyWith({
    int? likes,
    bool? isLiked,
  }) {
    return CommunityPost(
      id: id,
      authorName: authorName,
      authorCollege: authorCollege,
      authorAvatar: authorAvatar,
      content: content,
      timeAgo: timeAgo,
      likes: likes ?? this.likes,
      comments: comments,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
