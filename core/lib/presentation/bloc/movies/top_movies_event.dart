part of 'top_movies_bloc.dart';

abstract class TopMoviesEvent extends Equatable {
  const TopMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetTopMoviesEvent extends TopMoviesEvent {}
