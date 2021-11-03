part of 'detail_tv_serie_bloc.dart';

abstract class DetailTvSerieState extends Equatable {
  const DetailTvSerieState();

  @override
  List<Object> get props => [];
}

class DetailTvSerieEmpty extends DetailTvSerieState {}

class DetailTvSerieLoading extends DetailTvSerieState {}

class DetailTvSerieError extends DetailTvSerieState {
  final String message;

  DetailTvSerieError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTvSerieHasData extends DetailTvSerieState {
  final TvSeriesDetail result;

  DetailTvSerieHasData(this.result);

  @override
  List<Object> get props => [result];
}
