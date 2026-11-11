import 'package:flutter/material.dart';

void main() {
  runApp(const QuranHifzApp());
}

/// Root of the Quran Hifz Companion App (sample project).
class QuranHifzApp extends StatelessWidget {
  const QuranHifzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran Hifz Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF059669),
        useMaterial3: true,
      ),
      home: const SurahListScreen(),
    );
  }
}

/// Simple data model for one surah.
class Surah {
  final int number;
  final String nameEn;
  final String nameAr;
  final int ayat;
  final double progress; // 0.0 -> 1.0 memorized

  const Surah(this.number, this.nameEn, this.nameAr, this.ayat, this.progress);
}

/// Sample data (the full app will load all 114 surahs).
const List<Surah> surahs = [
  Surah(1, 'Al-Fatiha', 'الفاتحة', 7, 1.0),
  Surah(2, 'Al-Baqarah', 'البقرة', 286, 0.35),
  Surah(36, 'Ya-Sin', 'يس', 83, 0.7),
  Surah(67, 'Al-Mulk', 'الملك', 30, 0.0),
  Surah(112, 'Al-Ikhlas', 'الإخلاص', 4, 1.0),
  Surah(113, 'Al-Falaq', 'الفلق', 5, 1.0),
  Surah(114, 'An-Nas', 'الناس', 6, 0.5),
];

/// Screen 1: list of surahs with memorization progress.
class SurahListScreen extends StatelessWidget {
  const SurahListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Surahs'),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: surahs.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final s = surahs[i];
          final done = s.progress >= 1.0;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: color.withOpacity(0.15),
              child: Text('${s.number}',
                  style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            ),
            title: Text('${s.nameEn}  •  ${s.nameAr}'),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${s.ayat} ayat'),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(value: s.progress, color: color),
                ],
              ),
            ),
            trailing: done ? Icon(Icons.check_circle, color: color) : null,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Player for ${s.nameEn} coming soon')),
              );
            },
          );
        },
      ),
    );
  }
}
