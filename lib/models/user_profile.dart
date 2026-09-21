class UserProfile {
  final String id;
  final String name;
  final String email;
  final String college;
  final String department;
  final String avatarUrl;
  final String hobbies;
  final String phone;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.college,
    required this.department,
    required this.avatarUrl,
    required this.hobbies,
    required this.phone,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? college,
    String? department,
    String? avatarUrl,
    String? hobbies,
    String? phone,
  }) {
    return UserProfile(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      college: college ?? this.college,
      department: department ?? this.department,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      hobbies: hobbies ?? this.hobbies,
      phone: phone ?? this.phone,
    );
  }
}
