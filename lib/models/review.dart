class CollegeReview {
  final String id;
  final String collegeId;
  final String authorName;
  final String authorInitials;
  final double rating;
  final String comment;
  final String date;
  final int likes;
  final int commentsCount;
  final bool isLiked;

  const CollegeReview({
    required this.id,
    required this.collegeId,
    required this.authorName,
    required this.authorInitials,
    required this.rating,
    required this.comment,
    required this.date,
    required this.likes,
    required this.commentsCount,
    this.isLiked = false,
  });

  CollegeReview copyWith({
    int? likes,
    bool? isLiked,
    int? commentsCount,
  }) {
    return CollegeReview(
      id: id,
      collegeId: collegeId,
      authorName: authorName,
      authorInitials: authorInitials,
      rating: rating,
      comment: comment,
      date: date,
      likes: likes ?? this.likes,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
