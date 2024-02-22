// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'app_bar_with_search_switch.dart';

class SearchTextField extends StatelessWidget {
  final FocusNode focusNode;

  const SearchTextField({
    Key? key,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainWidget = AppBarWithSearchSwitch.of(context)!;
    final theme = mainWidget.theme ?? Theme.of(context);

    return Directionality(
      textDirection: Directionality.of(context),
      child: Theme(
        data: (mainWidget.keepAppBarColors && !theme.useMaterial3)
            ? theme.copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  selectionHandleColor: theme.splashColor,
                  selectionColor: theme.colorScheme.background.withOpacity(0.5),
                ),
              )
            : theme,
        child: TextField(
          focusNode: focusNode,
          cursorColor: (mainWidget.keepAppBarColors && !theme.useMaterial3)
              ? theme.appBarTheme.backgroundColor ?? theme.canvasColor
              : theme.textSelectionTheme.cursorColor,

          style: mainWidget.titleTextStyle?.copyWith(
                color: (mainWidget.keepAppBarColors && !theme.useMaterial3)
                    ? theme.appBarTheme.foregroundColor ?? theme.canvasColor
                    : mainWidget.titleTextStyle!.color,
              ) ??
              theme.textTheme.titleLarge?.copyWith(
                color: mainWidget.keepAppBarColors
                    ? theme.appBarTheme.foregroundColor ??
                        theme.appBarTheme.toolbarTextStyle?.color ??
                        theme.appBarTheme.titleTextStyle?.color ??
                        (theme.useMaterial3
                            ? theme.textTheme.titleLarge?.color
                            : theme.canvasColor)
                    : theme.textTheme.titleLarge?.color,
                fontWeight: FontWeight.w400,
              ),
          decoration: mainWidget.searchInputDecoration ??
              InputDecoration(
                hintText: mainWidget.fieldHintText,
                hintStyle: TextStyle(
                  color: ((mainWidget.keepAppBarColors && !theme.useMaterial3)
                          ? theme.appBarTheme.foregroundColor ??
                              theme.canvasColor
                          : theme.textTheme.headlineSmall?.color)
                      ?.withOpacity(0.7),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
          // Don't use parameter `onChanged` here:
          // - it don't catch cases then textEditController changed directly,
          // - it already subscribed to textEditController.
          onSubmitted: mainWidget.submitCallbackForTextField,
          keyboardType: mainWidget.keyboardType,
          autofocus: !mainWidget
              .isSpeechMode.value, // don't show keyboard on speech recognition
          controller: mainWidget.textEditingController,
        ),
      ),
    );
  }
}
