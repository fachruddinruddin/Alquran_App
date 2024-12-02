import 'package:flutter/material.dart';

class QuranSurahPage extends StatelessWidget {
  final String surahId;

  const QuranSurahPage({Key? key, required this.surahId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implementasi untuk menampilkan surah berdasarkan ID
    return Scaffold(
      appBar: AppBar(
        title: Text('Surah $surahId'),
      ),
      body: Center(
        child: Text('Menampilkan surah dengan ID $surahId'),
      ),
    );
  }
}
