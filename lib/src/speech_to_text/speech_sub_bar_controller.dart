// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:developer' as dev;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';

import './speech_sub_bar.dart';
import '../app_bar_with_search_switch.dart';

/// Interact with [SpeechToText], init it,
///
/// show [SpeechSubBar] and subscribe to [isListeningToSpeech] and [isSpeechMode].
class SpeechSubBarController extends StatefulWidget {
  final ValueNotifier<bool> isSpeechMode;
  final ValueNotifier<String> textNotifier;
  final SpeechToText speech;
  final ValueNotifier<bool> isListeningToSpeech;

  const SpeechSubBarController({
    required this.textNotifier,
    required this.isSpeechMode,
    required this.speech,
    required this.isListeningToSpeech,
    Key? key,
  }) : super(key: key);

  @override
  State<SpeechSubBarController> createState() => _SpeechSubBarControllerState();
}

class _SpeechSubBarControllerState extends State<SpeechSubBarController> {
  Future<bool> initSpeechEngine(SpeechToText speech) async {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      try {
        final available = await speech.initialize(
          onStatus: (status) {
            dev.log('Speech status $status');
            widget.isListeningToSpeech.value = speech.isListening;
            if (mounted) {
              setState(() {
                // just update state
              });
            }
          },
          onError: (error) {
            dev.log('Speech error $error');
            widget.isListeningToSpeech.value = speech.isListening;
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
    initSpeechEngine(widget.speech).then((value) async {
      if (value) {
        widget.isSpeechMode.addListener(_isSpeechListener);
        if (!widget.speech.isListening) {
          await innerStartListening(
            speech: widget.speech,
            isListening: widget.isListeningToSpeech,
            textNotifier: widget.textNotifier,
          );
          widget.isListeningToSpeech.value = widget.speech.isListening;
        }
      }
    });
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
      await innerStartListening(
        speech: widget.speech,
        isListening: widget.isListeningToSpeech,
        textNotifier: widget.textNotifier,
      );
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
    final mainWidget = AppBarWithSearchSwitch.of(context)!;
    return mainWidget.speechSubBar != null
        ? mainWidget.speechSubBar!.call(context)
        : const SpeechSubBar();
  }
}
