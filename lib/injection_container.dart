import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_app/features/quran/data/data_sources/local/quran_local_data_source.dart';
import 'package:quran_app/features/quran/data/data_sources/remote/quran_api_service.dart';
import 'package:quran_app/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:quran_app/features/quran/domain/repositories/quran_repository.dart';
import 'package:quran_app/features/quran/domain/usecases/add_to_last_read.dart';
import 'package:quran_app/features/quran/domain/usecases/get_quran_last_read.dart';
import 'package:quran_app/features/quran/domain/usecases/get_quran_settings.dart';
import 'package:quran_app/features/quran/domain/usecases/get_quran_list.dart';
import 'package:quran_app/features/quran/domain/usecases/get_quran_tafsir.dart';
import 'package:quran_app/features/quran/domain/usecases/get_surah_ayah.dart';
import 'package:quran_app/features/quran/domain/usecases/set_quran_settings.dart';
import 'package:quran_app/features/quran/presentation/bloc/quran_last_read/quran_last_read_bloc.dart';
import 'package:quran_app/features/quran/presentation/bloc/quran_settings/quran_settings_bloc.dart';
import 'package:quran_app/features/quran/presentation/bloc/quran_ayah/quran_ayah_bloc.dart';
import 'package:quran_app/features/quran/presentation/bloc/quran_list/quran_list_bloc.dart';
import 'package:quran_app/features/quran/presentation/bloc/quran_tafsir/quran_tafsir_bloc.dart';
import 'package:quran_app/features/quran/presentation/bloc/quran_search/quran_search_bloc.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  // Initialize Hive
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  locator.registerLazySingleton(() => Hive.box(name: 'quran'));

  // Dio for HTTP requests
  locator.registerLazySingleton<Dio>(() => Dio());

  // API Service
  locator.registerLazySingleton<QuranApiService>(
    () => QuranApiService(locator<Dio>()),
  );

  // Data Sources
  locator.registerLazySingleton<QuranLocalDataSource>(
    () => QuranLocalDataSourceImpl(locator()),
  );

  // Repository
  locator.registerLazySingleton<QuranRepository>(
    () => QuranRepositoryImpl(locator(), locator()),
  );

  // Use Cases
  locator.registerLazySingleton<GetQuranListUseCase>(
      () => GetQuranListUseCase(locator()));
  locator.registerLazySingleton<GetQuranAyahUseCase>(
      () => GetQuranAyahUseCase(locator()));
  locator.registerLazySingleton<GetQuranTafsirUseCase>(
      () => GetQuranTafsirUseCase(locator()));
  locator.registerLazySingleton<GetQuranSettingsUseCase>(
      () => GetQuranSettingsUseCase(locator()));
  locator.registerLazySingleton<SetQuranSettingsUseCase>(
      () => SetQuranSettingsUseCase(locator()));
  locator.registerLazySingleton<AddToLastReadUseCase>(
      () => AddToLastReadUseCase(locator()));
  locator.registerLazySingleton<GetQuranLastReadUseCase>(
      () => GetQuranLastReadUseCase(locator()));

  // Blocs
  locator.registerFactory<QuranListBloc>(() => QuranListBloc(locator()));
  locator.registerFactory<QuranAyahBloc>(() => QuranAyahBloc(locator()));
  locator.registerFactory<QuranTafsirBloc>(() => QuranTafsirBloc(locator()));
  locator.registerFactory<QuranSettingsBloc>(
      () => QuranSettingsBloc(locator(), locator()));
  locator.registerFactory<QuranLastReadBloc>(
      () => QuranLastReadBloc(locator(), locator()));

  // QuranSearchBloc
  locator.registerFactory<QuranSearchBloc>(
    () => QuranSearchBloc(locator<QuranApiService>()),
  );
}
