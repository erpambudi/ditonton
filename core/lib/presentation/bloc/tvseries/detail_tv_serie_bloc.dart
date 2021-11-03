import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_tv_serie_event.dart';
part 'detail_tv_serie_state.dart';

class DetailTvSerieBloc extends Bloc<DetailTvSerieEvent, DetailTvSerieState> {
  final GetTvSeriesDetail _getTvSerie;

  DetailTvSerieBloc(this._getTvSerie) : super(DetailTvSerieEmpty());

  @override
  Stream<DetailTvSerieState> mapEventToState(
    DetailTvSerieEvent event,
  ) async* {
    if (event is GetDetailTvSerieEvent) {
      yield DetailTvSerieLoading();
      final result = await _getTvSerie.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield DetailTvSerieError(failure.message);
        },
        (data) async* {
          yield DetailTvSerieHasData(data);
        },
      );
    }
  }
}
