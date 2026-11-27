import 'package:flutter/material.dart';
import 'surah.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  // small white box with a number and a label
  Widget statBox(String value, String label, IconData icon) {
    return Expanded(child: Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)]),
      child: Column(children: [
        Icon(icon, color: Colors.green.shade700),
        Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey.shade700)),
      ]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // get the total sent from home (ModalRoute, week 7)
    final total = ModalRoute.of(context)!.settings.arguments as int;
    final List<Surah> memorized = memorizedSurahs();
    double percent = total / 6236; // all the Quran has 6236 ayat

    double width = MediaQuery.of(context).size.width * 0.92;
    if (width > 450) {
      width = 450;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Progress'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(child: SizedBox(width: width, child: ListView(children: [
        const SizedBox(height: 16),

        // memorized percentage with a progress bar
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.green.shade700, borderRadius: BorderRadius.circular(16)),
          child: Column(children: [
            const Text('Memorized', style: TextStyle(color: Colors.white70, fontSize: 16)),
            Text('${(percent * 100).toStringAsFixed(1)}%',
                style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: percent, minHeight: 10,
                backgroundColor: Colors.white24, color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
          ]),
        ),
        const SizedBox(height: 10),

        // numbers
        Row(children: [
          statBox('$total', 'ayat', Icons.menu_book),
          statBox('${memorized.length}', 'surahs', Icons.check_circle),
          statBox('-', 'day streak', Icons.local_fire_department),
        ]),
        const SizedBox(height: 16),

        // revision list = memorized surahs
        const Text("This week's revision", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (memorized.isEmpty)
          Text('Tick a surah in the list to add it here.', style: TextStyle(color: Colors.grey.shade700)),
        // same idea as forEach in week 2: one row for each memorized surah
        ...memorized.map((surah) => Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(children: [
            Icon(Icons.check, color: Colors.green.shade700),
            const SizedBox(width: 8),
            Expanded(child: Text(surah.toString())),
            Text(surah.arabic, style: const TextStyle(fontSize: 18)),
          ]),
        )),
        const SizedBox(height: 16),
        Text('Streak and revision dates will be saved in the database (next phase).',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
      ]))),
    );
  }
}