// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'app_bar_with_search_switch.dart';

class ClearOrCloseIconButton extends StatelessWidget {
  const ClearOrCloseIconButton({
    Key? key,
    required this.mainWidget,
    required bool hasText,
    required this.buttonColor,
  })  : _hasText = hasText,
        super(key: key);

  final AppBarWithSearchSwitch mainWidget;
  final bool _hasText;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: _hasText
          ? mainWidget.tooltipForClearButton
          : mainWidget.tooltipForCloseButton,
      icon: _hasText
          ? Icon(mainWidget.clearSearchIcon)
          : Icon(mainWidget.closeSearchIcon),
      color: mainWidget.keepAppBarColors ? null : buttonColor,
      onPressed: () {
        if (_hasText) {
          mainWidget.clearText(); //
        } else if (mainWidget.submitOnClearTwice &&
            mainWidget.closeOnClearTwice) {
          mainWidget.submitCallbackForTextField('');
        } else if (mainWidget.closeOnClearTwice) {
          mainWidget.stopSearch();
        }
      },
    );
  }
}

class ClearIconButton extends StatelessWidget {
  const ClearIconButton({
    Key? key,
    required this.mainWidget,
    required this.buttonColor,
  }) : super(key: key);

  final AppBarWithSearchSwitch mainWidget;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: mainWidget.tooltipForClearButton,
      icon: Icon(mainWidget.clearSearchIcon),
      color: mainWidget.keepAppBarColors ? null : buttonColor,
      onPressed: mainWidget.clearText,
    );
  }
}
