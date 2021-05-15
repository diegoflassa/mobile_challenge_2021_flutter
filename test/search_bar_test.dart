// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge_2021/enums/gender.dart';
import 'package:mobile_challenge_2021/interfaces/on_search.dart';
import 'package:mobile_challenge_2021/ui/widgets/search_bar_widget.dart';

class OnSearchImpl implements OnSearch {
  @override
  void clear() {
    // Do nothing
  }

  @override
  void onSearch(
      {String? query, String? nationality, Gender gender = Gender.UNKNOWN}) {
    expect(query, 'Alice');
    //expect(nationality, 'BR');
    expect(gender, Gender.MALE);
  }
}

void main() {
  MediaQuery _buildAppWithSearchBarWidget(SearchBarWidget searchBar,
      {ThemeData? theme}) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        theme: theme,
        home: Material(
          child: Builder(
            builder: (context) {
              return searchBar;
            },
          ),
        ),
      ),
    );
  }

  final _onSearchImpl = OnSearchImpl();

  flutter_test.testWidgets('Search Bar test', (tester) async {
    final searchBar = SearchBarWidget(onSearch: _onSearchImpl, isTest: true);
    // Build our app and trigger a frame.Key('search_button')));
    await tester.pumpWidget(_buildAppWithSearchBarWidget(searchBar));
    await tester.enterText(find.byKey(const Key('search_input')), 'Alice');
    await tester.tap(find.byKey(const Key('button_gender')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('gender_male')));
    await tester.tap(find.byKey(const Key('gender_dialog_ok')));
    await tester.tap(find.byKey(const Key('search_button')));
  });
}
