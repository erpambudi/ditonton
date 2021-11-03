part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object> get props => [];
}

class GetDetailMovieEvent extends DetailMovieEvent {
  final int id;

  GetDetailMovieEvent({required this.id});

  @override
  List<Object> get props => [id];
}
