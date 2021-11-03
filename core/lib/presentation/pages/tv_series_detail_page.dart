import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/presentation/bloc/tvseries/detail_tv_serie_bloc.dart';
import 'package:core/presentation/bloc/tvseries/recommendation_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/watchlist_tv_series_bloc.dart';
import 'package:core/presentation/cubit/status_watchlist_tv_serie_cubit.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-detail';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailTvSerieBloc>().add(GetDetailTvSerieEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTvSerieBloc, DetailTvSerieState>(
        builder: (context, state) {
          if (state is DetailTvSerieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailTvSerieHasData) {
            return SafeArea(
              child: DetailContent(
                state.result,
              ),
            );
          } else if (state is DetailTvSerieError) {
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
  final TvSeriesDetail tvSeries;

  DetailContent(this.tvSeries);

  @override
  _DetailContentState createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  void initState() {
    super.initState();
    context
        .read<RecommendationTvSeriesBloc>()
        .add(GetRecommendationTvSeriesEvent(widget.tvSeries.id));
    context
        .read<StatusWatchlistTvSerieCubit>()
        .loadWatchlistStatus(widget.tvSeries.id);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${widget.tvSeries.posterPath}',
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
                              widget.tvSeries.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<StatusWatchlistTvSerieCubit,
                                StatusWatchlistTvSerieState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (state is StatusWatchlistTvSerieLoaded) {
                                      if (state.status) {
                                        await context
                                            .read<StatusWatchlistTvSerieCubit>()
                                            .removeFromWatchlist(
                                                widget.tvSeries);
                                      } else {
                                        await context
                                            .read<StatusWatchlistTvSerieCubit>()
                                            .addWatchlist(widget.tvSeries);
                                      }

                                      final message = context
                                          .read<StatusWatchlistTvSerieCubit>()
                                          .watchlistMessage;

                                      if (message ==
                                              StatusWatchlistTvSerieCubit
                                                  .watchlistAddSuccessMessage ||
                                          message ==
                                              StatusWatchlistTvSerieCubit
                                                  .watchlistRemoveSuccessMessage) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(message)));

                                        context
                                            .read<WatchlistTvSeriesBloc>()
                                            .add(GetWatchlistTvSeriesEvent());
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
                                      (state is StatusWatchlistTvSerieLoaded)
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
                              _showGenres(widget.tvSeries.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvSeries.voteAverage}')
                              ],
                            ),
                            Row(
                              children: [
                                Text('Seasons :'),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.tvSeries.seasons.toString(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Total Episodes :'),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.tvSeries.totalEpisodes != null
                                        ? '${widget.tvSeries.totalEpisodes}'
                                        : '-',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvSeriesBloc,
                                RecommendationTvSeriesState>(
                              builder: (context, state) {
                                if (state is RecommendationTvSeriesLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecommendationTvSeriesError) {
                                  return Text(state.message);
                                } else if (state
                                    is RecommendationTvSeriesHasData) {
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
                                                TvSeriesDetailPage.ROUTE_NAME,
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
}
