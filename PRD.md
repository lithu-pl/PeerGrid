# PeerGrid — Project Requirements Document (PRD)

## 1. Project Overview

**Project Name:** PeerGrid  
**Project Type:** Student-focused mobile application  
**Frontend Technology:** Flutter  
**Programming Language:** Dart  
**Target Platform:** Mobile

### What is PeerGrid?

PeerGrid is a student-focused mobile application that brings college discovery, admission guidance, campus activities, student communities, and college reviews into one platform.

The main idea of PeerGrid is to create a social-network-like space for colleges where students can explore colleges, discover what is happening on different campuses, interact with communities, share their experiences, and make more informed college-related decisions.

College information is not limited to static details. Colleges can have events and activities uploaded to the platform, while students can contribute reviews and ratings. This creates a more interactive and student-oriented college discovery experience.

PeerGrid will also include a college prediction feature that uses a student's rank/score and other relevant academic details to show colleges that may be available to them. This feature is intended to be connected to the project's ML model in a later stage.

---

## 2. Problem Statement

Students often need to search through different sources to find college information, admission possibilities, campus events, communities, and student opinions.

There is a need for a single, simple platform where students can:

- Explore colleges.
- Check college ratings and reviews.
- Get an indication of possible colleges based on their rank/score.
- Discover college events and activities.
- Find and join student communities.
- Share their own college experiences.

PeerGrid aims to bring these functions together in one mobile application.

---

## 3. Project Objectives

The main objectives of PeerGrid are:

1. To provide a centralized platform for college discovery.
2. To help students explore colleges using ratings, reviews, and available information.
3. To provide a college prediction feature based on academic details such as rank/score.
4. To allow students to discover college events and activities.
5. To provide communities where students can interact and participate.
6. To allow students to share reviews and experiences about colleges.
7. To provide a simple, modern, and user-friendly mobile interface.

---

## 4. Target Users

The primary users of PeerGrid are:

- Students exploring colleges.
- Students looking for admission-related guidance.
- College students interested in campus events.
- Students interested in technical and other student communities.
- Students who want to read or share college experiences.

---

## 5. Main Features and Requirements

### 5.1 User Authentication

The application should provide:

- Sign Up
- Sign In
- Username/email and password fields
- Forgot Password option
- Social sign-in options such as Google and Facebook

For the initial frontend implementation, authentication may use mock/sample functionality until the backend is integrated.

---

### 5.2 Home Dashboard

The home screen should provide quick access to important PeerGrid features.

It should include:

- Personalized greeting.
- User profile access.
- College discovery section.
- Top Colleges section.
- College cards.
- College rating and review information.
- College location.
- Quick access to major features.
- Bottom navigation.

---

### 5.3 College Discovery

Students should be able to explore colleges through the application.

College information may include:

- College name
- College image
- Location
- Rating
- Number of reviews
- Available information about the college
- Student reviews
- Events and activities associated with the college

The interface should make college information easy to browse and understand.

---

### 5.4 College Prediction

The college prediction feature is one of the important features of PeerGrid.

Students should be able to enter relevant academic information such as:

- Examination
- Rank/Score
- Category
- Course preference

The system should then display possible colleges based on the available prediction data.

A prediction result can contain:

- College name
- Student rank/score
- Previous closing rank
- Chance indicator
- Prediction percentage or related result information

The prediction should be presented as an estimate based on available data and previous trends. It should not be presented as a guaranteed admission result.

The initial frontend should use mock/sample prediction data and remain ready for integration with the project's ML model.

---

### 5.5 Events

The Events section should allow students to discover college and campus activities.

Each event can contain:

- Event poster/image
- Event name
- College/organizer
- Date
- Time
- Venue
- Event details
- Register button

Students should be able to search and browse available events.

---

### 5.6 Student Communities

The Community section should provide a place for students to discover and interact with communities.

The section should include:

- Community search
- Community name
- Community description
- Member count
- Community logo/icon
- Join button
- Post/create-post option

Example communities include:

- IEEE
- TinkerHub
- EDC

The community system should be designed so that additional communities can be added later.

---

### 5.7 College Reviews and Ratings

Students should be able to view college reviews and ratings.

The feature should include:

- Overall college rating
- Number of reviews
- Rating distribution
- Student reviews
- Star ratings
- Like option
- Comment option
- Review submission option

Reviews should help students understand other students' experiences with a college.

---

### 5.8 User Profile

The profile section should allow users to view and manage their personal information.

It can include:

- Profile information
- College information
- Hobbies
- Chats
- Storage and Data
- Account settings
- Privacy settings

---

## 6. User Flow

The basic application flow is:

**Splash Screen**
→ **Welcome Screen**
→ **Sign In / Sign Up**
→ **Home Dashboard**
→ **Explore PeerGrid Features**

From the Home Dashboard, users can access:

- College Discovery
- College Prediction
- Events
- Communities
- College Reviews
- Profile

---

## 7. UI/UX Requirements

The frontend should follow the existing PeerGrid UI/UX design provided by the project team.

The provided UI designs should be treated as the primary visual reference.

The implementation should maintain:

- Blue/cyan visual theme
- Clean and modern appearance
- Rounded cards and buttons
- Consistent typography
- Clear icons
- Proper spacing
- Simple navigation
- Mobile-first layout
- Clear visual hierarchy

The frontend should not introduce a completely different visual style from the existing PeerGrid designs.

---

## 8. Frontend Technology Requirements

The PeerGrid frontend **must be developed using Flutter**.

### Technology

- **Framework:** Flutter
- **Language:** Dart
- **Platform:** Mobile

The application should use reusable Flutter widgets and maintain a clean, organized project structure.

Reusable components should be created for elements such as:

- Buttons
- Input fields
- Search bars
- Navigation bars
- College cards
- Event cards
- Community cards
- Review cards

The code should be easy for the project team to understand and modify.

---

## 9. Initial Data and Backend Integration

During the initial frontend development:

- Mock/sample data can be used.
- The application should work without a completed backend.
- Data should be structured so that APIs can be connected later.
- The college prediction interface should be prepared for ML model integration.
- Backend-dependent features should not prevent the UI from being demonstrated.

---

## 10. Navigation Requirements

The application should provide simple and consistent navigation.

The main navigation should provide access to:

- Home
- Create/Add
- Search

Secondary screens should include appropriate back navigation.

The profile icon should open the user's profile section.

---

## 11. Non-Functional Requirements

### Usability
The application should be simple enough for students to understand without extensive instructions.

### Performance
Screens should load smoothly and unnecessary UI complexity should be avoided.

### Responsiveness
The interface should adapt to different mobile screen sizes.

### Maintainability
The Flutter code should use reusable widgets and an organized structure.

### Consistency
Colors, typography, buttons, cards, and navigation should remain consistent throughout the application.

### Scalability
The frontend structure should allow additional colleges, events, communities, reviews, and backend services to be added later.

---

## 12. Expected Outcome

The completed frontend should provide a functional Flutter-based prototype of PeerGrid with:

- Authentication screens
- Home dashboard
- College discovery
- College prediction interface
- Events section
- Community section
- College reviews
- User profile
- Functional navigation
- Consistent PeerGrid UI/UX

The frontend should accurately represent the project's existing UI design and provide a strong base for later backend and ML integration.

---

## 13. Future Enhancements

Possible future additions include:

- Backend API integration
- ML-based college prediction
- Real-time notifications
- In-app chat
- Personalized college recommendations
- Event reminders
- Advanced college search and filtering
- More student communities
- Bookmarking colleges and events

---

## 14. Summary

PeerGrid aims to create a single student-oriented platform for discovering colleges and connecting with campus life.

By combining college discovery, prediction, events, communities, and student reviews, the application provides students with multiple useful functions within one mobile platform.

The frontend will be developed using **Flutter and Dart**, following the existing PeerGrid UI/UX designs. The initial implementation will use mock data where required and will be structured for future integration with the backend and ML components.
