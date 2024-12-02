import 'package:flutter/material.dart';

class QuranAyahPage extends StatelessWidget {
  final String ayahId;

  const QuranAyahPage({Key? key, required this.ayahId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implementasi untuk menampilkan ayat berdasarkan ID
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayat $ayahId'),
      ),
      body: Center(
        child: Text('Menampilkan ayat dengan ID $ayahId'),
      ),
    );
  }
}
