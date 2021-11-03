import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/bloc/movies/now_playing_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/top_movies_bloc.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<NowPlayingMoviesBloc>().add(GetNowPlayingMoviesEvent());
    context.read<PopularMoviesBloc>().add(GetPopularMoviesEvent());
    context.read<TopMoviesBloc>().add(GetTopMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SEARCH_ROUTE,
                arguments: true,
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is NowPlayingMoviesNoData) {
                    return Text(state.message);
                  } else if (state is NowPlayingMoviesError) {
                    return Text(state.message);
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is MoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is MoviesNoData) {
                    return Text(state.message);
                  } else if (state is MoviesError) {
                    return Text(state.message);
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopMoviesBloc, TopMoviesState>(
                builder: (context, state) {
                  if (state is TopMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is TopMoviesNoData) {
                    return Text(state.message);
                  } else if (state is TopMoviesError) {
                    return Text(state.message);
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
