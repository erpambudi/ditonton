part of 'status_watchlist_movie_cubit.dart';

abstract class StatusWatchlistMovieState extends Equatable {
  const StatusWatchlistMovieState();

  @override
  List<Object> get props => [];
}

class StatusWatchlistMovieInitial extends StatusWatchlistMovieState {}

class StatusWatchlistMovieLoading extends StatusWatchlistMovieState {}

class StatusWatchlistMovieLoaded extends StatusWatchlistMovieState {
  final bool status;

  StatusWatchlistMovieLoaded({required this.status});

  @override
  List<Object> get props => [status];
}

class StatusWatchlistMovieError extends StatusWatchlistMovieState {}
