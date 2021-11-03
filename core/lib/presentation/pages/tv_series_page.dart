import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/presentation/bloc/tvseries/now_playing_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/popular_tv_series_bloc.dart';
import 'package:core/presentation/bloc/tvseries/top_tv_series_bloc.dart';
import 'package:core/presentation/pages/popular_tv_series_page.dart';
import 'package:core/utils/routes.dart';
import 'package:core/presentation/pages/top_rated_tv_series_page.dart';
import 'package:core/presentation/pages/tv_series_detail_page.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'now_playing_tv_series_page.dart';

class TvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series';

  @override
  _TvSeriesPageState createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<NowPlayingTvSeriesBloc>().add(GetNowPlayingTvSeriesEvent());
    context.read<PopularTvSeriesBloc>().add(GetPopularTvSeriesEvent());
    context.read<TopTvSeriesBloc>().add(GetTopTvSeriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tv Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SEARCH_ROUTE,
                arguments: false,
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    NowPlayingTvSeriesPage.ROUTE_NAME,
                  );
                },
              ),
              BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
                builder: (context, state) {
                  if (state is NowPlayingTvSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingTvSeriesHasData) {
                    return TvSeriesList(state.result);
                  } else if (state is NowPlayingTvSeriesNoData) {
                    return Text(state.message);
                  } else if (state is NowPlayingTvSeriesError) {
                    return Text(state.message);
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PopularTvSeriesPage.ROUTE_NAME,
                  );
                },
              ),
              BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                builder: (context, state) {
                  if (state is PopularTvSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvSeriesHasData) {
                    return TvSeriesList(state.result);
                  } else if (state is PopularTvSeriesNoData) {
                    return Text(state.message);
                  } else if (state is PopularTvSeriesError) {
                    return Text(state.message);
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TopRatedTvSeriesPage.ROUTE_NAME,
                  );
                },
              ),
              BlocBuilder<TopTvSeriesBloc, TopTvSeriesState>(
                builder: (context, state) {
                  if (state is TopTvSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopTvSeriesHasData) {
                    return TvSeriesList(state.result);
                  } else if (state is TopTvSeriesNoData) {
                    return Text(state.message);
                  } else if (state is TopTvSeriesError) {
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

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
