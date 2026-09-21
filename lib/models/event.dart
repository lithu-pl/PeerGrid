class CampusEvent {
  final String id;
  final String title;
  final String organizer;
  final String date;
  final String time;
  final String venue;
  final String posterTag;
  final String posterSubtag;
  final String themeType; // 'purple' or 'gold'
  final String description;
  final bool isRegistered;

  const CampusEvent({
    required this.id,
    required this.title,
    required this.organizer,
    required this.date,
    required this.time,
    required this.venue,
    required this.posterTag,
    this.posterSubtag = '',
    required this.themeType,
    required this.description,
    this.isRegistered = false,
  });

  CampusEvent copyWith({
    bool? isRegistered,
  }) {
    return CampusEvent(
      id: id,
      title: title,
      organizer: organizer,
      date: date,
      time: time,
      venue: venue,
      posterTag: posterTag,
      posterSubtag: posterSubtag,
      themeType: themeType,
      description: description,
      isRegistered: isRegistered ?? this.isRegistered,
    );
  }
}
