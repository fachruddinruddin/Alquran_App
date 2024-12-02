import 'package:flutter/material.dart';

class QuranSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const QuranSearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Cari Ayat atau Surah',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
