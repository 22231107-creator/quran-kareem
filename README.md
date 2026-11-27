# 📖 Quran Kareem App

A Flutter mobile app that helps users **memorize and revise the Holy Quran**: browse all 114 surahs, listen to a qari ayah by ayah with repeat, and track memorization progress.

🌐 **Live demo:** https://22231107-creator.github.io/quran-kareem/

> Course project for **CSCI410: Mobile Applications** (Fall 2026)
> Student: **Maha Al-Hussein** · GitHub: `22231107-creator`

---

## ✨ Features

### 1. Surah List (UI Module)
- All **114 surahs** with Arabic and English names and number of ayat
- **Checkbox** to mark a surah as memorized
- **Total memorized ayat** shown at the top (`x / 6236`)
- **Reset** button to clear all selections
- Bottom navigation bar: **Surahs · Player · Progress**

### 2. Audio Player (Audio Module)
- Shows the **text of the current ayah** (Uthmani script)
- **"Ayah X of N"** indicator with ⏮ previous and ⏭ next
- Choose the **Qari**: Mahmoud Al-Husary, Mishary Alafasy, Abdul Basit, Maher Al-Muaiqly
- **Repeat each ayah** 1×, 3× or 5×, then move to the next ayah automatically

### 3. Progress (Progress Module)
- **Memorized percentage** with a progress bar
- Number of memorized **ayat** and **surahs**
- **This week's revision** list of memorized surahs
- Day streak and revision dates: *planned for the next phase (database)*

---

## 🗂️ Project Structure

```
lib/
├── main.dart            # App entry point: MaterialApp → Home()
├── home.dart            # Home page: total, reset, navigation, bottom bar
├── surah.dart           # Surah class, list of 114 surahs, ShowSurahs (ListView.builder)
├── player_page.dart     # Reciter class, ayah text, audio playback, repeat
└── progress_page.dart   # Memorized %, stats and revision list
```

### Concepts from class used in the project

| Week | Concept | Where |
|---|---|---|
| 4 | `MaterialApp`, `Scaffold`, `AppBar`, custom widgets | `main.dart`, all pages |
| 6 | Class + list + `toString()`, `DropdownMenu`, `Radio`, `Checkbox` | `Reciter`, qari dropdown, repeat options |
| 7 | `Navigator.push`, `RouteSettings(arguments:)`, `ModalRoute`, `dispose()` | Opening Player and Progress pages |
| 8 | `ListView.builder`, `Image.network`, `MediaQuery`, checkbox + total, reset | Surah list and home header |

---

## 🌿 Git Workflow

```
main  ←  dev  ←  feature/ui
                 feature/audio
                 feature/progress
```

1. Each module is built in its own `feature/*` branch, starting from `dev`
2. Small commits with clear messages
3. Tested, then merged into `dev`
4. `dev` is merged into `main` when stable

The `gh-pages` branch only holds the built web version for the live demo.

---

## 🚀 Run Locally

**Requirements:** Flutter SDK 3.x

```bash
git clone https://github.com/22231107-creator/quran-kareem.git
cd quran-kareem
flutter pub get
flutter run -d chrome
```

### Packages
- [`audioplayers`](https://pub.dev/packages/audioplayers): plays the recitation audio
- [`http`](https://pub.dev/packages/http): loads the ayah text

---

## 📚 Data Sources
- **Ayah text:** [AlQuran Cloud API](https://alquran.cloud/api) (`quran-uthmani` edition)
- **Recitation audio:** [EveryAyah.com](https://everyayah.com) (one mp3 per ayah)

---

## 🛣️ Next Phase
- Save progress in a **database** so it stays after closing the app
- **Day streak** and revision dates
- Highlight modes and font size for the ayah text