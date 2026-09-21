import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../widgets/college_card.dart';
import '../../widgets/event_card.dart';
import '../../widgets/community_card.dart';
import '../colleges/college_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase();

    final filteredColleges = MockData.colleges.where((c) {
      return c.name.toLowerCase().contains(query) ||
          c.shortName.toLowerCase().contains(query) ||
          c.location.toLowerCase().contains(query);
    }).toList();

    final filteredEvents = MockData.events.where((e) {
      return e.title.toLowerCase().contains(query) ||
          e.organizer.toLowerCase().contains(query) ||
          e.venue.toLowerCase().contains(query);
    }).toList();

    final filteredCommunities = MockData.communities.where((c) {
      return c.name.toLowerCase().contains(query) ||
          c.description.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Search PeerGrid'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: AppTheme.cardShadow,
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: TextField(
                  controller: _searchController,
                  autofocus: false,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search colleges, events, communities...',
                    hintStyle: const TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppTheme.textMuted,
                      size: 22,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),

            // Tab Bar (Colleges, Events, Communities)
            TabBar(
              controller: _tabController,
              indicatorColor: AppTheme.primary,
              indicatorWeight: 3,
              labelColor: AppTheme.primaryDark,
              unselectedLabelColor: AppTheme.textSecondary,
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: 'Colleges (${filteredColleges.length})'),
                Tab(text: 'Events (${filteredEvents.length})'),
                Tab(text: 'Communities (${filteredCommunities.length})'),
              ],
            ),
            const SizedBox(height: 10),

            // Tab Bar Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Colleges tab
                  ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    itemCount: filteredColleges.length,
                    itemBuilder: (ctx, idx) {
                      final college = filteredColleges[idx];
                      return CollegeCard(
                        college: college,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CollegeDetailScreen(college: college),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Events tab
                  ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    itemCount: filteredEvents.length,
                    itemBuilder: (ctx, idx) {
                      final event = filteredEvents[idx];
                      return EventCard(
                        event: event,
                        onRegister: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registered for ${event.title}!'),
                            ),
                          );
                        },
                      );
                    },
                  ),

                  // Communities tab
                  ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    itemCount: filteredCommunities.length,
                    itemBuilder: (ctx, idx) {
                      final community = filteredCommunities[idx];
                      return CommunityCard(
                        community: community,
                        onToggleJoin: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Updated ${community.name} status'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
