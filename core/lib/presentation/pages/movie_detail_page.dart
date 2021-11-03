import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/presentation/bloc/movies/detail_movie_bloc.dart';
import 'package:core/presentation/bloc/movies/recommendation_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/watchlist_movies_bloc.dart';
import 'package:core/presentation/cubit/status_watchlist_movie_cubit.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/movie-detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailMovieBloc>().add(GetDetailMovieEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailMovieHasData) {
            return SafeArea(
              child: DetailContent(
                state.result,
              ),
            );
          } else if (state is DetailMovieNoData) {
            return Text(state.message);
          } else if (state is DetailMovieError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatefulWidget {
  final MovieDetail movie;

  DetailContent(this.movie);

  @override
  _DetailContentState createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    super.initState();
    context
        .read<RecommendationMoviesBloc>()
        .add(GetRecommendationMoviesEvent(id: widget.movie.id));
    context
        .read<StatusWatchlistMovieCubit>()
        .loadWatchlistStatus(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            BlocBuilder<StatusWatchlistMovieCubit,
                                StatusWatchlistMovieState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (state is StatusWatchlistMovieLoaded) {
                                      if (state.status) {
                                        await context
                                            .read<StatusWatchlistMovieCubit>()
                                            .removeFromWatchlist(widget.movie);
                                      } else {
                                        await context
                                            .read<StatusWatchlistMovieCubit>()
                                            .addWatchlist(widget.movie);
                                      }

                                      final message = context
                                          .read<StatusWatchlistMovieCubit>()
                                          .watchlistMessage;

                                      if (message ==
                                              StatusWatchlistMovieCubit
                                                  .watchlistAddSuccessMessage ||
                                          message ==
                                              StatusWatchlistMovieCubit
                                                  .watchlistRemoveSuccessMessage) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(message)));

                                        context
                                            .read<WatchlistMoviesBloc>()
                                            .add(GetWatchlistMoviesEvent());
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(message),
                                              );
                                            });
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      (state is StatusWatchlistMovieLoaded)
                                          ? state.status
                                              ? Icon(Icons.check)
                                              : Icon(Icons.add)
                                          : SizedBox(
                                              height: 15,
                                              width: 15,
                                              child: CircularProgressIndicator(
                                                color: Colors.black,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime ?? 0),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationMoviesBloc,
                                RecommendationMoviesState>(
                              builder: (context, state) {
                                if (state is MoviesLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MoviesError) {
                                  return Text(state.message);
                                } else if (state is MoviesHasData) {
                                  return Container(
                                    height: 150,
                                    margin: EdgeInsets.only(bottom: 24),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = state.result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.result.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
