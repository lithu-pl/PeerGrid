class College {
  final String id;
  final String name;
  final String shortName;
  final String location;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String description;
  final Map<int, double> ratingDistribution; // 5 -> 0.7, 4 -> 0.2, etc.
  final List<String> courses;
  final int establishedYear;

  const College({
    required this.id,
    required this.name,
    required this.shortName,
    required this.location,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.description,
    required this.ratingDistribution,
    required this.courses,
    required this.establishedYear,
  });
}
