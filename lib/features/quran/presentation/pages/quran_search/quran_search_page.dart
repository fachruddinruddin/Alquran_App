import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/quran/domain/entities/quran_ayah.dart';
import 'package:quran_app/features/quran/domain/entities/quran_list.dart';
import 'package:quran_app/features/quran/presentation/bloc/quran_search/quran_search_bloc.dart';
import 'package:quran_app/features/quran/presentation/bloc/quran_search/quran_search_event.dart';
import 'package:quran_app/features/quran/presentation/bloc/quran_search/quran_search_state.dart';
import 'package:quran_app/features/quran/presentation/widgets/quran_search_bar.dart';
import 'package:quran_app/features/quran/presentation/pages/quran_ayah_page.dart';
import 'package:quran_app/features/quran/presentation/pages/quran_surah_page.dart';

class QuranSearchPage extends StatelessWidget {
  const QuranSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pencarian Ayat/Surah'),
      ),
      body: Column(
        children: [
          QuranSearchBar(
            controller: searchController,
            onChanged: (query) {
              context
                  .read<QuranSearchBloc>()
                  .add(QuranSearchQueryChanged(query));
            },
          ),
          Expanded(
            child: BlocBuilder<QuranSearchBloc, QuranSearchState>(
              builder: (context, state) {
                if (state is QuranSearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is QuranSearchLoaded) {
                  return ListView.builder(
                    itemCount: state.results.length,
                    itemBuilder: (context, index) {
  return ListTile(
    title: Text(state.results[index].arabic), // Tampilkan hasil pencarian
    onTap: () {
      // Navigasi ke halaman Ayah atau Surah berdasarkan hasil pencarian
      if (state.results[index] is QuranAyahEntity) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuranAyahPage(
              ayahId: state.results[index].id.toString(),
            ),
          ),
        );
      } else if (state.results[index] is QuranListEntity) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuranSurahPage(
              surahId: state.results[index].id.toString(),
            ),
          ),
        );
      }
    },
  );
},
                  );
                } else if (state is QuranSearchError) {
                  return Center(child: Text(state.message));
                }

                return const Center(
                    child: Text('Masukkan kata kunci untuk mencari.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
