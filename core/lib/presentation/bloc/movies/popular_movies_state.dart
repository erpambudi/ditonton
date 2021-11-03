part of 'popular_movies_bloc.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class MoviesEmpty extends PopularMoviesState {}

class MoviesLoading extends PopularMoviesState {}

class MoviesError extends PopularMoviesState {
  final String message;

  MoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesNoData extends PopularMoviesState {
  final String message;

  MoviesNoData(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesHasData extends PopularMoviesState {
  final List<Movie> result;

  MoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
