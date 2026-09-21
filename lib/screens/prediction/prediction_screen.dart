import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/prediction_data.dart';
import '../../data/mock_data.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _rankController = TextEditingController(text: '15000');

  String _selectedExam = 'KEAM';
  String _selectedCategory = 'General';
  String _selectedCourse = 'B.Tech, CSE';

  bool _hasPredicted = true; // Shows initial results matching Doc1.pdf
  bool _isCalculating = false;
  List<PredictionResult> _results = [];

  final List<String> _exams = ['KEAM', 'JEE Main', 'CUET', 'GATE'];
  final List<String> _categories = ['General', 'OBC', 'SC', 'ST', 'EWS'];
  final List<String> _courses = [
    'B.Tech, CSE',
    'B.Tech, ECE',
    'B.Tech, Mechanical',
    'B.Tech, Civil',
    'B.Tech, Electrical',
  ];

  @override
  void initState() {
    super.initState();
    _runPrediction();
  }

  @override
  void dispose() {
    _rankController.dispose();
    super.dispose();
  }

  void _runPrediction() {
    final rank = int.tryParse(_rankController.text.trim()) ?? 15000;
    setState(() {
      _results = MockData.predictColleges(
        exam: _selectedExam,
        rank: rank,
        category: _selectedCategory,
        coursePreference: _selectedCourse,
      );
    });
  }

  void _onPredictPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isCalculating = true);
    await Future.delayed(const Duration(milliseconds: 600));

    if (mounted) {
      setState(() {
        _isCalculating = false;
        _hasPredicted = true;
      });
      _runPrediction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Predict your college'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form Card: "Enter Your Details"
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: AppTheme.cardShadow,
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Enter Your Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Exam Selector
                      _buildDropdownField(
                        label: 'Exam',
                        value: _selectedExam,
                        items: _exams,
                        onChanged: (val) => setState(() => _selectedExam = val!),
                      ),
                      const SizedBox(height: 12),

                      // Score / Rank
                      const Text(
                        'Score/Rank',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _rankController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'e.g. 15000',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Please enter rank' : null,
                      ),
                      const SizedBox(height: 12),

                      // Category Selector
                      _buildDropdownField(
                        label: 'Category',
                        value: _selectedCategory,
                        items: _categories,
                        onChanged: (val) =>
                            setState(() => _selectedCategory = val!),
                      ),
                      const SizedBox(height: 12),

                      // Course Preference
                      _buildDropdownField(
                        label: 'Course Preference',
                        value: _selectedCourse,
                        items: _courses,
                        onChanged: (val) =>
                            setState(() => _selectedCourse = val!),
                      ),
                      const SizedBox(height: 18),

                      // Predict Button
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: _isCalculating ? null : _onPredictPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: _isCalculating
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Predict',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Results Section: "College You Might Get"
              if (_hasPredicted) ...[
                const Text(
                  'College You Might Get',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 14),

                // Result Cards matching Doc1.pdf Screen 4
                ..._results.map((result) => _buildPredictionResultCard(result)),
                const SizedBox(height: 14),

                // Disclaimer
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: AppTheme.primaryDark,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Prediction is based on previous year\'s trends. Actual results may contain slight changes.',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppTheme.textMuted),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPredictionResultCard(PredictionResult result) {
    final bool isHigh = result.percentage >= 70;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: AppTheme.cardShadow,
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          // College Details on Left
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        result.collegeName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isHigh
                            ? AppTheme.badgeGreenLight
                            : AppTheme.badgeAmberLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        result.chanceLabel,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isHigh
                              ? AppTheme.successGreen
                              : const Color(0xFFD97706),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Your Score: ${result.studentScore}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Closing Rank: ${result.closingRank}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Percentage Circle Badge on Right
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isHigh
                  ? AppTheme.primary.withOpacity(0.12)
                  : Colors.amber.withOpacity(0.15),
              border: Border.all(
                color: isHigh ? AppTheme.primary : AppTheme.nexoraGold,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                '${result.percentage}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: isHigh ? AppTheme.primaryDark : const Color(0xFFB45309),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
