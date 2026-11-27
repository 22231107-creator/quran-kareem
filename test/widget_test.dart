
import 'package:flutter_test/flutter_test.dart';
import 'package:quran_kareem/surah.dart';

void main() {
  test('first surah is Al-Fatiha with 7 ayat', () {
    final s = firstSurah();
    expect(s.number, 1);
    expect(s.ayat, 7);
  });
}
