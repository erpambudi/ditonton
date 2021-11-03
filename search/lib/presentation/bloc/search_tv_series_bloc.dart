import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_tv_series.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries _searchMovies;

  SearchTvSeriesBloc(this._searchMovies) : super(SearchTvSeriesEmpty());

  @override
  Stream<SearchTvSeriesState> mapEventToState(
    SearchTvSeriesEvent event,
  ) async* {
    if (event is OnQueryTvSeriesChanged) {
      final query = event.query;

      if (query.isEmpty) {
        yield SearchTvSeriesEmpty();
      } else {
        yield SearchTvSeriesLoading();
        final result = await _searchMovies.execute(query);

        yield* result.fold(
          (failure) async* {
            yield SearchTvSeriesError(failure.message);
          },
          (data) async* {
            if (data.isEmpty) {
              yield SearchTvSeriesNoData('Search not found');
            } else {
              yield SearchTvSeriesHasData(data);
            }
          },
        );
      }
    }
  }

  @override
  Stream<Transition<SearchTvSeriesEvent, SearchTvSeriesState>> transformEvents(
    Stream<SearchTvSeriesEvent> events,
    TransitionFunction<SearchTvSeriesEvent, SearchTvSeriesState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }
}
