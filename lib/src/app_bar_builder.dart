// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'app_bar_with_search_switch.dart';
import 'clear_or_close_icon_buttons.dart';
import 'leading_back_button.dart';
import 'search_text_field.dart';

class AppBarBuilder extends StatefulWidget {
  const AppBarBuilder({
    required this.controller,
    required this.showClearButton,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final void Function(String value)? onChange;
  final TextEditingController controller;
  final bool showClearButton;

  @override
  State<AppBarBuilder> createState() => AppBarBuilderState();
}

class AppBarBuilderState extends State<AppBarBuilder> {
  bool _hasText = true;

  @override
  void initState() {
    super.initState();

    if (widget.showClearButton) {
      widget.controller.addListener(onTextChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(onTextChanged);
    super.dispose();
  }

  void onTextChanged() {
    final controller = widget.controller;
    if (controller.text.isNotEmpty != _hasText) {
      setState(() {
        _hasText = controller.text.isNotEmpty;
      });
    }
    widget.onChange?.call(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppBarWithSearchSwitch.of(context)!.isActive,
      child: AppBarWithSearchSwitch.of(context)!.appBarBuilder(context),
      builder: (context, _, defaultAppBarBuilder) {
        final mainWidget = AppBarWithSearchSwitch.of(context)!;
        final theme = Theme.of(context);
        final buttonColor =
            mainWidget.keepAppBarColors ? null : theme.iconTheme.color;
        final isSearching = AppBarWithSearchSwitch.of(context)!.isActive.value;

        return !isSearching
            ? defaultAppBarBuilder!
            : AppBar(
                leading: mainWidget.leading != null
                    ? mainWidget.leading?.call(context)
                    : LeadingIconBackButton(buttonColor: buttonColor),
                title: mainWidget.title != null
                    ? mainWidget.title?.call(context)
                    : const SearchTextField(),
                backgroundColor:
                    mainWidget.keepAppBarColors ? null : theme.canvasColor,
                // backgroundColor: mainWidget.backgroundColor,

                automaticallyImplyLeading: mainWidget.automaticallyImplyLeading,
                flexibleSpace: mainWidget.flexibleSpace,
                bottom: mainWidget.bottom,
                elevation: mainWidget.elevation,
                scrolledUnderElevation: mainWidget.scrolledUnderElevation,
                shadowColor: mainWidget.shadowColor,
                surfaceTintColor: mainWidget.surfaceTintColor,
                shape: mainWidget.shape,
                foregroundColor: mainWidget.foregroundColor,
                iconTheme: mainWidget.iconTheme,
                actionsIconTheme: mainWidget.actionsIconTheme,
                primary: mainWidget.primary,
                centerTitle: mainWidget.centerTitle,
                excludeHeaderSemantics: mainWidget.excludeHeaderSemantics,
                titleSpacing: mainWidget.titleSpacing,
                toolbarOpacity: mainWidget.toolbarOpacity,
                bottomOpacity: mainWidget.bottomOpacity,
                toolbarHeight: mainWidget.toolbarHeight,
                leadingWidth: mainWidget.leadingWidth,
                toolbarTextStyle: mainWidget.toolbarTextStyle,
                titleTextStyle: mainWidget.titleTextStyle,
                systemOverlayStyle: mainWidget.systemOverlayStyle,
                actions: [
                  //
                  // > clear button
                  //
                  if (mainWidget.showClearButton &&
                      !mainWidget.closeOnClearTwice &&
                      _hasText)
                    ClearIconButton(
                      mainWidget: mainWidget,
                      buttonColor: buttonColor,
                    ),
                  //
                  // > clear or close button
                  //
                  if (mainWidget.showClearButton &&
                      mainWidget.closeOnClearTwice)
                    ClearOrCloseIconButton(
                      mainWidget: mainWidget,
                      hasText: _hasText,
                      buttonColor: buttonColor,
                    ),
                  //
                  // > other actions
                  //
                  if (mainWidget.actions != null) ...mainWidget.actions!
                ],
              );
      },
    );
  }
}
