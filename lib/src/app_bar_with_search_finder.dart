// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';

/// Allow access to [AppBarWithSearchSwitch] everywhere in [Scaffold].
///
/// **How to use**:
/// [AppBarWithSearchFinder].of(context) in children of this widget
/// return [AppBarWithSearchSwitch]? of current [Scaffold].
///
/// Implementation details:
/// This is just a [Builder] widget with helper method [of]
/// witch return [AppBarWithSearchFinder]?.
class AppBarWithSearchFinder extends StatelessWidget {
  final WidgetBuilder builder;

  const AppBarWithSearchFinder({Key? key, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: builder);
  }

  /// Return [AppBarWithSearchSwitch] in children of [AppBarWithSearchFinder].
  ///
  /// Note: there is a standard limitation:
  /// - context should be inside of [AppBarWithSearchFinder] (belong to one of it children).
  static AppBarWithSearchSwitch? of(BuildContext context) {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold != null &&
        scaffold.hasAppBar &&
        (scaffold.widget.appBar.runtimeType == AppBarWithSearchSwitch)) {
      return (scaffold.widget.appBar as AppBarWithSearchSwitch);
    }

    return null;
  }
}
