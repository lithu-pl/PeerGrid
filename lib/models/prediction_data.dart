class PredictionInput {
  final String exam;
  final int rank;
  final String category;
  final String coursePreference;

  const PredictionInput({
    required this.exam,
    required this.rank,
    required this.category,
    required this.coursePreference,
  });
}

class PredictionResult {
  final String collegeName;
  final String course;
  final String chanceLabel; // 'High Chance', 'Moderate Chance', 'Low Chance'
  final int studentScore;
  final int closingRank;
  final int percentage; // 85, 50, etc.

  const PredictionResult({
    required this.collegeName,
    required this.course,
    required this.chanceLabel,
    required this.studentScore,
    required this.closingRank,
    required this.percentage,
  });
}
