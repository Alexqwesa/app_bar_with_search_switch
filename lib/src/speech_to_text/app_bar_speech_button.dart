import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../app_bar_with_search_switch.dart';

/// Button that will activate Speech to text recognition for [AppBarWithSearchSwitch].
///
/// Usually you will probably want to use it like this:
///
///      Scaffold(
///         appBar: AppBarWithSearchSwitch(
///           appBarBuilder: (context) {
///             return AppBar(
///               title: const Text('AppBarWithSearchSwitch'),
///               actions: const [
///                 AppBarSearchButton(),
///                 AppBarSpeechButton(), // <== this button
///               ],
class AppBarSpeechButton extends StatelessWidget {
  const AppBarSpeechButton({Key? key}) : super(key: key);

  /// Return [AppBarWithSearchSwitch] in children of [AppBarWithSearchFinder].
  ///
  /// Note: there is a standard limitation:
  /// - context should be inside of [AppBarWithSearchFinder] (belong to one of it children).
  static AppBarWithSearchSwitch? of(BuildContext context) {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold != null &&
        scaffold.hasAppBar &&
        (scaffold.widget.appBar.runtimeType == AppBarWithSearchSwitch)) {
      return (scaffold.widget.appBar as AppBarWithSearchSwitch);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      return IconButton(
        icon: const Icon(Icons.mic_none_rounded),
        //
        // > Start listening
        //
        onPressed: () async {
          final mainWidget = AppBarSpeechButton.of(context);
          // await initSpeechEngine(SpeechToText());
          mainWidget?.isSpeechMode.value = true;
          mainWidget?.isSearchMode.value = true;
        },
      );
    } else {
      return Container();
    }
  }
}
