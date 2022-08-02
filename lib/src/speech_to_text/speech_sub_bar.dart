// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:app_bar_with_search_switch/src/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// Indicator(and controller) shown when speech recognition is active.
///
/// It supposed to be shown when [SpeechToText] is already in process of activating.
/// If you want to use you own SubBar for [AppBarWithSearchSwitch],
/// assign it to parameter [AppBarWithSearchSwitch].[speechSubBar] as in
/// template bellow:
///```dart
///  // inside AppBarWithSearchSwitch use:
///  // speechSubBarHeight: kToolbarHeight * 1.2,
///  speechSubBar: (context) {
///    final speech = AppBarWithSearchSwitch.of(context)!.speechEngine;
///    final isListening = AppBarWithSearchSwitch.of(context)!.isListeningToSpeech;
///    final textNotifier = AppBarWithSearchSwitch.of(context)!.textNotifier;
///
///    return ValueListenableBuilder(
///      valueListenable: isListening,
///      builder: (context, _, child) {
///        return FloatingActionButton(
///          backgroundColor: speech.isListening ? Colors.red : Colors.grey,
///          autofocus: true,
///          onPressed: () async {
///            if (speech.isListening) {
///              await speech.stop();
///              isListening.value = false; // not necessary, just failsafe
///            } else {
///              await innerStartListening(
///                speech: speech,
///                isListening: isListening,
///                textNotifier: textNotifier,
///              );
///            }
///          },
///          child: const Icon(Icons.mic_rounded),
///        );
///      },
///    );
///  },
///```
class SpeechSubBar extends StatelessWidget {
  const SpeechSubBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final speech = AppBarWithSearchSwitch.of(context)!.speechEngine;
    final isListening = AppBarWithSearchSwitch.of(context)!.isListeningToSpeech;
    final textNotifier = AppBarWithSearchSwitch.of(context)!.textNotifier;

    if (!(speech.isListening || speech.isAvailable)) {
      return const Center(
        child: Text('Speech recognition is initializing...'),
      );
    }

    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: isListening,
              builder: (context, _, child) {
                return FloatingActionButton(
                  backgroundColor:
                      speech.isListening ? Colors.red : Colors.grey,
                  autofocus: true,
                  onPressed: () async {
                    if (speech.isListening) {
                      await speech.stop();
                      isListening.value = false; // not necessary, just failsafe
                    } else {
                      await innerStartListening(
                        speech: speech,
                        isListening: isListening,
                        textNotifier: textNotifier,
                      );
                    }
                  },
                  child: const Icon(Icons.mic_rounded),
                );
              },
            ),

            // Center(
            //   child: Text(speech.lastRecognizedWords),
            // ),
          ],
        ),
      ),
    );
  }
}

/// This function should only be used inside [AppBarWithSearchSwitch].[speechSubBar],
///
/// it will call [SpeechToText].[listen] inside...
Future<void> innerStartListening(
    {required SpeechToText speech,
    required ValueNotifier<bool> isListening,
    required ValueNotifier<String> textNotifier}) async {
  isListening.value = speech.isListening;
  final previousText = textNotifier.value; // don't duplicate results, but save current field
  await speech.listen(
    onResult: (result) {
      textNotifier.value = previousText + result.recognizedWords;
      isListening.value = speech.isListening;
    },
  );
  isListening.value = speech.isListening;
}
