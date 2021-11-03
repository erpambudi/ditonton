import 'package:about/about.dart';
import 'package:core/presentation/bloc/movies/detail_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/now_playing_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/watchlist_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/recommendation_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/top_movies_bloc.dart';
import 'package:core/presentation/bloc/tvseries/now_playing_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/popular_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/recommendation_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/top_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/watchlist_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/detail_tv_serie_bloc.dart';
import 'package:core/presentation/cubit/status_watchlist_movie_cubit.dart';
import 'package:core/presentation/cubit/status_watchlist_tv_serie_cubit.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/now_playing_tv_series_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/popular_tv_series_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/top_rated_tv_series_page.dart';
import 'package:core/presentation/pages/tv_series_detail_page.dart';
import 'package:core/presentation/pages/tv_series_page.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:core/presentation/widgets/custom_drawer.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_series_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<StatusWatchlistMovieCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<DetailTvSerieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<StatusWatchlistTvSerieCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: Material(
          child: CustomDrawer(
            content: HomeMoviePage(),
          ),
        ),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              final isSearchMovie = settings.arguments as bool;
              return CupertinoPageRoute(
                  builder: (_) => SearchPage(
                        isSearchMovie: isSearchMovie,
                      ));
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvSeriesPage());
            case PopularTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case NowPlayingTvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => NowPlayingTvSeriesPage());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvSeriesDetailPage(id: id),
                settings: settings,
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
