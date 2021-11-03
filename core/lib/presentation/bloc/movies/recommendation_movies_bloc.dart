import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recommendation_movies_event.dart';
part 'recommendation_movies_state.dart';

class RecommendationMoviesBloc
    extends Bloc<RecommendationMoviesEvent, RecommendationMoviesState> {
  final GetMovieRecommendations _getMovies;

  RecommendationMoviesBloc(this._getMovies) : super(MoviesEmpty());

  @override
  Stream<RecommendationMoviesState> mapEventToState(
    RecommendationMoviesEvent event,
  ) async* {
    if (event is GetRecommendationMoviesEvent) {
      yield MoviesLoading();
      final result = await _getMovies.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield MoviesError(failure.message);
        },
        (data) async* {
          if (data.isEmpty) {
            yield MoviesNoData('Empty Data');
          } else {
            yield MoviesHasData(data);
          }
        },
      );
    }
  }
}
