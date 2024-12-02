import 'package:go_router/go_router.dart';
import 'package:quran_app/features/quran/domain/entities/quran_list.dart';
import 'package:quran_app/features/quran/presentation/pages/quran_ayah/quran_ayah.dart';
import 'package:quran_app/features/quran/presentation/pages/quran_home/quran_home.dart';
import 'package:quran_app/features/quran/presentation/pages/quran_search/quran_search_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const QuranHome(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => QuranSearchPage(),
    ),
    GoRoute(
      name: 'quran-ayah',
      path: '/quran-ayah',
      builder: (context, state) {
        QuranListEntity quranListEntity = state.extra as QuranListEntity;
        return QuranAyah(
          surah: quranListEntity,
        );
      },
    ),
  ],
);
