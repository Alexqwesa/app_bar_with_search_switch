// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'app_bar_with_search_switch.dart';
import 'clear_or_close_icon_buttons.dart';
import 'leading_back_button.dart';
import 'search_text_field.dart';
import 'speech_to_text/speech_sub_bar_controller.dart';

class AppBarBuilder extends StatefulWidget {
  const AppBarBuilder({
    required this.showClearButton,
    required this.onChange,
    required this.controller,
    required this.hasText,
    required this.isSearchMode,
    required this.isSpeechMode,
    required this.textNotifier,
    required this.submitNotifier,
    Key? key,
  }) : super(key: key);

  final void Function(String value)? onChange;
  final bool showClearButton;
  final TextEditingController controller;
  final ValueNotifier<bool> hasText;
  final ValueNotifier<bool> isSearchMode;
  final ValueNotifier<String> textNotifier;
  final ValueNotifier<String> submitNotifier;
  final ValueNotifier<bool> isSpeechMode;

  @override
  State<AppBarBuilder> createState() => AppBarBuilderState();
}

class AppBarBuilderState extends State<AppBarBuilder> {
  bool hasText = false;

  // // Hot reload should always check AppBar height
  // @override
  // void reassemble() {
  //   if (!widget.isSearchMode.value) {
  //     widget.isSpeechMode.value = false;
  //   }
  //   // if (widget.isSpeechMode.value) {
  //   //   widget.isSearchMode.value = true;
  //   // }
  //   super.reassemble();
  //   showSnackBar();
  // }

  @override
  void initState() {
    super.initState();
    if (widget.showClearButton) {
      widget.controller.addListener(onTextChanged);
      widget.textNotifier.addListener(onTextNotifierChanged);
      widget.isSpeechMode.addListener(onSpeechChanged);
      widget.isSearchMode.addListener(onSearchModeChanged);
    }
    //
    // > check is custom SpeechToText provided and init global var
    //
    // widget.isSpeechMode.addListener(showSnackBar);
  }

  void onSearchModeChanged() {
    if (widget.isSearchMode.value == false) {
      widget.isSpeechMode.value = false;
    }
  }

  void onSpeechChanged() {
    showSnackBar();
  }

  /// Force repaint scaffold to update AppBar height
  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: SizedBox.shrink(),
      // content: SpeechRecognizingAppBar(
      //   isSpeechMode: widget.isSpeechMode,
      //   textNotifier: widget.textNotifier,
      // ),
      duration: Duration(milliseconds: 1),
      animation: null,
      elevation: 0,
      padding: EdgeInsets.zero,
    ));
  }

  @override
  void dispose() {
    widget.controller.removeListener(onTextChanged);
    widget.textNotifier.removeListener(onTextNotifierChanged);
    widget.isSpeechMode.removeListener(onSpeechChanged);
    widget.isSearchMode.removeListener(onSearchModeChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(AppBarBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(onTextChanged);
      widget.controller.addListener(onTextChanged);
    }
    if (oldWidget.textNotifier != widget.textNotifier) {
      oldWidget.textNotifier.removeListener(onTextNotifierChanged);
      widget.textNotifier.addListener(onTextNotifierChanged);
    }
    if (oldWidget.isSpeechMode != widget.isSpeechMode) {
      oldWidget.isSpeechMode.removeListener(onSpeechChanged);
      if (!widget.isSearchMode.value) {
        // for hot reload
        widget.isSpeechMode.value = false;
      }
      widget.isSpeechMode.addListener(onSpeechChanged);
    }
    if (oldWidget.isSearchMode != widget.isSearchMode) {
      oldWidget.isSearchMode.removeListener(onSearchModeChanged);
      widget.isSearchMode.addListener(onSearchModeChanged);
      if (widget.isSpeechMode.value) {
        // for hot reload
        widget.isSearchMode.value = true;
      }
    }
  }

  void onTextNotifierChanged() {
    final controller = widget.controller;
    final notifier = widget.textNotifier;
    if (controller.text != notifier.value) {
      controller.text = notifier.value;
    }
  }

  void onTextChanged() {
    final controller = widget.controller;
    if (controller.text.isNotEmpty != hasText) {
      setState(() {
        hasText = controller.text.isNotEmpty;
      });
      widget.hasText.value = hasText;
    }
    widget.textNotifier.value = controller.text;
    widget.onChange?.call(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedBuilder(
    //   animation: Listenable.merge([
    //     AppBarWithSearchSwitch.of(context)!.isSearchMode,
    //     AppBarWithSearchSwitch.of(context)!.isSpeechMode
    //   ]),

    final mainWidget = AppBarWithSearchSwitch.of(context)!;

    return ValueListenableBuilder(
      valueListenable: mainWidget.isSearchMode,
      child: mainWidget.appBarBuilder(context),
      builder: (context, _, defaultAppBarWidget) {
        final theme = Theme.of(context);
        final buttonColor =
            mainWidget.keepAppBarColors ? null : theme.iconTheme.color;
        final isSearching = mainWidget.isSearchMode.value;

        return !isSearching
            //
            // > default app bar
            //
            ? defaultAppBarWidget!
            //
            // > search app bar
            //
            : Column(
                children: [
                  AppBar(
                    leading: mainWidget.leading != null
                        ? mainWidget.leading?.call(context)
                        : LeadingIconBackButton(buttonColor: buttonColor),
                    title: mainWidget.title != null
                        ? mainWidget.title?.call(context)
                        : const SearchTextField(),
                    backgroundColor:
                        mainWidget.keepAppBarColors ? null : theme.canvasColor,
                    // backgroundColor: mainWidget.backgroundColor,

                    automaticallyImplyLeading:
                        mainWidget.automaticallyImplyLeading,
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
                          hasText)
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
                          hasText: hasText,
                          buttonColor: buttonColor,
                        ),
                      //
                      // > other actions
                      //
                      if (mainWidget.actions != null) ...mainWidget.actions!
                    ],
                  ),
                  //
                  // > speech sub bar
                  //
                  if (mainWidget.isSpeechMode.value &&
                      mainWidget.isSearchMode.value)
                    Expanded(
                      child: SpeechSubBarController(
                        isSpeechMode: widget.isSpeechMode,
                        textNotifier: widget.textNotifier,
                        speech: mainWidget.speechEngine,
                      ),
                    ),
                ],
              );
      },
    );
  }
}
