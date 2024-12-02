import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/quran/data/models/quran_list.dart';
import 'package:quran_app/features/quran/data/data_sources/remote/quran_api_service.dart';
import 'quran_search_event.dart';
import 'quran_search_state.dart';

class QuranSearchBloc extends Bloc<QuranSearchEvent, QuranSearchState> {
  final QuranApiService apiService;

  QuranSearchBloc(this.apiService) : super(QuranSearchInitial()) {
    on<QuranSearchQueryChanged>(_onQueryChanged);
  }

  Future<void> _onQueryChanged(
      QuranSearchQueryChanged event, Emitter<QuranSearchState> emit) async {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(QuranSearchInitial());
      return;
    }

    emit(QuranSearchLoading());

    try {
      // Ambil daftar surah dari API
      final response = await apiService.getSurahList();
      final surahList = response.data;

      // Filter surah berdasarkan query
      final filteredSurah = surahList.where((surah) {
        return surah.arabic.toLowerCase().contains(query) ||
            surah.latin.toLowerCase().contains(query) ||
            surah.translation.toLowerCase().contains(query);
      }).toList();

      if (filteredSurah.isEmpty) {
        emit(QuranSearchLoaded([]));
        return;
      }

      emit(QuranSearchLoaded(filteredSurah));
    } catch (error) {
      emit(QuranSearchError('Terjadi kesalahan: ${error.toString()}'));
    }
  }
}
