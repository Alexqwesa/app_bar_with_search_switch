// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../app_bar_with_search_switch.dart';

class LeadingIconBackButton extends StatelessWidget {
  const LeadingIconBackButton({
    required this.buttonColor,
    Key? key,
  }) : super(key: key);

  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      color: buttonColor,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        AppBarWithSearchSwitch.of(context)?.stopSearch();
      },
    );
  }
}
