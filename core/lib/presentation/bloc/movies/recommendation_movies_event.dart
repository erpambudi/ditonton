part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesEvent extends Equatable {
  const RecommendationMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendationMoviesEvent extends RecommendationMoviesEvent {
  final int id;

  GetRecommendationMoviesEvent({required this.id});
}
