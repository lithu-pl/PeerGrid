import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/college.dart';
import '../../data/mock_data.dart';
import '../../widgets/college_card.dart';
import 'college_detail_screen.dart';

class CollegeDiscoveryScreen extends StatefulWidget {
  const CollegeDiscoveryScreen({super.key});

  @override
  State<CollegeDiscoveryScreen> createState() => _CollegeDiscoveryScreenState();
}

class _CollegeDiscoveryScreenState extends State<CollegeDiscoveryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCity = 'All';

  final List<String> _cities = ['All', 'Thiruvananthapuram', 'Kottayam', 'Ernakulam'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase();
    final colleges = MockData.colleges.where((c) {
      final matchesQuery = c.name.toLowerCase().contains(query) ||
          c.shortName.toLowerCase().contains(query) ||
          c.location.toLowerCase().contains(query);
      final matchesCity = _selectedCity == 'All' || c.location.contains(_selectedCity);
      return matchesQuery && matchesCity;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Discover Colleges'),
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
              // Search field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: AppTheme.cardShadow,
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: 'Search by college name or city...',
                    hintStyle: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                    prefixIcon: Icon(Icons.search_rounded,
                        color: AppTheme.textMuted, size: 22),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // City filter chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _cities.map((city) {
                    final isSelected = _selectedCity == city;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        selected: isSelected,
                        label: Text(city),
                        selectedColor: AppTheme.primary,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppTheme.textSecondary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: isSelected ? AppTheme.primary : const Color(0xFFE2E8F0),
                          ),
                        ),
                        onSelected: (_) {
                          setState(() => _selectedCity = city);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 18),

              // Results count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Colleges (${colleges.length})',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // College Cards
              if (colleges.isEmpty) ...[
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text('No colleges match your search criteria.'),
                  ),
                ),
              ] else ...[
                ...colleges.map((college) {
                  return CollegeCard(
                    college: college,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CollegeDetailScreen(college: college),
                        ),
                      );
                    },
                  );
                }),
              ],
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
