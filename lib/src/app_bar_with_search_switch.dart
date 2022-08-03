// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_bar_builder.dart';

/// The [AppBar] that can switch into search field.
///
/// Use [appBarBuilder] property to build default AppBar with
/// a search button which will call [startSearch].
///
/// Use one of these callbacks to get text from [TextField]:
/// - [onChanged],
/// - [onSubmitted],
/// - or listen to [textEditingController].
///
/// Also, there are callbacks for:
/// - [onCleared],
/// - [onClosed].
///
/// This widget support almost ***all*** properties of [AppBar], but:
/// - [leading] and [title] properties are now expect - `Widget Function(context)?`:
///   - this is made in order to access `AppBarWithSearchSwitch.of(context)` methods in them,
///   - don't change them unless it necessary and use templates if you need to change them.
/// - [preferredSize] here is a method, you should set it via [toolbarWidth] and [toolbarHeight].
///
/// Here is a list of all other new properties(without mentioned above):
/// - this.[tooltipForClearButton] = 'Clear',
/// - this.[tooltipForCloseButton] = 'Close search',
/// - this.[closeSearchIcon] = Icons.close,
/// - this.[clearSearchIcon] = Icons.backspace,
/// - this.[fieldHintText] = 'Search',
/// - this.[keepAppBarColors] = true,
/// - this.[closeOnSubmit] = true,
/// - this.[clearOnSubmit] = false,
/// - this.[clearOnClose] = false,
/// - this.[showClearButton] = true,
/// - this.[closeOnClearTwice] = true,
/// - this.[keyboardType] = TextInputType.text,
/// - this.[toolbarWidth] = double.infinity,
/// - this.[searchInputDecoration],
/// - // And controller
/// - this.[customTextEditingController], // has default static value
/// - // And notifiers:
/// - this.[customIsSearchModeNotifier],      // has default static value
/// - this.[customHasText], // has default static value
/// - this.[customTextNotifier], // has default static value
/// - this.[customSubmitNotifier], // has default static value
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
    this.closeSearchIcon = Icons.close,
    this.clearSearchIcon = Icons.backspace,
    this.fieldHintText = 'Search',
    this.keepAppBarColors = true,
    this.closeOnSubmit = true,
    this.clearOnSubmit = false,
    this.clearOnClose = false,
    this.showClearButton = true,
    this.closeOnClearTwice = true,
    this.submitOnClearTwice = true,
    this.keyboardType = TextInputType.text,
    this.toolbarWidth = double.infinity,
    this.searchInputDecoration,
    //
    // > [ValueNotifier]s
    //
    this.customIsSearchModeNotifier,
    this.customIsActiveNotifier, // deprecated: use customIsSearchModeNotifier
    this.customTextNotifier,
    this.customSubmitNotifier,
    this.customHasText,
    //
    // > [TextEditingController]
    //
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
    // this.scrolledUnderElevation,
    this.shadowColor,
    // this.surfaceTintColor,
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
          child: AppBarBuilder(
            showClearButton: showClearButton,
            onChange: onChanged,
            hasText: customHasText ?? _hasTextGlobalFallBack,
            isSearchMode: customIsSearchModeNotifier ??
                customIsActiveNotifier ??
                _isSearchModeGlobalFallBack,
            textNotifier: customTextNotifier ?? _textNotifierGlobalFallBack,
            submitNotifier:
                customSubmitNotifier ?? _submitNotifierGlobalFallBack,
            controller: customTextEditingController ??
                _textEditingControllerGlobalFallBack,
          ),
        );

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final bool automaticallyImplyLeading;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final Widget? flexibleSpace;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final PreferredSizeWidget? bottom;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final double? elevation;

  // /// See [AppBar] documentation for help.
  // ///
  // /// This parameter is used then search is active: [isSearchMode] == true.
  // final double? scrolledUnderElevation;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final Color? shadowColor;

  // /// See [AppBar] documentation for help.
  // ///
  // /// This parameter is used then search is active: [isSearchMode] == true.
  // final Color? surfaceTintColor;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final ShapeBorder? shape;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final Color? backgroundColor;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final Color? foregroundColor;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final IconThemeData? iconTheme;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final IconThemeData? actionsIconTheme;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final bool primary;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final bool? centerTitle;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final bool excludeHeaderSemantics;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final double? titleSpacing;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final double toolbarOpacity;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final double bottomOpacity;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final double? toolbarHeight;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final double? leadingWidth;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final TextStyle? toolbarTextStyle;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final TextStyle? titleTextStyle;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// See [AppBar] documentation for help.
  ///
  /// This parameter is used then search is active: [isSearchMode] == true.
  final List<Widget>? actions;

  /// Read only [ValueNotifier] for the [TextField] in search app bar.
  ///
  /// If null, will be created default one.
  /// Use [hasText] getter to access or subscribe to this field.
  final ValueNotifier<bool>? customHasText;

  /// The [ValueNotifier] [textNotifier] for the [TextField] in search app bar.
  ///
  /// If null, will be created default one.
  /// Use [textNotifier] getter to access, change or subscribe to this field.
  final ValueNotifier<String>? customTextNotifier;

  /// The [ValueNotifier] [submitNotifier] for the [TextField] in search app bar.
  ///
  /// If null, will be created default one.
  /// Use [submitNotifier] getter to access or subscribe to this field.
  final ValueNotifier<String>? customSubmitNotifier;

  /// The [TextEditingController] for the [TextField] in search app bar.
  ///
  /// If null, will be created default one.
  /// Use [textEditingController] getter to access this field.
  final TextEditingController? customTextEditingController;

  /// The [ValueNotifier] to be used to indicate: is text field visible.
  ///
  /// If null, will be created default one.
  /// Use [isSearchMode] getter to access this field.
  final ValueNotifier<bool>? customIsSearchModeNotifier;

  /// The [ValueNotifier] [hasText] for the [TextField] in search app bar.
  ///
  /// Can be changed by parameter: [customHasText] = `ValueNotifier<bool>(false)`
  ValueNotifier<bool> get hasText =>
      customHasText ??
      _hasTextGlobalFallBack; //(super.child as AppBarBuilder).hasText;

  static final _hasTextGlobalFallBack = ValueNotifier<bool>(false);

  /// The [ValueNotifier] for the [TextField] in search app bar.
  ///
  /// Can be used to change text in [TextField] in search app bar.
  /// Can be changed by parameter: [customTextNotifier] = `ValueNotifier<String>('')`
  ValueNotifier<String> get textNotifier =>
      customTextNotifier ??
      _textNotifierGlobalFallBack; //(super.child as AppBarBuilder).textNotifier;

  static final _textNotifierGlobalFallBack = ValueNotifier<String>('');

  /// The [ValueNotifier] [submitNotifier] for the [TextField] in search app bar.
  ///
  /// Can be changed by parameter: [customSubmitNotifier] = `ValueNotifier<String>('')`
  ValueNotifier<String> get submitNotifier =>
      customSubmitNotifier ??
      _submitNotifierGlobalFallBack; //(super.child as AppBarBuilder).submitNotifier;

  static final _submitNotifierGlobalFallBack = ValueNotifier<String>('');

  /// The [TextEditingController] for the [TextField] in search app bar.
  ///
  /// Can be changed by parameter: [customTextEditingController] = you own controller.
  TextEditingController get textEditingController =>
      customTextEditingController ??
      _textEditingControllerGlobalFallBack; //(super.child as AppBarBuilder).controller;

  static final _textEditingControllerGlobalFallBack =
      TextEditingController(text: '');

  /// Indicator of whenever search bar is active.
  ///
  /// Can be set directly, like this:
  /// ```dart
  /// AppBarWithSearchSwitch.of(context).isSearchMode.value = true;
  /// ``
  /// Can be changed by parameter: [customIsSearchModeNotifier] = `ValueNotifier<bool>(false)`
  ValueNotifier<bool> get isSearchMode =>
      customIsSearchModeNotifier ?? (super.child as AppBarBuilder).isSearchMode;

  static final _isSearchModeGlobalFallBack = ValueNotifier<bool>(false);

  /// Standard getter of the class.
  ///
  /// Note: there is a standard limitation:
  /// - context should be inside of AppBarWithSearchSwitch(belong to one of it children).
  static AppBarWithSearchSwitch? of(BuildContext context) {
    return (context
        .dependOnInheritedWidgetOfExactType<AppBarWithSearchSwitch>());
  }

  /// Currently rebuild is triggered only if [isSearchMode] changed.
  @override
  bool updateShouldNotify(AppBarWithSearchSwitch oldWidget) {
    return isSearchMode != oldWidget.isSearchMode;
  }

  /// Width of AppBar, defaults to [double.infinity].
  ///
  /// Use this and [kToolbarHeight] to determinate [preferredSize].
  /// Note: height of [preferredSize] is [toolbarHeight]+[bottom].preferredSize.height
  final double toolbarWidth;

  /// Custom [InputDecoration] for Search [TextField].
  ///
  /// This option has no effect if [title] is used.
  ///
  /// If null used default:
  /// ```dart
  ///              InputDecoration(
  ///                 hintText: fieldHintText,
  ///                 hintStyle: TextStyle(
  ///                   color: keepAppBarColors
  ///                       ? Theme.of(context).canvasColor
  ///                       : Theme.of(context).textTheme.headline6?.color,
  ///                 ),
  ///                 enabledBorder: InputBorder.none,
  ///                 focusedBorder: InputBorder.none,
  ///                 border: InputBorder.none,
  ///               ),
  ///```
  final InputDecoration? searchInputDecoration;

  /// Standard overridden method of [PreferredSizeWidget].
  ///
  /// return Size of this widget with:
  /// - height = toolbarHeight + bottom.height
  /// - width = toolbarWidth
  @override
  Size get preferredSize => Size(toolbarWidth,
      (toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0));

  /// Text in the field.
  ///
  /// Just a shortcut for [textEditingController.text].
  String get text => textEditingController.text;

  /// Builder function for [AppBar] by default (when search is inactive).
  ///
  /// Describe how [AppBar] should look before search is activated ([isSearchMode] == false).
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
  ///         // or autofocus: !mainWidget.isSpeechMode.value, // don't show keyboard on speech recognition
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

  /// If [closeOnClearTwice]=true close button will also trigger [onSubmitted]. Defaults to true.
  final bool submitOnClearTwice;

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
  final IconData? closeSearchIcon;

  /// Icon for button clear search.
  ///
  /// Default: Icons.backspace
  final IconData? clearSearchIcon;

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
    isSearchMode.value = true;
  }

  /// Hide the search bar.
  ///
  /// Usually you don't need to call this method implicitly.
  void stopSearch() {
    isSearchMode.value = false;
    if (clearOnClose) {
      textEditingController.text = '';
    }
    onClosed?.call();
  }

  /// Show/hide the search bar.
  ///
  /// See example in docs of [startSearch] method.
  void triggerSearch() {
    if (isSearchMode.value) {
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
    submitNotifier.value = val;
    onSubmitted?.call(val);
  }

  /// Shortcut for [isSearchMode], for backward compatibility.
  ///
  /// Indicator of whenever search bar is active.
  @Deprecated('Please, use isSearchMode')
  ValueNotifier<bool> get isActive => isSearchMode;

  /// Shortcut for [customIsSearchModeNotifier], for backward compatibility.
  ///
  /// If null, will be created default one.
  /// Use [isSearchMode] getter to access this field.
  @Deprecated('Please, use customIsSearchModeNotifier')
  final ValueNotifier<bool>? customIsActiveNotifier;
}
