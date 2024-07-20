import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:whats_in_your_fridge/widgets/recipe_card.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key, required this.recipeData});
  final Map<String, dynamic> recipeData;
  @override
  Widget build(BuildContext context) {
    List<dynamic> recipeList = recipeData['results'];
    try {
      return Swiper(
        itemCount: recipeList.length,
        itemBuilder: (BuildContext context, int index) {
          return RecipeCard(
              title: recipeList[index]['title'], id: recipeList[index]['id']);
        },
      );
    } on Exception catch (e) {
      const Center(
        child: Text('Something went wrong ... '),
      );
      return Container();
    }
  }
}
