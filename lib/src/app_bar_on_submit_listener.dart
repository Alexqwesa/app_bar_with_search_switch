// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';

/// Listen on submit events of [AppBarWithSearchSwitch] of [Scaffold] and call [builder].
///
/// Just a simple wrapper on:
/// ```dart
/// ValueListenableBuilder(
///         valueListenable: AppBarWithSearchSwitch.of(context).textSubmitNotifier,
///         builder: builder,
///         child: child,
/// ),
/// ```
class AppBarOnSubmitListener extends StatelessWidget {
  final Widget? child;

  final ValueWidgetBuilder builder;

  const AppBarOnSubmitListener({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold != null &&
        scaffold.hasAppBar &&
        (scaffold.widget.appBar.runtimeType == AppBarWithSearchSwitch)) {
      final appBar = (scaffold.widget.appBar as AppBarWithSearchSwitch);

      return ValueListenableBuilder(
        valueListenable: appBar.submitNotifier,
        builder: builder,
        child: child,
      );
    } else {
      return Center(
        child: Text(
          'Error: This widget should be inside AppBarWithSearchSwitch widget,'
          'Or inside Scaffold that have AppBarWithSearchSwitch',
          style: Theme.of(context).textTheme.headline4,
        ),
      );
    }
  }

  /// Return [AppBarWithSearchSwitch] in children of [AppBarListener].
  ///
  /// Note: there is a standard limitation:
  /// - context should be inside of [AppBarListener] (belong to one of it children).
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
