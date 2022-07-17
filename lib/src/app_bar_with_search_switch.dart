// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The AppBar that can switch into search field.
///
/// Use [appBarBuilder] property to build default AppBar, with
/// a search button which will call [startSearch].
///
/// Use one of these callbacks to get text from [TextField]:
/// - onChanged,
/// - onSubmitted,
/// - or listen to textEditingController.
///
/// Also, there are callbacks for:
/// - onCleared,
/// - onClosed.
///
/// This widget support almost all property off [AppBar], but:
/// - [leading] and [title] properties are now expect - `Widget Function(context)?`:
///   - this is made in order to access `AppBarWithSearchSwitch.of(context)` methods,
///   - don't change them unless it necessary and use templates if you need to change them.
/// - [preferredSize] here is a method, you should set it via [toolbarWidth] and [toolbarHeight].
///
/// Here is a list of all other new properties(without mentioned above):
///     this.tooltipForClearButton = 'Clear',
///     this.tooltipForCloseButton = 'Close search',
///     this.closeSearchButton = Icons.close,
///     this.clearSearchButton = Icons.backspace,
///     this.fieldHintText = 'Search',
///     this.keepAppBarColors = true,
///     this.closeOnSubmit = true,
///     this.clearOnSubmit = false,
///     this.clearOnClose = false,
///     this.showClearButton = true,
///     this.closeOnClearTwice = true,
///     this.keyboardType = TextInputType.text,
///     this.toolbarWidth = double.infinity,
///     // And notifiers:
///     this.customIsActiveNotifier,      // have default static value
///     this.customTextEditingController, // have default static value
class AppBarWithSearchSwitch extends InheritedWidget
    implements PreferredSizeWidget {

  AppBarWithSearchSwitch({
    required this.appBarBuilder,
    Key? key,
    this.onChanged,
    this.onClosed,
    this.onSubmitted,
    this.onCleared,
    this.tooltipForClearButton = 'Clear',
    this.tooltipForCloseButton = 'Close search',
    this.closeSearchButton = Icons.close,
    this.clearSearchButton = Icons.backspace,
    this.fieldHintText = 'Search',
    this.keepAppBarColors = true,
    this.closeOnSubmit = true,
    this.clearOnSubmit = false,
    this.clearOnClose = false,
    this.showClearButton = true,
    this.closeOnClearTwice = true,
    this.keyboardType = TextInputType.text,
    this.toolbarWidth = double.infinity,
    //
    // > Notifiers
    //
    this.customIsActiveNotifier,
    this.customTextEditingController,
    //
    // > standard AppBar fields
    //
    this.leading, // converted to builder function
    this.title, // converted to builder function
    this.actions,
    this.automaticallyImplyLeading = true,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
  }) : super(
          key: key,
          child: _AppBarBuilder(
            showClearButton: showClearButton,
            controller: customTextEditingController ??
                AppBarWithSearchSwitch._fallBackController,
            onChange: onChanged,
          ),
        );

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final bool automaticallyImplyLeading;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final Widget? flexibleSpace;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final PreferredSizeWidget? bottom;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final double? elevation;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final double? scrolledUnderElevation;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final Color? shadowColor;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final Color? surfaceTintColor;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final ShapeBorder? shape;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final Color? backgroundColor;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final Color? foregroundColor;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final IconThemeData? iconTheme;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final IconThemeData? actionsIconTheme;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final bool primary;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final bool? centerTitle;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final bool excludeHeaderSemantics;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final double? titleSpacing;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final double toolbarOpacity;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final double bottomOpacity;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final double? toolbarHeight;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final double? leadingWidth;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final TextStyle? toolbarTextStyle;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final TextStyle? titleTextStyle;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isActive] == true.
  final List<Widget>? actions;

  /// Used if custom [customIsActiveNotifier] not provided.
  static final _fallBackSearchIsActive = ValueNotifier(false);

  /// Used if custom [customTextEditingController] not provided.
  static final _fallBackController = TextEditingController(text: '');

  /// The [TextEditingController] for the [TextField] in search app bar.
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

  /// The [TextEditingController] for the [TextField] in search app bar.
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

  /// Width of AppBar, defaults to [double.infinity].
  ///
  /// Use this and [kToolbarHeight] to determinate [preferredSize].
  /// Note: height of [preferredSize] is [toolbarHeight]+[bottom].preferredSize.height
  final double toolbarWidth;

  @override
  Size get preferredSize => Size(toolbarWidth,
      (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0));

  /// Text in the field.
  ///
  /// Just a shortcut for [textEditingController.text].
  String get text => textEditingController.text;

  /// Builder function for [AppBar] by default (when search is inactive).
  ///
  /// Describe how [AppBar] should look before search is activated ([isActive] == false).
  /// Example:
  /// ...
  ///        appBarBuilder: (context) {
  ///          final appBar = AppBarWithSearchSwitch.of(context)!;
  ///
  ///          return AppBar(
  ///            title: Text('Your text here'),
  ///            actions: [
  ///              IconButton(
  ///                icon: Icon(appBar.text != '' ? Icons.search_off : Icons.search),
  ///                // tooltip: 'Last input: ${appBar.text}',
  ///                // color: appBar.text != '' ? Colors.tealAccent : null,
  ///                onPressed: () {
  ///                  appBar.startSearch(); // required
  ///                },
  ///              ),
  ///            ],
  ///          );
  ///        },
  final PreferredSizeWidget Function(BuildContext context) appBarBuilder;

  /// Builder function for title of search app bar, expected [TextField]. Defaults to null.
  ///
  /// You do NOT need to overwrite this. But if you still want to,
  /// please use snippet below as template:
  /// ```dart
  /// ...
  /// title: (context) {
  ///     final mainWidget = AppBarWithSearchSwitch.of(context)!;
  ///
  ///     return Directionality(
  ///       textDirection: Directionality.of(context),
  ///       child: TextField(
  ///         keyboardType: mainWidget.keyboardType,
  ///         decoration: InputDecoration(
  ///           hintText: mainWidget.fieldHintText,
  ///           enabledBorder: InputBorder.none,
  ///           focusedBorder: InputBorder.none,
  ///           border: InputBorder.none,
  ///         ),
  ///         // don't use onChanged: it don't catch cases then textEditController changed directly,
  ///         // instead we already subscribed to textEditController in initState.
  ///         // onChanged: mainWidget.onChanged,
  ///         onSubmitted: AppBarWithSearchSwitch.of(context)?.submitCallbackForTextField,
  ///         autofocus: true,
  ///         controller: mainWidget.textEditingController,
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  final Widget Function(BuildContext context)? title;

  /// Builder function for leading button of search app bar. Defaults to null.
  ///
  /// You do NOT need to overwrite this. But if you still want to,
  /// don't forget to add [stopSearch] callback:
  final Widget Function(BuildContext context)? leading;

  /// Clear TextEditController on close.
  final bool clearOnClose;

  /// Whether the text field should take place "in the existing app bar",
  /// meaning whether it has the same background or a flipped one. Defaults to true.
  final bool keepAppBarColors;

  /// Whether or not the search bar should close on submit. Defaults to true.
  final bool closeOnSubmit;

  /// The click on clear button will hide search field, if text field is already empty. Defaults to true.
  final bool closeOnClearTwice;

  /// Whether the text field should be cleared when it is submitted
  final bool clearOnSubmit;

  /// A callback which is invoked each time the text field's value changes.
  final void Function(String value)? onChanged;

  /// A callback fired every time the text is submitted.
  final void Function(String value)? onSubmitted;

  /// A callback which is fired when clear button is pressed.
  final VoidCallback? onCleared;

  /// A callback which gets fired on close button press.
  final VoidCallback? onClosed;

  /// Whether or not the search bar should add a clear input button, defaults to true.
  ///
  /// To add custom ClearButton - set this to false, and add you button via [actions].
  final bool showClearButton;

  /// What the hintText on the search bar should be. Defaults to 'Search'.
  final String fieldHintText;

  /// The tooltip for ClearButton of search text field. Defaults to 'Clear'.
  final String tooltipForClearButton;

  /// Tooltip for button close search.
  ///
  /// Default: 'Close search'.
  final String tooltipForCloseButton;

  /// Icon for button close search.
  ///
  /// Default: Icons.close
  final IconData? closeSearchButton;

  /// Icon for button clear search.
  ///
  /// Default: Icons.backspace
  final IconData? clearSearchButton;

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
  ///          AppBarWithSearchSwitch.of(context)?.startSearch();
  ///       },
  ///     ),
  ///   ],
  /// );
  /// ```
  void startSearch() {
    isActive.value = true;
  }

  /// Hide the search bar.
  ///
  /// Usually you don't need to call this method implicitly.
  void stopSearch() {
    isActive.value = false;
    if (clearOnClose) {
      textEditingController.text = '';
    }
    onClosed?.call();
  }

  /// Show/hide the search bar.
  ///
  /// See example in docs of [startSearch] method.
  void triggerSearch() {
    if (isActive.value) {
      stopSearch();
    } else {
      startSearch();
    }
  }

  /// Clear text in search field.
  void clearText() {
    textEditingController.text = '';
    onCleared?.call();
  }

  /// In case you implement you own [title] builder, use this as callback for [TextField].[onSubmitted].
  ///
  /// Otherwise [onSubmit], [closeOnSubmit] and [clearOnSubmit] would not work.
  void submitCallbackForTextField(val) {
    if (closeOnSubmit) {
      stopSearch();
    }
    if (clearOnSubmit) {
      textEditingController.text = '';
    }
    onSubmitted?.call(val);
  }
}

class _AppBarBuilder extends StatefulWidget {
  const _AppBarBuilder({
    required this.controller,
    required this.showClearButton,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final void Function(String value)? onChange;
  final TextEditingController controller;
  final bool showClearButton;

  @override
  State<_AppBarBuilder> createState() => _AppBarBuilderState();
}

class _AppBarBuilderState extends State<_AppBarBuilder> {
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
                    : _LeadingIconBackButton(buttonColor: buttonColor),
                title: mainWidget.title != null
                    ? mainWidget.title?.call(context)
                    : const _SearchTextField(),
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
                    _ClearIconButton(
                      mainWidget: mainWidget,
                      buttonColor: buttonColor,
                    ),
                  //
                  // > clear or close button
                  //
                  if (mainWidget.showClearButton &&
                      mainWidget.closeOnClearTwice)
                    _ClearOrCloseIconButton(
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

class _ClearOrCloseIconButton extends StatelessWidget {
  const _ClearOrCloseIconButton({
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
      icon: _hasText ? const Icon(Icons.backspace) : const Icon(Icons.close),
      color: mainWidget.keepAppBarColors ? null : buttonColor,
      onPressed: () {
        if (_hasText) {
          mainWidget.clearText();
        } else if (mainWidget.closeOnClearTwice) {
          mainWidget.stopSearch();
        }
      },
    );
  }
}

class _ClearIconButton extends StatelessWidget {
  const _ClearIconButton({
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
      icon: const Icon(Icons.backspace),
      color: mainWidget.keepAppBarColors ? null : buttonColor,
      onPressed: mainWidget.clearText,
    );
  }
}

class _LeadingIconBackButton extends StatelessWidget {
  const _LeadingIconBackButton({
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

class _SearchTextField extends StatelessWidget {
  const _SearchTextField({
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
                  selectionHandleColor: Colors.grey,
                  selectionColor: theme.backgroundColor,
                ),
              )
            : theme,
        child: TextField(
          cursorColor: mainWidget.keepAppBarColors
              ? theme.canvasColor
              : theme.textSelectionTheme.cursorColor,

          style: theme.textTheme.headline6?.copyWith(
            color: mainWidget.keepAppBarColors
                ? theme.canvasColor
                : theme.textTheme.headline6?.color,
          ),
          decoration: InputDecoration(
            hintText: mainWidget.fieldHintText,
            hintStyle: TextStyle(
              color: mainWidget.keepAppBarColors
                  ? theme.canvasColor
                  : theme.textTheme.headline6?.color,
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
          autofocus: true,
          controller: mainWidget.textEditingController,
        ),
      ),
    );
  }
}
