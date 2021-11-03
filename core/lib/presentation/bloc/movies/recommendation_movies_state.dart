part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesState extends Equatable {
  const RecommendationMoviesState();

  @override
  List<Object> get props => [];
}

class MoviesEmpty extends RecommendationMoviesState {}

class MoviesLoading extends RecommendationMoviesState {}

class MoviesError extends RecommendationMoviesState {
  final String message;

  MoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesNoData extends RecommendationMoviesState {
  final String message;

  MoviesNoData(this.message);

  @override
  List<Object> get props => [message];
}

class MoviesHasData extends RecommendationMoviesState {
  final List<Movie> result;

  MoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
