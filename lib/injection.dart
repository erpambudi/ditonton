import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_now_playing_tv_series.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_series_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series.dart';
import 'package:core/domain/usecases/get_watchlist_tv_series_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist_tv_series.dart';
import 'package:core/presentation/bloc/movies/detail_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/now_playing_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/watchlist_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/recommendation_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/top_movies_bloc.dart';
import 'package:core/presentation/bloc/tvseries/now_playing_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/recommendation_tv_series_bloc.dart';
import 'package:core/presentation/cubit/status_watchlist_movie_cubit.dart';
import 'package:core/presentation/cubit/status_watchlist_tv_serie_cubit.dart';
import 'package:core/presentation/bloc/tvseries/popular_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/top_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/watchlist_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/detail_tv_serie_bloc.dart';
import 'package:core/utils/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_series_bloc.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailMovieBloc(
      getMovie: locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => StatusWatchlistMovieCubit(
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => NowPlayingTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailTvSerieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => StatusWatchlistTvSerieCubit(
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTvSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
