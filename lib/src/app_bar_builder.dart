// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';

import 'buttons/clear_or_close_icon_buttons.dart';
import 'buttons/leading_back_button.dart';
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
  bool isLastSpeechMode = false;
  late final FocusNode searchFocusNode;

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
    // if (widget.showClearButton) {
    widget.controller.addListener(onTextChanged);
    widget.textNotifier.addListener(onTextNotifierChanged);
    widget.isSpeechMode.addListener(onSpeechChanged);
    widget.isSearchMode.addListener(onSearchModeChanged);
    // }
    widget.isSearchMode.addListener(onSearchMode);
    searchFocusNode = FocusNode();
    //
    // > check is custom SpeechToText provided and init global var
    //
    // widget.isSpeechMode.addListener(showSnackBar);
  }

  void onSearchModeChanged() {
    if (widget.isSearchMode.value == false && widget.isSpeechMode.value) {
      widget.isSpeechMode.value = false;
      isLastSpeechMode = true;
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
    widget.isSearchMode.removeListener(onSearchMode);
    searchFocusNode.dispose();
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
    if (oldWidget.isSearchMode != widget.isSearchMode) {
      oldWidget.isSearchMode.removeListener(onSearchMode);
      widget.isSearchMode.addListener(onSearchMode);
    }
  }

  void onSearchMode() {
    AppBarWithSearchSwitch.of(context)?.searchFocusNode = searchFocusNode;
    if (widget.isSearchMode.value &&
        searchFocusNode.canRequestFocus &&
        !widget.isSpeechMode.value) {
      searchFocusNode.requestFocus();
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
    if (widget.textNotifier.value != controller.text) {
      widget.textNotifier.value = controller.text;
    }
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
        Widget child = _AppBarSwitch(
          // key: ValueKey(mainWidget.isSearchMode.value;),
          isSearching: mainWidget.isSearchMode.value,
          mainWidget: mainWidget,
          buttonColor: buttonColor,
          theme: theme,
          hasText: hasText,
          defaultAppBarWidget: defaultAppBarWidget!,
          focusNode: searchFocusNode,
        );

        if (mainWidget.animationOfSpeechBar != null) {
          child = mainWidget.animationOfSpeechBar!(SizedBox(
            key: ValueKey(mainWidget.isSpeechMode.value),
            child: child,
          ));
        }

        if (mainWidget.animation != null) {
          child = mainWidget.animation!(SizedBox(
            key: ValueKey(mainWidget.isSearchMode.value &&
                !mainWidget.isSpeechMode.value),
            child: child,
          ));
        }

        return child;
      },
    );
  }
}

class _AppBarSwitch extends StatelessWidget {
  const _AppBarSwitch({
    Key? key,
    required this.isSearching,
    required this.mainWidget,
    required this.buttonColor,
    required this.theme,
    required this.hasText,
    required this.defaultAppBarWidget,
    required this.focusNode,
  }) : super(key: key);

  final bool isSearching;
  final FocusNode focusNode;
  final Widget defaultAppBarWidget;

  final AppBarWithSearchSwitch mainWidget;
  final Color? buttonColor;
  final ThemeData theme;
  final bool hasText;

  @override
  Widget build(BuildContext context) {
    return !isSearching
        //
        // > default app bar
        //
        ? defaultAppBarWidget
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
                    : SearchTextField(focusNode: focusNode),
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
                    isSpeechMode: mainWidget.isSpeechMode,
                    textNotifier: mainWidget.textNotifier,
                    speech: mainWidget.speechEngine,
                    isListeningToSpeech: mainWidget.isListeningToSpeech,
                  ),
                ),
            ],
          );
  }
}
