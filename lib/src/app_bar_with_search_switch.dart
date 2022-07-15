// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// The AppBar with switch into search field.
///
/// Use [appBarBuilder] property to build default AppBar, with
/// a search button which will call [beginSearch].
class AppBarWithSearchSwitch extends InheritedWidget
    implements PreferredSizeWidget {
  AppBarWithSearchSwitch({
    required this.appBarBuilder,
    Key? key,
    this.onChanged,
    this.onClosed,
    this.onSubmitted,
    this.onCleared,
    this.fieldHintText = 'Search',
    this.keepBackgroundColor = true,
    this.closeOnSubmit = true,
    this.clearOnSubmit = false,
    this.clearOnClose = false,
    this.showClearButton = true,
    this.closeOnClearTwice = true,
    this.keyboardType = TextInputType.text,
    this.preferredHeight = kToolbarHeight,
    this.customIsActiveNotifier,
    this.customTextEditingController,
  }) : super(
          key: key,
          child: _ListenerBuilder(
            showClearButton: showClearButton,
            controller: customTextEditingController ??
                AppBarWithSearchSwitch._fallBackController,
            onChange: onChanged,
          ),
        );

  /// Used if custom [customIsActiveNotifier] not provided.
  static final _fallBackSearchIsActive = ValueNotifier(false);

  /// Used if custom [customTextEditingController] not provided.
  static final _fallBackController = TextEditingController(text: '');

  /// The textEditingController to be used in the textField.
  ///
  /// By default, used one controller for all instances, which allow it
  /// to remember last input text and share it across all instances.
  /// If this is not what you want:
  /// - use clearOnSubmit=true OR
  /// - use customTextEditingController = you own controller.
  TextEditingController get textEditingController =>
      customTextEditingController ?? _fallBackController;

  /// Indicator of whenever search bar is active.
  ///
  /// Can be set directly, like this:
  /// ```dart
  /// AppBarWithSearchSwitch.of(context).searchIsActive.value = true;
  /// ```
  ValueNotifier<bool> get isActive =>
      customIsActiveNotifier ?? _fallBackSearchIsActive;

  /// The [TextEditingController] to be used in the textField.
  ///
  /// If null, will be used default one.
  /// Use [textEditingController] getter to access this field.
  final TextEditingController? customTextEditingController;

  /// The [ValueNotifier] to be used to indicate: is text field visible.
  ///
  /// If null, will be used default one.
  /// Use [isActive] getter to access this field.
  final ValueNotifier<bool>? customIsActiveNotifier;

  /// Standard getter of the class.
  ///
  /// Note: there is a standard limitation:
  /// - context should be inside of AppBarWithSearchSwitch(belong to one of it children).
  static AppBarWithSearchSwitch? of(BuildContext context) {
    return (context
        .dependOnInheritedWidgetOfExactType<AppBarWithSearchSwitch>());
  }

  @override
  bool updateShouldNotify(AppBarWithSearchSwitch oldWidget) {
    return isActive != oldWidget.isActive;
  }

  /// Height of widget, defaults to [kToolbarHeight].
  final double preferredHeight;

  @override
  Size get preferredSize => Size(double.infinity, preferredHeight);

  /// Text in the field.
  ///
  /// Just a shortcut for [textEditingController.text].
  String get text => textEditingController.text;

  /// Builder function for AppBar.
  ///
  /// How it should look before search is activated.
  final PreferredSizeWidget Function(BuildContext context) appBarBuilder;

  /// Clear TextEditController on close.
  final bool clearOnClose;

  /// Whether the text field should take place "in the existing app bar",
  /// meaning whether it has the same background or a flipped one. Defaults to true.
  final bool keepBackgroundColor;

  /// Whether or not the search bar should close on submit. Defaults to true.
  final bool closeOnSubmit;

  /// The click on clear button will hide search field, if text field is empty. Defaults to true.
  final bool closeOnClearTwice;

  /// Whether the text field should be cleared when it is submitted
  final bool clearOnSubmit;

  /// A callback fired every time the text is submitted.
  final void Function(String value)? onSubmitted;

  /// A callback which is fired when clear button is pressed.
  final VoidCallback? onCleared;

  /// A callback which gets fired on close button press.
  final VoidCallback? onClosed;

  /// Whether or not the search bar should add a clear input button, defaults to true.
  final bool showClearButton;

  /// What the hintText on the search bar should be. Defaults to 'Search'.
  final String fieldHintText;

  /// A callback which is invoked each time the text field's value changes.
  final void Function(String value)? onChanged;

  /// The type of keyboard to use for editing the search bar text. Defaults to 'TextInputType.text'.
  final TextInputType keyboardType;

  /// Show the search bar.
  ///
  /// Example usage:
  /// ```dart
  /// AppBar(
  ///   //...
  ///   actions: [
  ///     IconButton(
  ///       icon: Icon(Icons.search, semanticLabel: "Search"),
  ///       onPressed: () {
  ///         beginSearch();
  ///       },
  ///     ),
  ///   ],
  /// );
  /// ```
  void beginSearch() {
    isActive.value = true;
  }

  /// Hide the search bar.
  ///
  /// Usually you don't need to call this method implicitly.
  void stopSearch() {
    isActive.value = false;
  }

  /// Show/hide the search bar.
  ///
  /// See example in docs of [beginSearch] method.
  void triggerSearch(context) {
    isActive.value = !isActive.value;
  }
}

class _ListenerBuilder extends StatefulWidget {
  const _ListenerBuilder({
    required this.controller,
    required this.showClearButton,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final void Function(String value)? onChange;
  final TextEditingController controller;
  final bool showClearButton;

  @override
  State<_ListenerBuilder> createState() => _ListenerBuilderState();
}

class _ListenerBuilderState extends State<_ListenerBuilder> {
  bool _hasText = true;

  // @override
  // void didUpdateWidget(AppBarWithSearchSwitch oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  // }

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
      builder: (context, _, child) {
        final mainWidget = AppBarWithSearchSwitch.of(context)!;
        final controller = mainWidget.textEditingController;
        final theme = Theme.of(context);
        final buttonColor =
            mainWidget.keepBackgroundColor ? null : theme.iconTheme.color;
        final isSearching = AppBarWithSearchSwitch.of(context)!.isActive.value;

        return !isSearching
            ? child!
            : AppBar(
                title: const _TextField(),
                backgroundColor:
                    mainWidget.keepBackgroundColor ? null : theme.canvasColor,
                leading: IconButton(
                  icon: const BackButtonIcon(),
                  color: buttonColor,
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  onPressed: () {
                    closeSearch(context);
                  },
                ),
                actions: !mainWidget.showClearButton
                    ? null
                    : <Widget>[
                        IconButton(
                          icon: const Icon(Icons.clear, semanticLabel: 'Clear'),
                          color: mainWidget.keepBackgroundColor
                              ? null
                              : buttonColor,
                          disabledColor: mainWidget.keepBackgroundColor
                              ? null
                              : theme.disabledColor,
                          onPressed: () {
                            if (_hasText) {
                              controller.text = '';
                              // controller.clear();
                              mainWidget.onCleared?.call();
                            } else if (mainWidget.closeOnClearTwice) {
                              closeSearch(context);
                            }
                          },
                        ),
                      ],
              );
      },
    );
  }

  closeSearch(context) {
    final mainWidget = AppBarWithSearchSwitch.of(context)!;
    mainWidget.isActive.value = false;
    if (mainWidget.clearOnClose) {
      mainWidget.textEditingController.text = '';
    }
    mainWidget.onClosed?.call();
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainWidget = AppBarWithSearchSwitch.of(context)!;
    final controller = mainWidget.textEditingController;
    final theme = Theme.of(context);

    return Directionality(
      textDirection: Directionality.of(context),
      child: TextField(
        keyboardType: mainWidget.keyboardType,
        decoration: InputDecoration(
          hintText: mainWidget.fieldHintText,
          hintStyle: mainWidget.keepBackgroundColor
              ? null
              : TextStyle(
                  color: theme.textTheme.headline4!.color,
                ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
        // don't use onChanged: it don't catch cases then textEditController changed directly,
        // instead we subscribe to textEditController in initState.
        // onChanged: mainWidget.onChanged,
        onSubmitted: (val) async {
          if (mainWidget.closeOnSubmit) {
            AppBarWithSearchSwitch.of(context)?.stopSearch();
          }

          if (mainWidget.clearOnSubmit) {
            mainWidget.textEditingController.text = '';
          }
          mainWidget.onSubmitted?.call(val);
        },
        autofocus: true,
        controller: controller,
      ),
    );
  }
}
