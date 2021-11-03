import 'package:core/presentation/bloc/tvseries/now_playing_tv_series_bloc.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv-series';

  @override
  _NowPlayingTvSeriesPageState createState() => _NowPlayingTvSeriesPageState();
}

class _NowPlayingTvSeriesPageState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<NowPlayingTvSeriesBloc>().add(GetNowPlayingTvSeriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
          builder: (context, state) {
            if (state is NowPlayingTvSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTvSeriesHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvSeriesCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is NowPlayingTvSeriesNoData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is NowPlayingTvSeriesError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
