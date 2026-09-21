# PeerGrid — Flutter Mobile Frontend

PeerGrid is a student-focused mobile platform that unifies college discovery, admission prediction, campus activities, student communities, and college reviews into an intuitive, vibrant mobile interface.

This frontend was built in **Flutter & Dart**, strictly following the UI/UX design specifications in [`Doc1.pdf`](Doc1.pdf) and the requirements in [`PRD.md`](PRD.md).

---

## 📱 Features & Screen Mapping

| Design Screen (`Doc1.pdf`) | Flutter Screen Component | Features |
|---|---|---|
| **Screen 1: Home Dashboard** | `lib/screens/home/home_screen.dart` | Personalized greeting (`Hi, Lithu P L`), Hero card (*"Discover your future college"*), 4 quick action shortcuts, Top Colleges list with ratings & locations, floating bottom bar |
| **Screen 2: Events** | `lib/screens/events/events_screen.dart` | Search bar, upcoming events, TechFest (RIT Kottayam) & Nexora (CET Trivandrum) stylized cards, interactive **Register** action & details |
| **Screen 3: Community** | `lib/screens/community/community_screen.dart` | Campus post creator, IEEE, TinkerHub, EDC communities with member count, interactive **Join / Joined** toggle, live campus feed |
| **Screen 4: Predict your college** | `lib/screens/prediction/prediction_screen.dart` | Prediction form (Exam, Rank/Score, Category, Course Preference), instant calculation, **College You Might Get** cards with high/moderate chance badges, % indicators (85%, 50%), and disclaimer |
| **Screen 5: Profile** | `lib/screens/profile/profile_screen.dart` | Student profile avatar, name, college, hobbies, settings list (Chats, Storage, Accounts, Privacy), edit details |
| **Screen 6: College Details & Reviews** | `lib/screens/colleges/college_detail_screen.dart` | CET Trivandrum hero campus image, 4.6 ★ rating summary with 5-to-1 star horizontal bar chart, student reviews by Arjun S & Meera M with thumbs-up and comments, **Write a Review** modal |
| **Authentication Flow** | `lib/screens/auth/login_screen.dart`, `signup_screen.dart` | Sign in, sign up, password reset dialog, Google & Facebook social buttons |

---

## 📁 Project Structure

```
d:/PG/
├── pubspec.yaml                       # Flutter dependencies & assets config
├── README.md                          # Documentation & Getting Started
├── preview/                           # Instant Interactive Web Simulator
│   ├── index.html                     # Live mobile simulator UI
│   ├── styles.css                     # PeerGrid design system CSS
│   └── app.js                         # Interactive state & logic
└── lib/
    ├── main.dart                      # App entrypoint & routing
    ├── theme/
    │   └── app_theme.dart             # PeerGrid cyan theme, colors & typography
    ├── models/
    │   ├── college.dart               # College data model
    │   ├── event.dart                 # Campus event model
    │   ├── community.dart             # Community & Post models
    │   ├── review.dart                # Student review model
    │   ├── prediction_data.dart       # Prediction input & result models
    │   └── user_profile.dart          # User profile model
    ├── data/
    │   └── mock_data.dart             # Realistic dataset matching Doc1.pdf
    ├── widgets/
    │   ├── custom_bottom_nav.dart     # Pill bottom bar (Home, Add +, Search)
    │   ├── college_card.dart          # Top colleges card widget
    │   ├── event_card.dart            # Upcoming events card widget
    │   ├── community_card.dart        # Community join card widget
    │   ├── review_card.dart           # Review card with like/comment counter
    │   ├── rating_bar_chart.dart      # 5-star to 1-star visual breakdown bar
    │   └── custom_text_field.dart     # Reusable styled inputs
    └── screens/
        ├── splash/
        │   └── splash_screen.dart     # Animated logo splash
        ├── auth/
        │   ├── login_screen.dart      # Sign In screen
        │   └── signup_screen.dart     # Sign Up screen
        ├── navigation_shell.dart      # Bottom navigation coordinator
        ├── home/
        │   └── home_screen.dart       # Home Dashboard (Doc1.pdf Screen 1)
        ├── colleges/
        │   ├── college_discovery_screen.dart # College discovery & city filters
        │   └── college_detail_screen.dart    # CET Trivandrum Details (Doc1.pdf Screen 6)
        ├── prediction/
        │   └── prediction_screen.dart # Predict your college (Doc1.pdf Screen 4)
        ├── events/
        │   └── events_screen.dart     # Events list (Doc1.pdf Screen 2)
        ├── community/
        │   ├── community_screen.dart  # Communities & Feed (Doc1.pdf Screen 3)
        │   └── create_post_dialog.dart# Campus post creator modal
        ├── profile/
        │   └── profile_screen.dart    # Profile & settings (Doc1.pdf Screen 5)
        └── search/
            └── search_screen.dart     # Multi-tab search across the app
```

---

## 🚀 Running the Flutter App

### 1. Install Flutter (if not yet installed)
If Flutter is not yet configured in your Windows environment:
```powershell
# Using Windows Package Manager (recommended):
winget install Google.Flutter
```
*Or download the Flutter SDK from [flutter.dev](https://docs.flutter.dev/get-started/install/windows/mobile) and add `flutter/bin` to your environment PATH.*

### 2. Fetch Dependencies
```bash
flutter pub get
```

### 3. Launch App
```bash
# Run on an Android Emulator or connected device:
flutter run

# Or run as a Flutter Web app:
flutter run -d chrome
```

---

## 🌐 Instant Browser Preview

To test the application immediately right now without waiting for Flutter SDK installation:

1. Simply double-click `preview/index.html` in your file explorer, OR
2. Start a lightweight local Python server:
```bash
python -m http.server 8080 --directory d:\PG\preview
```
Then navigate to `http://localhost:8080` in any web browser.
You will see the mobile device frame where you can interactively click through all 6 screens, test the predictor, register for events, join communities, and add reviews!
