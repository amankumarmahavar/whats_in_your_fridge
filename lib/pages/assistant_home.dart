import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:whats_in_your_fridge/pages/recipe_list.dart';
import 'package:whats_in_your_fridge/services/api_requests.dart';
import 'package:whats_in_your_fridge/utils/colors.dart';
import 'package:whats_in_your_fridge/widgets/assistant_mic.dart';
import 'package:whats_in_your_fridge/widgets/home_widget.dart';

// FFF7F1 graywhite
// FFE4C9 skin
// E78895 pink
// BED1CF skiesh

class AssistantHome extends StatefulWidget {
  AssistantHome({super.key});

  @override
  State<AssistantHome> createState() => _AssistantHomeState();
}

class _AssistantHomeState extends State<AssistantHome> {
  final List<String> suggessions = [
    'Try an omelette with eggs and leftover veggies.',
    'Create a pasta dish with tomatoes and cheese',
    'Blend a smoothie using fruits and yogurt.',
    'Make quesadillas with tortillas and cheese.',
    'Make a sandwich or wrap with deli meats and veggies.'
  ];

  final _speechToText = SpeechToText();
  late final PermissionStatus _audioStatus;
  String _lastWords = '';
  bool _showRecipe = false;
  var recipeData;

  @override
  void initState() {
    _initListening();
    super.initState();
  }

  void _initListening() async {
    _audioStatus = await Permission.microphone.status;
    if (_audioStatus.isGranted) {
      await _speechToText.initialize();
    } else if (_audioStatus.isDenied) {
      await Permission.microphone.request();
      print('permission is denied');
    } else {
      print('something went wrong $_audioStatus');
    }
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    print(_lastWords);
    if (_speechToText.isNotListening) {
      _showCards();
    }
    setState(() {});
  }

  void _showCards() {
    getRecipeList(_lastWords).then((data) {
      // _lastWords = '';
      recipeData = data;
      if (recipeData != null) {
        _showRecipe = true;
      } else {
        _showRecipe = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: kSkiesh,
        title: Text(
          'Assistant',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: kBlack),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              !_showRecipe
                  ? HomeWidget(suggessions: suggessions)
                  : Expanded(child: RecipeList(recipeData: recipeData)),
              AssistantMic(
                speechToText: _speechToText,
                startListening: _startListening,
                stopListening: _stopListening,
              )
            ],
          ),
        ),
      ),
    );
  }
}
