import 'package:flutter/material.dart';

// same idea as the Item class in week 8 (item.dart)
class Surah {
  int number;     // surah number (used for the text and audio links)
  String name;    // english name
  String arabic;  // arabic name
  int ayat;       // number of ayat (like price in week 8)
  bool selected = false; // checkbox = memorized (same as week 8)

  Surah(this.number, this.name, this.arabic, this.ayat);

  @override
  String toString() {
    return '$number. $name ($ayat ayat)';
  }
}

// image shown at the top of the home page (Image.network, week 8)
const String quranImage =
    'https://images.unsplash.com/photo-1587617425953-9075d28b8c46?w=800&q=80&auto=format&fit=crop';

// all 114 surahs, static for now (database later)
List<Surah> _surahs = [
  Surah(1, 'Al-Fatiha', 'الفاتحة', 7),
  Surah(2, 'Al-Baqarah', 'البقرة', 286),
  Surah(3, 'Aal-Imran', 'آل عمران', 200),
  Surah(4, 'An-Nisa', 'النساء', 176),
  Surah(5, 'Al-Maidah', 'المائدة', 120),
  Surah(6, 'Al-Anam', 'الأنعام', 165),
  Surah(7, 'Al-Araf', 'الأعراف', 206),
  Surah(8, 'Al-Anfal', 'الأنفال', 75),
  Surah(9, 'At-Tawbah', 'التوبة', 129),
  Surah(10, 'Yunus', 'يونس', 109),
  Surah(11, 'Hud', 'هود', 123),
  Surah(12, 'Yusuf', 'يوسف', 111),
  Surah(13, 'Ar-Rad', 'الرعد', 43),
  Surah(14, 'Ibrahim', 'إبراهيم', 52),
  Surah(15, 'Al-Hijr', 'الحجر', 99),
  Surah(16, 'An-Nahl', 'النحل', 128),
  Surah(17, 'Al-Isra', 'الإسراء', 111),
  Surah(18, 'Al-Kahf', 'الكهف', 110),
  Surah(19, 'Maryam', 'مريم', 98),
  Surah(20, 'Taha', 'طه', 135),
  Surah(21, 'Al-Anbiya', 'الأنبياء', 112),
  Surah(22, 'Al-Hajj', 'الحج', 78),
  Surah(23, 'Al-Muminun', 'المؤمنون', 118),
  Surah(24, 'An-Nur', 'النور', 64),
  Surah(25, 'Al-Furqan', 'الفرقان', 77),
  Surah(26, 'Ash-Shuara', 'الشعراء', 227),
  Surah(27, 'An-Naml', 'النمل', 93),
  Surah(28, 'Al-Qasas', 'القصص', 88),
  Surah(29, 'Al-Ankabut', 'العنكبوت', 69),
  Surah(30, 'Ar-Rum', 'الروم', 60),
  Surah(31, 'Luqman', 'لقمان', 34),
  Surah(32, 'As-Sajdah', 'السجدة', 30),
  Surah(33, 'Al-Ahzab', 'الأحزاب', 73),
  Surah(34, 'Saba', 'سبأ', 54),
  Surah(35, 'Fatir', 'فاطر', 45),
  Surah(36, 'Ya-Sin', 'يس', 83),
  Surah(37, 'As-Saffat', 'الصافات', 182),
  Surah(38, 'Sad', 'ص', 88),
  Surah(39, 'Az-Zumar', 'الزمر', 75),
  Surah(40, 'Ghafir', 'غافر', 85),
  Surah(41, 'Fussilat', 'فصلت', 54),
  Surah(42, 'Ash-Shura', 'الشورى', 53),
  Surah(43, 'Az-Zukhruf', 'الزخرف', 89),
  Surah(44, 'Ad-Dukhan', 'الدخان', 59),
  Surah(45, 'Al-Jathiyah', 'الجاثية', 37),
  Surah(46, 'Al-Ahqaf', 'الأحقاف', 35),
  Surah(47, 'Muhammad', 'محمد', 38),
  Surah(48, 'Al-Fath', 'الفتح', 29),
  Surah(49, 'Al-Hujurat', 'الحجرات', 18),
  Surah(50, 'Qaf', 'ق', 45),
  Surah(51, 'Adh-Dhariyat', 'الذاريات', 60),
  Surah(52, 'At-Tur', 'الطور', 49),
  Surah(53, 'An-Najm', 'النجم', 62),
  Surah(54, 'Al-Qamar', 'القمر', 55),
  Surah(55, 'Ar-Rahman', 'الرحمن', 78),
  Surah(56, 'Al-Waqiah', 'الواقعة', 96),
  Surah(57, 'Al-Hadid', 'الحديد', 29),
  Surah(58, 'Al-Mujadilah', 'المجادلة', 22),
  Surah(59, 'Al-Hashr', 'الحشر', 24),
  Surah(60, 'Al-Mumtahanah', 'الممتحنة', 13),
  Surah(61, 'As-Saff', 'الصف', 14),
  Surah(62, 'Al-Jumuah', 'الجمعة', 11),
  Surah(63, 'Al-Munafiqun', 'المنافقون', 11),
  Surah(64, 'At-Taghabun', 'التغابن', 18),
  Surah(65, 'At-Talaq', 'الطلاق', 12),
  Surah(66, 'At-Tahrim', 'التحريم', 12),
  Surah(67, 'Al-Mulk', 'الملك', 30),
  Surah(68, 'Al-Qalam', 'القلم', 52),
  Surah(69, 'Al-Haqqah', 'الحاقة', 52),
  Surah(70, 'Al-Maarij', 'المعارج', 44),
  Surah(71, 'Nuh', 'نوح', 28),
  Surah(72, 'Al-Jinn', 'الجن', 28),
  Surah(73, 'Al-Muzzammil', 'المزمل', 20),
  Surah(74, 'Al-Muddaththir', 'المدثر', 56),
  Surah(75, 'Al-Qiyamah', 'القيامة', 40),
  Surah(76, 'Al-Insan', 'الإنسان', 31),
  Surah(77, 'Al-Mursalat', 'المرسلات', 50),
  Surah(78, 'An-Naba', 'النبأ', 40),
  Surah(79, 'An-Naziat', 'النازعات', 46),
  Surah(80, 'Abasa', 'عبس', 42),
  Surah(81, 'At-Takwir', 'التكوير', 29),
  Surah(82, 'Al-Infitar', 'الانفطار', 19),
  Surah(83, 'Al-Mutaffifin', 'المطففين', 36),
  Surah(84, 'Al-Inshiqaq', 'الانشقاق', 25),
  Surah(85, 'Al-Buruj', 'البروج', 22),
  Surah(86, 'At-Tariq', 'الطارق', 17),
  Surah(87, 'Al-Ala', 'الأعلى', 19),
  Surah(88, 'Al-Ghashiyah', 'الغاشية', 26),
  Surah(89, 'Al-Fajr', 'الفجر', 30),
  Surah(90, 'Al-Balad', 'البلد', 20),
  Surah(91, 'Ash-Shams', 'الشمس', 15),
  Surah(92, 'Al-Layl', 'الليل', 21),
  Surah(93, 'Ad-Duha', 'الضحى', 11),
  Surah(94, 'Ash-Sharh', 'الشرح', 8),
  Surah(95, 'At-Tin', 'التين', 8),
  Surah(96, 'Al-Alaq', 'العلق', 19),
  Surah(97, 'Al-Qadr', 'القدر', 5),
  Surah(98, 'Al-Bayyinah', 'البينة', 8),
  Surah(99, 'Az-Zalzalah', 'الزلزلة', 8),
  Surah(100, 'Al-Adiyat', 'العاديات', 11),
  Surah(101, 'Al-Qariah', 'القارعة', 11),
  Surah(102, 'At-Takathur', 'التكاثر', 8),
  Surah(103, 'Al-Asr', 'العصر', 3),
  Surah(104, 'Al-Humazah', 'الهمزة', 9),
  Surah(105, 'Al-Fil', 'الفيل', 5),
  Surah(106, 'Quraysh', 'قريش', 4),
  Surah(107, 'Al-Maun', 'الماعون', 7),
  Surah(108, 'Al-Kawthar', 'الكوثر', 3),
  Surah(109, 'Al-Kafirun', 'الكافرون', 6),
  Surah(110, 'An-Nasr', 'النصر', 3),
  Surah(111, 'Al-Masad', 'المسد', 5),
  Surah(112, 'Al-Ikhlas', 'الإخلاص', 4),
  Surah(113, 'Al-Falaq', 'الفلق', 5),
  Surah(114, 'An-Nas', 'الناس', 6),
];

// same as resetItems() in week 8 part 5
void resetSurahs() {
  _surahs.forEach((surah) => surah.selected = false);
}

// Al-Fatiha, opened by the Player tab if no surah was opened yet
Surah firstSurah() {
  return _surahs[0];
}

// used by the progress page: returns only the memorized surahs
List<Surah> memorizedSurahs() {
  List<Surah> result = [];
  _surahs.forEach((surah) {
    if (surah.selected) result.add(surah);
  });
  return result;
}

class ShowSurahs extends StatelessWidget {
  final double itemWidth;
  final Function(Surah, bool) addSurah;  // callback to home (week 6 + week 8)
  final Function(Surah) openPlayer;      // callback to open the player (week 7)

  const ShowSurahs({required this.addSurah, required this.openPlayer,
    required this.itemWidth, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _surahs.length,
        itemBuilder: (context, index) {
          return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Align(alignment: Alignment.topCenter,
              child: Container(
                  width: itemWidth,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  // card look: white box, round corners, light shadow
                  decoration: BoxDecoration(
                      color: _surahs[index].selected ? Colors.green.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
                  child: Row(children: [
                    // surah number in a green circle
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: CircleAvatar(
                        backgroundColor: Colors.green.shade700,
                        child: Text('${_surahs[index].number}', style: const TextStyle(color: Colors.white)))),
                    // names and ayat
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(_surahs[index].arabic, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('${_surahs[index].name}  •  ${_surahs[index].ayat} ayat',
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                    ])),
                    // checkbox = memorized (week 8) + play button (week 7)
                    Checkbox(value: _surahs[index].selected, activeColor: Colors.green.shade700,
                        onChanged: (value) => addSurah(_surahs[index], value as bool)),
                    IconButton(onPressed: () => openPlayer(_surahs[index]),
                        icon: Icon(Icons.play_circle_fill, size: 36, color: Colors.green.shade700)),
                  ]))));
        }
    );
  }
}