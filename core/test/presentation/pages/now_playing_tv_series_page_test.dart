import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/presentation/bloc/tvseries/now_playing_tv_series_bloc.dart';
import 'package:core/presentation/pages/now_playing_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNowPlayingTvSeriesBloc
    extends MockBloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState>
    implements NowPlayingTvSeriesBloc {}

class NowPlayingTvSeriesEventFake extends Fake
    implements NowPlayingTvSeriesEvent {}

class NowPlayingTvSeriesStateFake extends Fake
    implements NowPlayingTvSeriesState {}

void main() {
  late MockNowPlayingTvSeriesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(NowPlayingTvSeriesEventFake());
    registerFallbackValue(NowPlayingTvSeriesStateFake());
  });

  setUp(() {
    mockBloc = MockNowPlayingTvSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvSeriesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(NowPlayingTvSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(NowPlayingTvSeriesHasData(<TvSeries>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state)
        .thenReturn(NowPlayingTvSeriesError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
