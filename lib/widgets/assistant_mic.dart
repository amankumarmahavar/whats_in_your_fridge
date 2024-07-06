import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:whats_in_your_fridge/utils/colors.dart';

class AssistantMic extends StatelessWidget {
  const AssistantMic(
      {super.key,
      required this.speechToText,
      required this.startListening,
      required this.stopListening});
  final Function() stopListening;
  final Function() startListening;
  final SpeechToText speechToText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      child: IconButton.filled(
        onPressed: speechToText.isNotListening ? startListening : stopListening,
        icon: Padding(
          padding: EdgeInsets.all(5),
          child: Icon(
            speechToText.isNotListening ? Icons.mic_off : Icons.mic,
            size: 28,
            fill: 0.5,
            color: kBlack,
          ),
        ),
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(kSkin)),
      ),
    );
  }
}
