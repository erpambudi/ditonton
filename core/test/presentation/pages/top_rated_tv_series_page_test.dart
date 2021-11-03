import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/presentation/bloc/tvseries/top_tv_series_bloc.dart';
import 'package:core/presentation/pages/top_rated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopTvSeriesBloc extends MockBloc<TopTvSeriesEvent, TopTvSeriesState>
    implements TopTvSeriesBloc {}

class TopTvSeriesEventFake extends Fake implements TopTvSeriesEvent {}

class TopTvSeriesStateFake extends Fake implements TopTvSeriesState {}

void main() {
  late MockTopTvSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(TopTvSeriesEventFake());
    registerFallbackValue(TopTvSeriesStateFake());
  });

  setUp(() {
    mockBloc = MockTopTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopTvSeriesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopTvSeriesHasData(<TvSeries>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopTvSeriesError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
