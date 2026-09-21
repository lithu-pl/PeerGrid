import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/community.dart';

class CreatePostDialog extends StatefulWidget {
  final Function(CommunityPost)? onPostCreated;

  const CreatePostDialog({super.key, this.onPostCreated});

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final _postController = TextEditingController();
  String _selectedCommunity = 'General Campus';
  bool _isPosting = false;

  final List<String> _communities = [
    'General Campus',
    'IEEE',
    'TinkerHub',
    'EDC',
    'CET Trivandrum',
    'RIT Kottayam',
  ];

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  void _submitPost() async {
    if (_postController.text.trim().isEmpty) return;

    setState(() => _isPosting = true);
    await Future.delayed(const Duration(milliseconds: 400));

    final newPost = CommunityPost(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      authorName: MockData.currentUser.name,
      authorCollege: MockData.currentUser.college,
      authorAvatar: MockData.currentUser.avatarUrl,
      content: _postController.text.trim(),
      timeAgo: 'Just now',
      likes: 0,
      comments: 0,
    );

    widget.onPostCreated?.call(newPost);

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post published to campus community!'),
          backgroundColor: AppTheme.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 20,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Create Campus Post',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // User info row
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(MockData.currentUser.avatarUrl),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MockData.currentUser.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  DropdownButton<String>(
                    value: _selectedCommunity,
                    underline: const SizedBox(),
                    isDense: true,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryDark,
                      fontWeight: FontWeight.w600,
                    ),
                    items: _communities.map((c) {
                      return DropdownMenuItem(
                        value: c,
                        child: Text('Posting to $c'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedCommunity = val);
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Input field
          TextField(
            controller: _postController,
            maxLines: 4,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "What's happening on your campus?",
              hintStyle: const TextStyle(color: AppTheme.textMuted, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
            ),
          ),
          const SizedBox(height: 16),

          // Action buttons: photo, tag, post
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.image_outlined, color: AppTheme.primary),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Image attachment selected')),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.tag_rounded, color: AppTheme.primary),
                onPressed: () {
                  _postController.text += ' #PeerGrid';
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _isPosting ? null : _submitPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: _isPosting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Post',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
