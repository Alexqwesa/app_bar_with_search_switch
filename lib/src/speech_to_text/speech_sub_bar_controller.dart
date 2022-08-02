import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';

import './speech_sub_bar.dart';

class SpeechSubBarController extends StatefulWidget {
  final ValueNotifier<bool> isSpeechMode;
  final ValueNotifier<String> textNotifier;
  final SpeechToText speech;

  const SpeechSubBarController({
    required this.textNotifier,
    required this.isSpeechMode,
    required this.speech,
    Key? key,
  }) : super(key: key);

  @override
  State<SpeechSubBarController> createState() => _SpeechSubBarControllerState();
}

class _SpeechSubBarControllerState extends State<SpeechSubBarController> {
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
    initSpeechEngine(widget.speech).then((value) {
      if (value) {
        widget.isSpeechMode.addListener(_isSpeechListener);
        if (!widget.speech.isListening) {
          speechStartListening();
          isListening.value = widget.speech.isListening;
        }
      }
    });
  }

  Future<void> speechStartListening() async {
    final speech = widget.speech;
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
    final speech = widget.speech;
    if (speech.isListening) {
      speech.stop();
    }
    widget.isSpeechMode.removeListener(_isSpeechListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpeechSubBar(
      textNotifier: widget.textNotifier,
      speechStartListening: speechStartListening,
      isListen: isListening,
      speech: widget.speech,
    );
  }
}
