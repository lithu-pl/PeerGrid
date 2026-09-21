import '../models/college.dart';
import '../models/event.dart';
import '../models/community.dart';
import '../models/review.dart';
import '../models/prediction_data.dart';
import '../models/user_profile.dart';

class MockData {
  static UserProfile currentUser = const UserProfile(
    id: 'user_1',
    name: 'Lithu P L',
    email: 'lithu.pl@peergrid.edu',
    college: 'College of Engineering Poonjar',
    department: 'Computer Science and Engineering',
    avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300',
    hobbies: 'cooking, dance, etc',
    phone: '+91 98765 43210',
  );

  static final List<College> colleges = [
    const College(
      id: 'cet_tvm',
      name: 'College of Engineering Trivandrum',
      shortName: 'CET',
      location: 'Thiruvananthapuram',
      rating: 4.6,
      reviewsCount: 120,
      imageUrl: 'https://images.unsplash.com/photo-1562774053-701939374585?w=800',
      description:
          'College of Engineering Trivandrum (CET), established in 1939, is the first engineering college in Kerala and one of the premier technical institutions in India, renowned for academic excellence, innovation, and top placements.',
      ratingDistribution: {
        5: 0.72,
        4: 0.18,
        3: 0.05,
        2: 0.03,
        1: 0.02,
      },
      courses: [
        'Computer Science and Engineering',
        'Electronics and Communication',
        'Mechanical Engineering',
        'Civil Engineering',
        'Electrical and Electronics'
      ],
      establishedYear: 1939,
    ),
    const College(
      id: 'rit_ktm',
      name: 'Rajiv Gandhi Institute of Technology',
      shortName: 'RIT',
      location: 'Kottayam',
      rating: 4.5,
      reviewsCount: 95,
      imageUrl: 'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?w=800',
      description:
          'Rajiv Gandhi Institute of Technology (RIT), Kottayam is a prestigious government engineering college offering cutting-edge undergraduate, postgraduate, and doctoral degrees in technical disciplines.',
      ratingDistribution: {
        5: 0.65,
        4: 0.22,
        3: 0.08,
        2: 0.03,
        1: 0.02,
      },
      courses: [
        'Computer Science and Engineering',
        'Mechanical Engineering',
        'Electrical Engineering',
        'Civil Engineering',
        'Architecture'
      ],
      establishedYear: 1991,
    ),
    const College(
      id: 'mec_ekm',
      name: 'Model Engineering College',
      shortName: 'MEC',
      location: 'Ernakulam',
      rating: 4.7,
      reviewsCount: 110,
      imageUrl: 'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=800',
      description:
          'Govt. Model Engineering College Thrikkakara is celebrated for its stellar student culture, industry partnerships, and record placement records in major global technology corporations.',
      ratingDistribution: {
        5: 0.75,
        4: 0.15,
        3: 0.06,
        2: 0.02,
        1: 0.02,
      },
      courses: [
        'Computer Science and Engineering',
        'Electronics and Communication',
        'Biomedical Engineering',
        'Mechanical Engineering'
      ],
      establishedYear: 1989,
    ),
    const College(
      id: 'cep_pjr',
      name: 'College of Engineering Poonjar',
      shortName: 'CEP',
      location: 'Poonjar, Kottayam',
      rating: 4.2,
      reviewsCount: 45,
      imageUrl: 'https://images.unsplash.com/photo-1592280771190-3e2e4d571952?w=800',
      description:
          'College of Engineering Poonjar was established under IHRD to bring high-quality technical education and hands-on skill development to talented students in Central Kerala.',
      ratingDistribution: {
        5: 0.50,
        4: 0.30,
        3: 0.12,
        2: 0.05,
        1: 0.03,
      },
      courses: [
        'Computer Science and Engineering',
        'Electronics and Communication',
        'Electrical and Electronics'
      ],
      establishedYear: 2000,
    ),
  ];

  static final List<CollegeReview> reviews = [
    const CollegeReview(
      id: 'rev_1',
      collegeId: 'cet_tvm',
      authorName: 'Arjun S',
      authorInitials: 'AS',
      rating: 5.0,
      comment:
          'Good campus environment and active student community. Lots of opportunities for growth.',
      date: '2 days ago',
      likes: 8,
      commentsCount: 9,
    ),
    const CollegeReview(
      id: 'rev_2',
      collegeId: 'cet_tvm',
      authorName: 'Meera M',
      authorInitials: 'MM',
      rating: 4.0,
      comment:
          'Great infrastructure and faculty. Placements are very good.',
      date: '1 week ago',
      likes: 28,
      commentsCount: 31,
    ),
    const CollegeReview(
      id: 'rev_3',
      collegeId: 'cet_tvm',
      authorName: 'Rahul K',
      authorInitials: 'RK',
      rating: 4.8,
      comment:
          'The clubs here like IEEE and TinkerHub are top notch. Very supportive seniors and amazing tech culture.',
      date: '2 weeks ago',
      likes: 19,
      commentsCount: 14,
    ),
  ];

  static final List<CampusEvent> events = [
    const CampusEvent(
      id: 'evt_techfest',
      title: 'TechFest',
      organizer: 'RIT Kottayam',
      date: '14 Aug 2026',
      time: '10:00 AM',
      venue: 'Main Auditorium',
      posterTag: 'TECH FEST',
      posterSubtag: '</>',
      themeType: 'purple',
      description:
          'Annual national tech symposium featuring 24-hour hackathons, competitive coding, robotics combat, and project exhibitions.',
      isRegistered: false,
    ),
    const CampusEvent(
      id: 'evt_nexora',
      title: 'Nexora',
      organizer: 'CET Trivandrum',
      date: '21 Aug 2026',
      time: '11:00 AM',
      venue: 'Open Stage',
      posterTag: 'NEXORA',
      posterSubtag: '2026',
      themeType: 'gold',
      description:
          'A flagship inter-college summit hosting UI/UX design battles, paper presentations, keynote talks, and live musical pro-nights.',
      isRegistered: true,
    ),
    const CampusEvent(
      id: 'evt_devcon',
      title: 'InnovateX',
      organizer: 'MEC Ernakulam',
      date: '05 Sep 2026',
      time: '09:30 AM',
      venue: 'Seminar Hall 1',
      posterTag: 'INNOVATEX',
      posterSubtag: 'AI/ML',
      themeType: 'purple',
      description:
          'Hands-on masterclass and pitch competition focusing on Generative AI, cloud infrastructure, and student entrepreneurship.',
      isRegistered: false,
    ),
  ];

  static final List<Community> communities = [
    const Community(
      id: 'comm_ieee',
      name: 'IEEE',
      description:
          'Technical community for engineering, research, and technical publication.',
      memberCount: 1420,
      iconCode: 'ieee',
      isJoined: true,
    ),
    const Community(
      id: 'comm_tinkerhub',
      name: 'TinkerHub',
      description:
          'Peer-to-peer learning community connecting passionate tech learners.',
      memberCount: 2150,
      iconCode: 'tinkerhub',
      isJoined: false,
    ),
    const Community(
      id: 'comm_edc',
      name: 'EDC',
      description:
          'Entrepreneurship Development Cell nurturing startup culture and founders.',
      memberCount: 890,
      iconCode: 'edc',
      isJoined: false,
    ),
  ];

  static final List<CommunityPost> initialPosts = [
    const CommunityPost(
      id: 'post_1',
      authorName: 'Arjun S',
      authorCollege: 'College of Engineering Trivandrum',
      authorAvatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=200',
      content:
          'Registrations for Nexora 2026 hackathon are now open! Explore exciting prizes and internship opportunities. Check the Events tab to register your team!',
      timeAgo: '2 hours ago',
      likes: 34,
      comments: 12,
    ),
    const CommunityPost(
      id: 'post_2',
      authorName: 'Lithu P L',
      authorCollege: 'College of Engineering Poonjar',
      authorAvatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
      content:
          'Super excited to announce that our campus robotics club qualified for the regional finals! Huge thanks to everyone who supported us.',
      timeAgo: '1 day ago',
      likes: 62,
      comments: 18,
    ),
  ];

  static List<PredictionResult> predictColleges({
    required String exam,
    required int rank,
    required String category,
    required String coursePreference,
  }) {
    // Generates accurate predictions matching Doc1.pdf
    if (rank <= 16000) {
      return [
        const PredictionResult(
          collegeName: 'College of Engineering Trivandrum',
          course: 'B.Tech, CSE',
          chanceLabel: 'High Chance',
          studentScore: 15000,
          closingRank: 18000,
          percentage: 85,
        ),
        const PredictionResult(
          collegeName: 'Model Engineering College',
          course: 'B.Tech, CSE',
          chanceLabel: 'Moderate Chance',
          studentScore: 15000,
          closingRank: 14000,
          percentage: 50,
        ),
        const PredictionResult(
          collegeName: 'Rajiv Gandhi Institute of Technology',
          course: 'B.Tech, CSE',
          chanceLabel: 'High Chance',
          studentScore: 15000,
          closingRank: 22000,
          percentage: 92,
        ),
      ];
    } else {
      return [
        PredictionResult(
          collegeName: 'Rajiv Gandhi Institute of Technology',
          course: coursePreference.isEmpty ? 'B.Tech, CSE' : coursePreference,
          chanceLabel: 'High Chance',
          studentScore: rank,
          closingRank: (rank * 1.15).toInt(),
          percentage: 78,
        ),
        PredictionResult(
          collegeName: 'College of Engineering Poonjar',
          course: coursePreference.isEmpty ? 'B.Tech, CSE' : coursePreference,
          chanceLabel: 'High Chance',
          studentScore: rank,
          closingRank: (rank * 1.35).toInt(),
          percentage: 94,
        ),
        PredictionResult(
          collegeName: 'Model Engineering College',
          course: coursePreference.isEmpty ? 'B.Tech, ECE' : coursePreference,
          chanceLabel: 'Moderate Chance',
          studentScore: rank,
          closingRank: (rank * 0.95).toInt(),
          percentage: 45,
        ),
      ];
    }
  }
}
