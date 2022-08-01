import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';

late final SpeechToText speech;

class SpeechSubBar extends StatefulWidget {
  final ValueNotifier<bool> isSpeechMode;
  final ValueNotifier<String> textNotifier;

  const SpeechSubBar(
      {required this.textNotifier, required this.isSpeechMode, Key? key})
      : super(key: key);

  @override
  State<SpeechSubBar> createState() => _SpeechSubBarState();
}

class _SpeechSubBarState extends State<SpeechSubBar> {
  final isListening = ValueNotifier(false);

  Future<bool> initSpeechEngine(SpeechToText speech) async {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      try {
        final available = await speech.initialize(
          onStatus: (status) {
            dev.log('Speech status $status');
            isListening.value = speech.isListening;
            if (mounted) {
              setState(() {
                // just update state
              });
            }
          },
          onError: (error) {
            dev.log('Speech error $error');
            isListening.value = speech.isListening;
            if (mounted) {
              setState(() {
                // just update state
              });
            }
          },
        );
        if (available) {
          dev.log('speech available, last status ${speech.lastStatus}');
          return true;
        } else {
          dev.log('speech is unavailable');
          return false;
        }
      } on PlatformException catch (e) {
        // todo: handle no Bluetooth permission here
        dev.log('speech had PlatformException');
        dev.log(e.details ?? 'details unavailable');
        return false;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    initSpeechEngine(speech).then((value) {
      if (value) {
        widget.isSpeechMode.addListener(_isSpeechListener);
        if (!speech.isListening) {
          speechStartListening();
          isListening.value = speech.isListening;
        }
      }
    });
  }

  Future<void> speechStartListening() async {
    isListening.value = speech.isListening;
    final res = await speech.listen(
      onResult: (result) {
        widget.textNotifier.value =
            widget.textNotifier.value + result.recognizedWords;
        isListening.value = speech.isListening;
      },
    );
    isListening.value = speech.isListening;
    return res;
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSpeechMode != oldWidget.isSpeechMode) {
      widget.isSpeechMode.addListener(_isSpeechListener);
      oldWidget.isSpeechMode.removeListener(_isSpeechListener);
    }
  }

  void _isSpeechListener() async {
    if (widget.isSpeechMode.value) {
      await speechStartListening();
    } // is setState needed if false?
    if (mounted) {
      setState(() {
        // update listen state
      });
    }
  }

  @override
  void dispose() {
    if (speech.isListening) {
      speech.stop();
    }
    widget.isSpeechMode.removeListener(_isSpeechListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (speech.isListening || speech.isAvailable) {
      return MicControlBar(
        textNotifier: widget.textNotifier,
        speechStartListening: speechStartListening,
        isListen: isListening,
      );
    }

    return const Center(
      child: Text('Error: Speech recognition is not available'),
    );
  }
}

/// Button-indicator speech recognition is active
class MicControlBar extends StatelessWidget {
  final ValueNotifier<String> textNotifier;
  final Future<void> Function() speechStartListening;
  final ValueNotifier<bool> isListen;

  const MicControlBar({
    required this.textNotifier,
    required this.speechStartListening,
    required this.isListen,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
