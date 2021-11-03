import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailModel extends Equatable {
  TvSeriesDetailModel({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
    required this.seasons,
    required this.totalEpisodes,
  });

  final String? backdropPath;
  final List<GenreModel> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;
  final int seasons;
  final int? totalEpisodes;

  factory TvSeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesDetailModel(
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        firstAirDate: json["first_air_date"],
        seasons: json["number_of_seasons"],
        totalEpisodes: json["number_of_episodes"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "id": id,
        "original_title": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "title": name,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "number_of_seasons": seasons,
        "number_of_episodes": totalEpisodes,
      };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      id: this.id,
      originalName: this.originalName,
      overview: this.overview,
      posterPath: this.posterPath,
      name: this.name,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      firstAirDate: this.firstAirDate,
      seasons: this.seasons,
      totalEpisodes: this.totalEpisodes,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        name,
        voteAverage,
        voteCount,
        firstAirDate,
        seasons,
        totalEpisodes,
      ];
}
