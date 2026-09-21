import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/community.dart';
import '../../data/mock_data.dart';
import '../../widgets/community_card.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _quickPostController = TextEditingController();

  late List<Community> _communities;
  late List<CommunityPost> _posts;

  @override
  void initState() {
    super.initState();
    _communities = List.from(MockData.communities);
    _posts = List.from(MockData.initialPosts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _quickPostController.dispose();
    super.dispose();
  }

  void _toggleJoin(Community community) {
    setState(() {
      final index = _communities.indexWhere((c) => c.id == community.id);
      if (index != -1) {
        final currentJoined = _communities[index].isJoined;
        final newJoined = !currentJoined;
        _communities[index] = _communities[index].copyWith(
          isJoined: newJoined,
          memberCount: _communities[index].memberCount + (newJoined ? 1 : -1),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              newJoined
                  ? 'Joined ${community.name} community!'
                  : 'Left ${community.name} community',
            ),
            backgroundColor: newJoined ? AppTheme.primary : AppTheme.textSecondary,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    });
  }

  void _publishQuickPost() {
    final text = _quickPostController.text.trim();
    if (text.isEmpty) return;

    final newPost = CommunityPost(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      authorName: MockData.currentUser.name,
      authorCollege: MockData.currentUser.college,
      authorAvatar: MockData.currentUser.avatarUrl,
      content: text,
      timeAgo: 'Just now',
      likes: 0,
      comments: 0,
    );

    setState(() {
      _posts.insert(0, newPost);
      _quickPostController.clear();
    });

    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post published to campus community!'),
        backgroundColor: AppTheme.primary,
      ),
    );
  }

  void _toggleLikePost(CommunityPost post) {
    setState(() {
      final index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        final isLiked = !_posts[index].isLiked;
        _posts[index] = _posts[index].copyWith(
          isLiked: isLiked,
          likes: _posts[index].likes + (isLiked ? 1 : -1),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase();
    final filteredCommunities = _communities.where((c) {
      return c.name.toLowerCase().contains(query) ||
          c.description.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Community'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
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
                    hintText: 'Search communities, clubs, discussions',
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
              const SizedBox(height: 18),

              // Create Post Box matching Doc1.pdf Screen 3
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppTheme.cardShadow,
                  border: Border.all(color: const Color(0xFFF1F5F9)),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              NetworkImage(MockData.currentUser.avatarUrl),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _quickPostController,
                            maxLines: 2,
                            decoration: const InputDecoration(
                              hintText: "What's happening on your campus?",
                              hintStyle: TextStyle(
                                color: AppTheme.textMuted,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Color(0xFFF1F5F9), height: 1),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.image_outlined,
                                  color: AppTheme.primary, size: 20),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Attach image clicked')),
                                );
                              },
                              visualDensity: VisualDensity.compact,
                            ),
                            IconButton(
                              icon: const Icon(Icons.tag_rounded,
                                  color: AppTheme.primary, size: 20),
                              onPressed: () {
                                _quickPostController.text += ' #CampusLife';
                              },
                              visualDensity: VisualDensity.compact,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                          child: ElevatedButton(
                            onPressed: _publishQuickPost,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Post',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Communities Section Title
              const Text(
                'communities',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              // Community List Cards matching Doc1.pdf Screen 3
              ...filteredCommunities.map((community) {
                return CommunityCard(
                  community: community,
                  onToggleJoin: () => _toggleJoin(community),
                );
              }),
              const SizedBox(height: 22),

              // Campus Discussions Feed
              const Text(
                'Campus Feed',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              ..._posts.map((post) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: AppTheme.cardShadow,
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(post.authorAvatar),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.authorName,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                Text(
                                  '${post.authorCollege} • ${post.timeAgo}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        post.content,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textPrimary,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _toggleLikePost(post),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: post.isLiked
                                    ? AppTheme.primaryLight
                                    : const Color(0xFFF8FAFC),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    post.isLiked
                                        ? Icons.thumb_up_alt_rounded
                                        : Icons.thumb_up_alt_outlined,
                                    size: 14,
                                    color: post.isLiked
                                        ? AppTheme.primaryDark
                                        : AppTheme.textSecondary,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${post.likes}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: post.isLiked
                                          ? AppTheme.primaryDark
                                          : AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.chat_bubble_outline_rounded,
                                size: 14,
                                color: AppTheme.textSecondary,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${post.comments}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
