import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/college.dart';
import '../../models/review.dart';
import '../../data/mock_data.dart';
import '../../widgets/rating_bar_chart.dart';
import '../../widgets/review_card.dart';

class CollegeDetailScreen extends StatefulWidget {
  final College college;

  const CollegeDetailScreen({
    super.key,
    required this.college,
  });

  @override
  State<CollegeDetailScreen> createState() => _CollegeDetailScreenState();
}

class _CollegeDetailScreenState extends State<CollegeDetailScreen> {
  late List<CollegeReview> _reviews;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _reviews = MockData.reviews
        .where((r) => r.collegeId == widget.college.id || widget.college.id == 'cet_tvm')
        .toList();
  }

  void _toggleReviewLike(CollegeReview review) {
    setState(() {
      final index = _reviews.indexWhere((r) => r.id == review.id);
      if (index != -1) {
        final isLiked = !_reviews[index].isLiked;
        _reviews[index] = _reviews[index].copyWith(
          isLiked: isLiked,
          likes: _reviews[index].likes + (isLiked ? 1 : -1),
        );
      }
    });
  }

  void _showAddReviewDialog() {
    double selectedRating = 5.0;
    final reviewTextController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text(
            'Write a Review',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rate your experience at ${widget.college.shortName}:',
                style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 12),
              // Star Picker
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      index < selectedRating
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: AppTheme.starGold,
                      size: 32,
                    ),
                    onPressed: () {
                      setDialogState(() {
                        selectedRating = index + 1.0;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reviewTextController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Share your feedback regarding faculty, campus, labs...',
                  hintStyle: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final text = reviewTextController.text.trim();
                if (text.isNotEmpty) {
                  final newReview = CollegeReview(
                    id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
                    collegeId: widget.college.id,
                    authorName: MockData.currentUser.name,
                    authorInitials: 'LP',
                    rating: selectedRating,
                    comment: text,
                    date: 'Just now',
                    likes: 0,
                    commentsCount: 0,
                  );
                  setState(() {
                    _reviews.insert(0, newReview);
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Your review has been submitted!'),
                      backgroundColor: AppTheme.primary,
                    ),
                  );
                }
              },
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          widget.college.name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_outline_rounded,
              color: _isBookmarked ? AppTheme.primary : AppTheme.textPrimary,
              size: 22,
            ),
            onPressed: () {
              setState(() => _isBookmarked = !_isBookmarked);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isBookmarked ? 'College saved to wishlist!' : 'College removed from wishlist'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showAddReviewDialog,
                  icon: const Icon(Icons.rate_review_outlined, size: 18),
                  label: const Text('Write a Review'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Campus Photo matching Doc1.pdf Screen 6
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Image.network(
                  widget.college.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppTheme.primaryLight,
                    child: const Center(
                      child: Icon(
                        Icons.account_balance_rounded,
                        size: 60,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // College Full Name & Location
            Text(
              widget.college.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  size: 15,
                  color: AppTheme.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.college.location,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  'Est. ${widget.college.establishedYear}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Rating Bar Chart summary matching Doc1.pdf Screen 6
            RatingBarChart(
              overallRating: widget.college.rating,
              totalReviews: widget.college.reviewsCount,
              distribution: widget.college.ratingDistribution,
            ),
            const SizedBox(height: 22),

            // About College Section
            const Text(
              'About College',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.college.description,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 16),

            // Offered Programs
            const Text(
              'Offered Programs',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.college.courses.map((course) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    course,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryDark,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Student Reviews Section Header matching Doc1.pdf Screen 6
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Student Reviews',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  '${_reviews.length} reviews',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Student Reviews Cards matching Arjun S and Meera M
            ..._reviews.map((review) {
              return ReviewCard(
                review: review,
                onLike: () => _toggleReviewLike(review),
                onComment: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening review thread...')),
                  );
                },
              );
            }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
