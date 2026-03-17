# 📱 JOB FLUX — Flutter App

A complete Flutter Android app built from the JOB FLUX Figma design.

## 🎨 Design
- **Accent color**: `#1DCD9F` (teal/green)
- **Font**: Inter (all weights)
- **Target**: Android (360×800 base)

---

## 📁 Project Structure

```
lib/
├── main.dart                        # App entry point
├── theme/
│   └── app_theme.dart               # Colors, typography, theme
├── screens/
│   ├── splash_screen.dart           # Animated splash (logo + teal glow)
│   ├── onboarding_screen.dart       # 3-page onboarding + role selection
│   ├── login_screen.dart            # Login form
│   ├── signup_screen.dart           # Signup (Entrepreneur / Stagiaire)
│   ├── home_screen.dart             # Main feed (jobs or profiles)
│   ├── add_screen.dart              # Post opportunity (GIG/Stage/Work)
│   ├── profile_screen.dart          # Profile with Education/XP/Gigs tabs
│   └── notifications_screen.dart   # Notifications feed
└── widgets/
    ├── job_card.dart                # Accordion job listing card
    ├── profile_card.dart            # Compact profile list card
    └── bottom_nav_bar.dart          # Bottom navigation bar
```

---

## 🚀 Setup & Run

### Prerequisites
- Flutter SDK ≥ 3.0.0
- Android Studio or VS Code with Flutter plugin
- Android device or emulator

### Steps

```bash
# 1. Navigate to project folder
cd jobflux

# 2. Install dependencies
flutter pub get

# 3. Run on device/emulator
flutter run

# 4. Build APK
flutter build apk --release
```

---

## 📱 Screens Implemented

| Screen | Description |
|--------|-------------|
| Splash | Logo centered, teal glow animation |
| Onboarding | 3 slides with dots, role selection (Entrepreneur/Stagiaire) |
| Login | Email + password form |
| Sign Up | Entrepreneur (4 fields) or Stagiaire (5 fields) |
| Home – Stagiaire | Accordion job cards filterable by GIG/STAGE/WORK |
| Home – Entrepreneur | Profile list cards with Contact button |
| Add Post | 3-step wizard: select type → fill form → published |
| Profile | Banner, avatar, rating, tabs: Education / Expérience / Gigs |
| Notifications | Color-coded cards: refused (red), accepted (green), info (yellow), profile applications (white) |

---

## 🎨 Design Tokens

```dart
// Colors
accentColor: Color(0xFF1DCD9F)   // Primary teal
darkText:    Color(0xFF222222)
mediumText:  Color(0xFF454545)
grayText:    Color(0xFF7C7C7C)
liteAccent:  Color(0xFF87DEC7)   // Card borders

// Fonts (Inter)
H0: 48px ExtraBold
H1: 36px ExtraBold
H2: 32px ExtraBold
H3: 24px ExtraBold
H4: 18px ExtraBold
Body1: 16px Regular
Body2: 14px Regular
Body2Bold: 11px Bold
Tagline: 12px Regular
ButtonText: 16px Bold
```

---

## 🔧 Customization

To connect a real backend, replace the mock data in:
- `home_screen.dart` → `_mockJobs` and `_mockProfiles`
- `profile_screen.dart` → `_education`, `_experience`, `_gigs`
- `notifications_screen.dart` → `_notifications`

---

Built with ❤️ from Figma → Flutter
