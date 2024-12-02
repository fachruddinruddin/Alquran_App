import 'package:equatable/equatable.dart';
import 'package:quran_app/features/quran/domain/entities/quran_list.dart';

abstract class QuranSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuranSearchInitial extends QuranSearchState {}

class QuranSearchLoading extends QuranSearchState {}

class QuranSearchLoaded extends QuranSearchState {
  final List<QuranListEntity> results;

  QuranSearchLoaded(this.results);

  @override
  List<Object?> get props => [results];
}

class QuranSearchError extends QuranSearchState {
  final String message;

  QuranSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
