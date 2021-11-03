import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/presentation/widgets/tv_series_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_tv_series_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  final bool isSearchMovie;

  SearchPage({required this.isSearchMovie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                if (isSearchMovie) {
                  context
                      .read<SearchMovieBloc>()
                      .add(OnQueryMovieChanged(query));
                } else {
                  context
                      .read<SearchTvSeriesBloc>()
                      .add(OnQueryTvSeriesChanged(query));
                }
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            (isSearchMovie)
                ? BlocBuilder<SearchMovieBloc, SearchMovieState>(
                    builder: (context, state) {
                      if (state is SearchMovieLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchMovieHasData) {
                        final result = state.result;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = result[index];
                              return MovieCard(movie);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else if (state is SearchMovieNoData) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else if (state is SearchMovieError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  )
                : BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
                    builder: (context, state) {
                      if (state is SearchTvSeriesLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchTvSeriesHasData) {
                        final result = state.result;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final tvSeries = result[index];
                              return TvSeriesCard(tvSeries);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else if (state is SearchTvSeriesNoData) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else if (state is SearchTvSeriesError) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
