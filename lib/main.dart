import 'package:flutter/material.dart';
import 'package:whats_in_your_fridge/pages/assistant_home.dart';
import 'package:whats_in_your_fridge/utils/colors.dart';
import 'package:whats_in_your_fridge/widgets/recipe_card.dart';
import 'package:whats_in_your_fridge/pages/recipe_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(color: kSkiesh),
          fontFamily: 'Cera pro',
          scaffoldBackgroundColor: kSkiesh),
      home: AssistantHome()
    );
  }
}
