part of 'detail_tv_serie_bloc.dart';

abstract class DetailTvSerieEvent extends Equatable {
  const DetailTvSerieEvent();

  @override
  List<Object> get props => [];
}

class GetDetailTvSerieEvent extends DetailTvSerieEvent {
  final int id;

  GetDetailTvSerieEvent(this.id);
}
