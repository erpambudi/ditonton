import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/bloc/movies/top_movies_bloc.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopMoviesBloc extends MockBloc<TopMoviesEvent, TopMoviesState>
    implements TopMoviesBloc {}

class TopMoviesEventFake extends Fake implements TopMoviesEvent {}

class TopMoviesStateFake extends Fake implements TopMoviesState {}

void main() {
  late MockTopMoviesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(TopMoviesEventFake());
    registerFallbackValue(TopMoviesStateFake());
  });

  setUp(() {
    mockBloc = MockTopMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopMoviesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopMoviesHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopMoviesError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
