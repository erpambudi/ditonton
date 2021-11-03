part of 'top_tv_series_bloc.dart';

abstract class TopTvSeriesEvent extends Equatable {
  const TopTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class GetTopTvSeriesEvent extends TopTvSeriesEvent {}
