// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../app_bar_with_search_switch.dart';

/// A default implementation of Search button for [AppBarWithSearchSwitch].
///
/// It should be used inside of [Scaffold] with appBar: [AppBarWithSearchSwitch].
///
/// See also:
///  * [AppBarWithSearchSwitch] - required to be in the same [Scaffold] as this widget,
///  * [AppBarListener] - listen to [AppBarWithSearchSwitch],
///
// Todo: maybe change state onSubmit too?
class AppBarSearchButton extends StatelessWidget {
  /// A toolTip for Search button then [AppBarWithSearchSwitch] has text.
  ///
  /// Default: 'Last input text: '
  /// In actual tooltip it will be [toolTipLastText] + [AppBarWithSearchSwitch].[text]
  final String toolTipLastText;

  /// A toolTip for Search button before search begin.
  ///
  /// Default: 'Click here to start search'
  final String toolTipStartText;

  /// Change color of this button to [searchActiveButtonColor] when
  /// [AppBarWithSearchSwitch].[text] != ''.
  ///
  /// Default: true.
  final bool buttonHasTwoStates;

  /// If [buttonHasTwoStates] is true, change on submit event, otherwise on any edit.
  ///
  /// Default: false.
  final bool changeOnlyOnSubmit;

  /// Icon for search button then [AppBarWithSearchSwitch] don't have text.
  ///
  /// Default: [Icons].search
  /// If [buttonHasTwoStates] = false, used for both states.
  final IconData searchIcon;

  /// Icon for search button then [AppBarWithSearchSwitch] has text.
  ///
  /// Default: [Icons].search_off , used only if [buttonHasTwoStates] = true,
  final IconData searchActiveIcon;

  /// Icon for search button then [AppBarWithSearchSwitch] has text.
  ///
  /// Default: Colors.redAccent, used only if [buttonHasTwoStates] = true,
  final Color searchActiveButtonColor;

  const AppBarSearchButton({
    Key? key,
    this.toolTipLastText = 'Last input text: ',
    this.toolTipStartText = 'Click here to start search',
    this.buttonHasTwoStates = true,
    this.changeOnlyOnSubmit = false,
    this.searchIcon = Icons.search,
    this.searchActiveIcon = Icons.search_off,
    this.searchActiveButtonColor = Colors.redAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final AppBarWithSearchSwitch appBar;

    if (AppBarWithSearchSwitch.of(context) != null) {
      appBar = AppBarWithSearchSwitch.of(context)!;
    } else {
      final scaffold = Scaffold.maybeOf(context);
      if (scaffold != null &&
          scaffold.hasAppBar &&
          (scaffold.widget.appBar.runtimeType == AppBarWithSearchSwitch)) {
        appBar = (scaffold.widget.appBar as AppBarWithSearchSwitch);
      } else {
        return IconButton(
          icon: const Icon(Icons.error_outline),
          color: Colors.red,
          tooltip:
              'Error: This widget should be inside AppBarWithSearchSwitch widget,'
              'Or inside Scaffold that have AppBarWithSearchSwitch',
          onPressed: () {},
        );
      }
    }

    if (!buttonHasTwoStates) {
      return _StartSearchButton(
        toolTipStartText: toolTipStartText,
        appBar: appBar,
        searchIcon: searchIcon,
      );
    } else {
      return ValueListenableBuilder(
        valueListenable: appBar.hasText,
        builder: ((context, value, child) {
          return (changeOnlyOnSubmit
                  ? appBar.submitNotifier.value == ''
                  : appBar.text == '')
              ? _StartSearchButton(
                  toolTipStartText: toolTipStartText,
                  appBar: appBar,
                  searchIcon: searchIcon,
                )
              : Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FloatingActionButton(
                    tooltip: '$toolTipLastText ${appBar.text}',
                    elevation: 0,
                    backgroundColor: searchActiveButtonColor,
                    onPressed: () {
                      appBar.triggerSearch();
                    },
                    child: Icon(searchActiveIcon),
                  ),
                );
        }),
      );
    }
  }
}

class _StartSearchButton extends StatelessWidget {
  const _StartSearchButton({
    Key? key,
    required this.toolTipStartText,
    required this.appBar,
    required this.searchIcon,
  }) : super(key: key);

  final IconData searchIcon;
  final String toolTipStartText;
  final AppBarWithSearchSwitch appBar;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(searchIcon),
      tooltip: toolTipStartText,
      onPressed: () {
        appBar.triggerSearch();
      },
    );
  }
}
