part of 'top_movies_bloc.dart';

abstract class TopMoviesState extends Equatable {
  const TopMoviesState();

  @override
  List<Object> get props => [];
}

class TopMoviesEmpty extends TopMoviesState {}

class TopMoviesLoading extends TopMoviesState {}

class TopMoviesError extends TopMoviesState {
  final String message;

  TopMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopMoviesNoData extends TopMoviesState {
  final String message;

  TopMoviesNoData(this.message);

  @override
  List<Object> get props => [message];
}

class TopMoviesHasData extends TopMoviesState {
  final List<Movie> result;

  TopMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
