import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'surah.dart';

// same idea as the Car class in week 6
class Reciter {
  String name;
  String folder; // folder of this sheikh on everyayah.com

  Reciter(this.name, this.folder);

  // toString is what the dropdown displays (week 6)
  @override
  String toString() {
    return name;
  }

  // one mp3 per ayah: surah 3 digits + ayah 3 digits (1,1 -> 001001.mp3)
  String getUrl(int surah, int ayah) {
    String s = surah.toString().padLeft(3, '0');
    String a = ayah.toString().padLeft(3, '0');
    return 'https://everyayah.com/data/$folder/$s$a.mp3';
  }
}

// list of sheikhs, like the cars list in week 6
List<Reciter> reciters = [
  Reciter('Mahmoud Al-Husary', 'Husary_128kbps'),
  Reciter('Mishary Alafasy', 'Alafasy_128kbps'),
  Reciter('Abdul Basit', 'Abdul_Basit_Murattal_192kbps'),
  Reciter('Maher Al-Muaiqly', 'MaherAlMuaiqly128kbps'),
];

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final AudioPlayer _player = AudioPlayer();
  late Surah _surah;

  List<String> _ayat = [];        // text of each ayah (from the internet)
  bool _loading = true;
  bool _error = false;
  bool _started = false;

  int _ayah = 1;                  // current ayah number (1 to surah.ayat)
  int _repeat = 1;                // how many times to repeat each ayah (radio, week 6)
  int _played = 0;                // how many times the current ayah was played
  bool _playing = false;
  Reciter _reciter = reciters[0]; // dropdown (week 6)

  @override
  void initState() {
    super.initState();
    // when an ayah finishes: repeat it, or go to the next one
    _player.onPlayerComplete.listen((event) {
      _played++;
      if (_played < _repeat) {
        playAyah();                       // same ayah again
      }
      else if (_ayah < _surah.ayat) {
        setState(() { _ayah++; _played = 0; });
        playAyah();                       // next ayah
      }
      else {
        setState(() { _playing = false; _played = 0; }); // end of surah
      }
    });
  }

  // runs once when the page opens (context is ready here, not in initState)
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ayat.isEmpty && _loading && !_started) {
      _started = true; // load only one time
      // get the surah sent from home (ModalRoute, week 7)
      _surah = ModalRoute.of(context)!.settings.arguments as Surah;
      loadAyat();
    }
  }

  // close the player when we leave the page (dispose, week 7)
  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  // get the ayat text from the internet (try/catch, week 2)
  Future<void> loadAyat() async {
    try {
      final response = await http.get(
          Uri.parse('https://api.alquran.cloud/v1/surah/${_surah.number}/quran-uthmani'));
      final data = jsonDecode(response.body);
      List ayahs = data['data']['ayahs'];
      setState(() {
        _ayat = ayahs.map((a) => a['text'] as String).toList();
        _loading = false;
      });
    }
    catch (e) {
      setState(() { _loading = false; _error = true; });
    }
  }

  void playAyah() {
    _player.play(UrlSource(_reciter.getUrl(_surah.number, _ayah)));
    setState(() { _playing = true; });
  }

  void pause() {
    _player.pause();
    setState(() { _playing = false; });
  }

  void next() {
    if (_ayah < _surah.ayat) {
      setState(() { _ayah++; _played = 0; });
      if (_playing) playAyah();
    }
  }

  void previous() {
    if (_ayah > 1) {
      setState(() { _ayah--; _played = 0; });
      if (_playing) playAyah();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.92;
    if (width > 450) {
      width = 450;
    }

    // text of the current ayah
    String text = 'Loading...';
    if (_error) {
      text = 'Could not load the text. Check the internet.';
    }
    else if (!_loading && _ayat.length >= _ayah) {
      text = _ayat[_ayah - 1];
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('Player · ${_surah.name}'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(child: SizedBox(width: width, child: ListView(children: [
        const SizedBox(height: 16),
        Text(_surah.arabic, textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Text('Ayah $_ayah of ${_surah.ayat}', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
        const SizedBox(height: 16),

        // the ayah text in a white card
        Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(minHeight: 160),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)]),
          child: Center(child: Text(text, textAlign: TextAlign.center, textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 26, height: 1.8))),
        ),
        const SizedBox(height: 16),

        // choose the sheikh (DropdownMenu, week 6)
        DropdownMenu(
            width: width,
            label: const Text('Qari'),
            leadingIcon: const Icon(Icons.person),
            initialSelection: reciters[0],
            onSelected: (reciter) {
              setState(() { _reciter = reciter as Reciter; });
              if (_playing) playAyah(); // play the same ayah with the new sheikh
            },
            dropdownMenuEntries: reciters.map<DropdownMenuEntry<Reciter>>((Reciter r) {
              return DropdownMenuEntry(value: r, label: r.toString());
            }).toList()),
        const SizedBox(height: 8),

        // repeat each ayah 1x / 3x / 5x (Radio, week 6)
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.repeat),
          const Text(' Repeat ayah: '),
          Radio(value: 1, groupValue: _repeat, activeColor: Colors.green.shade700,
              onChanged: (val) => setState(() { _repeat = val as int; })),
          const Text('1×'),
          Radio(value: 3, groupValue: _repeat, activeColor: Colors.green.shade700,
              onChanged: (val) => setState(() { _repeat = val as int; })),
          const Text('3×'),
          Radio(value: 5, groupValue: _repeat, activeColor: Colors.green.shade700,
              onChanged: (val) => setState(() { _repeat = val as int; })),
          const Text('5×'),
        ]),
        const SizedBox(height: 8),

        // ⏮  ▶/⏸  ⏭
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(onPressed: previous, icon: const Icon(Icons.skip_previous, size: 44)),
          const SizedBox(width: 12),
          IconButton(onPressed: () => _playing ? pause() : playAyah(),
              icon: Icon(_playing ? Icons.pause_circle_filled : Icons.play_circle_fill,
                  size: 80, color: Colors.green.shade700)),
          const SizedBox(width: 12),
          IconButton(onPressed: next, icon: const Icon(Icons.skip_next, size: 44)),
        ]),
        const SizedBox(height: 24),
      ]))),
    );
  }
}