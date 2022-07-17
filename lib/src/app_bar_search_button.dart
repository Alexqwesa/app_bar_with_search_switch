// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'app_bar_with_search_switch.dart';

/// A default implementation of Search button for [AppBarWithSearchSwitch].
///
/// It should be used inside of [appBarBuilder] method of [AppBarWithSearchSwitch].
// Todo: also change state onSubmit
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

  /// If [AppBarWithSearchSwitch].[text] != '', this button will be red.
  final bool buttonHasTwoStates;

  /// Icon for search button then [AppBarWithSearchSwitch] has text.
  ///
  /// Default: [Icons].search
  /// If [buttonHasTwoStates] = false, used for both states.
  final IconData searchIcon;

  /// Icon for search button then [AppBarWithSearchSwitch] don't have text.
  ///
  /// Default: [Icons].search_off , used only if [buttonHasTwoStates] = true,
  final IconData searchOffIcon;

  const AppBarSearchButton({
    Key? key,
    this.toolTipLastText = 'Last input text: ',
    this.toolTipStartText = 'Click here to start search',
    this.buttonHasTwoStates = true,
    this.searchIcon = Icons.search,
    this.searchOffIcon = Icons.search_off,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AppBarWithSearchSwitch.of(context) == null) {
      return IconButton(
        icon: const Icon(Icons.error_outline),
        color: Colors.red,
        tooltip:
            'Error: This widget should be inside AppBarWithSearchSwitch widget',
        onPressed: () {},
      );
    }

    final appBar = AppBarWithSearchSwitch.of(context)!;

    return appBar.text == '' || !buttonHasTwoStates
        ? IconButton(
            icon: const Icon(Icons.search),
            tooltip: toolTipStartText,
            onPressed: () {
              appBar.triggerSearch();
            },
          )
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: FloatingActionButton(
              tooltip: '$toolTipLastText ${appBar.text}',
              elevation: 0,
              backgroundColor: Colors.redAccent,
              onPressed: () {
                appBar.triggerSearch();
              },
              child: const Icon(Icons.search_off),
            ),
          );
  }
}
