// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'app_bar_with_search_switch.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainWidget = AppBarWithSearchSwitch.of(context)!;
    final theme = Theme.of(context);

    return Directionality(
      textDirection: Directionality.of(context),
      child: Theme(
        data: mainWidget.keepAppBarColors
            ? theme.copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  // didn't work, https://github.com/flutter/flutter/issues/74890
                  selectionHandleColor: theme.splashColor,
                  selectionColor: theme.colorScheme.background.withOpacity(0.5),
                ),
              )
            : theme,
        child: TextField(
          cursorColor: mainWidget.keepAppBarColors
              ? theme.appBarTheme.backgroundColor ?? theme.canvasColor
              : theme.textSelectionTheme.cursorColor,

          style: theme.textTheme.headlineSmall?.copyWith(
            color: mainWidget.keepAppBarColors
                ? theme.appBarTheme.foregroundColor ?? theme.canvasColor
                : theme.textTheme.headlineSmall?.color,
          ),
          decoration: mainWidget.searchInputDecoration ??
              InputDecoration(
                hintText: mainWidget.fieldHintText,
                hintStyle: TextStyle(
                  color: (mainWidget.keepAppBarColors
                          ? theme.appBarTheme.foregroundColor ??
                              theme.canvasColor
                          : theme.textTheme.headlineSmall?.color)
                      ?.withOpacity(0.8),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
          // don't use onChanged: it don't catch cases then textEditController changed directly,
          // instead we already subscribed to textEditController in initState.
          // onChanged: mainWidget.onChanged,
          onSubmitted:
              AppBarWithSearchSwitch.of(context)?.submitCallbackForTextField,
          keyboardType: mainWidget.keyboardType,
          autofocus: !mainWidget
              .isSpeechMode.value, // don't show keyboard on speech recognition
          controller: mainWidget.textEditingController,
        ),
      ),
    );
  }
}
