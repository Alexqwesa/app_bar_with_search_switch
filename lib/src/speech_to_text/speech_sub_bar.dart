import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// Indicator(controller) shown when speech recognition is active.
class SpeechSubBar extends StatelessWidget {
  final ValueNotifier<String> textNotifier;
  final Future<void> Function() speechStartListening;
  final ValueNotifier<bool> isListen;
  final SpeechToText speech;

  const SpeechSubBar({
    required this.textNotifier,
    required this.speechStartListening,
    required this.isListen,
    required this.speech,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              valueListenable: isListen,
              builder: (context, _, child) {
                return FloatingActionButton(
                  backgroundColor:
                      speech.isListening ? Colors.red : Colors.grey,
                  autofocus: true,
                  onPressed: () async {
                    if (speech.isListening) {
                      await speech.stop();
                      isListen.value = false;
                    } else {
                      await speechStartListening();
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
