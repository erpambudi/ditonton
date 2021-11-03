import 'package:core/presentation/bloc/movies/watchlist_movies_bloc.dart';
import 'package:core/presentation/bloc/tvseries/watchlist_tv_series_bloc.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMoviesBloc>().add(GetWatchlistMoviesEvent());
    context.read<WatchlistTvSeriesBloc>().add(GetWatchlistTvSeriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: PreferredSize(
            child: ColoredBox(
              color: Color(0xFF000A18),
              child: _tabBar,
            ),
            preferredSize: _tabBar.preferredSize,
          ),
        ),
        body: TabBarView(
          children: [
            _movieContent(),
            _tvSeriesContent(),
          ],
        ),
      ),
    );
  }

  TabBar get _tabBar => TabBar(
        indicatorColor: Colors.amberAccent,
        indicatorWeight: 3,
        tabs: [
          Tab(
            text: 'Movies',
          ),
          Tab(
            text: 'Tv Series',
          ),
        ],
      );

  Widget _movieContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMoviesBloc, WatchlistMoviesState>(
        builder: (context, state) {
          if (state is WatchlistMoviesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMoviesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.result[index];
                return MovieCard(movie);
              },
              itemCount: state.result.length,
            );
          } else if (state is WatchlistMoviesNoData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is WatchlistMoviesError) {
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _tvSeriesContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        builder: (context, state) {
          if (state is WatchlistTvSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvSeriesHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.result[index];
                return TvSeriesCard(tvSeries);
              },
              itemCount: state.result.length,
            );
          } else if (state is WatchlistTvSeriesNoData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is WatchlistTvSeriesError) {
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
