import 'package:flutter/material.dart';
import 'surah.dart';
import 'player_page.dart';
import 'progress_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int total = 0;          // total memorized ayat (sum += / sum -=, week 8)
  Surah? lastSurah;       // last surah opened in the player

  // same as addItem() in week 8
  void addSurah(Surah surah, bool selected) {
    setState(() {
      surah.selected = selected;
      if (selected) {
        total += surah.ayat;
      }
      else {
        total -= surah.ayat;
      }
    });
  }

  // same as openPage2() in week 7: send the surah to the player page
  void openPlayer(Surah surah) {
    lastSurah = surah;
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const PlayerPage(),
            settings: RouteSettings(arguments: surah))
    );
  }

  // open the progress page and send the total (week 7)
  void openProgress() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ProgressPage(),
            settings: RouteSettings(arguments: total))
    ).then((value) => setState(() {})); // refresh when we come back
  }

  // bottom bar: 0 = Surahs, 1 = Player, 2 = Progress
  void onTabTapped(int index) {
    if (index == 1) {
      openPlayer(lastSurah ?? firstSurah());
    }
    else if (index == 2) {
      openProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery like week 8
    double itemWidth = MediaQuery.of(context).size.width * 0.92;
    if (itemWidth > 450) {
      itemWidth = 450; // keep a phone width on big screens
    }

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text('Surahs'),
          centerTitle: true,
          backgroundColor: Colors.green.shade700,
          foregroundColor: Colors.white,
          actions: [
            // reset button, same as week 8 part 5
            IconButton(onPressed: () => setState(() {
              resetSurahs();
              total = 0;
            }), icon: const Icon(Icons.restore))
          ],
        ),
        body: Column(children: [
          // header: image + total memorized ayat
          Container(
            width: itemWidth,
            margin: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(children: [
                Image.network(quranImage, width: itemWidth, height: 130, fit: BoxFit.cover),
                Container(width: itemWidth, height: 130, color: Colors.black45),
                Positioned(left: 16, bottom: 16, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Memorized ayat', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  Text('$total / 6236', style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                ])),
              ]),
            ),
          ),
          // the list takes the rest of the screen
          Expanded(child: ShowSurahs(addSurah: addSurah, openPlayer: openPlayer, itemWidth: itemWidth)),
        ]),
        // bottom bar like the wireframe: Surahs / Player / Progress
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          selectedItemColor: Colors.green.shade700,
          onTap: onTabTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Surahs'),
            BottomNavigationBarItem(icon: Icon(Icons.headphones), label: 'Player'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          ],
        )
    );
  }
}