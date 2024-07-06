import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:whats_in_your_fridge/pages/recipe_page.dart';
import 'package:whats_in_your_fridge/utils/colors.dart';

class RecipeCard extends StatelessWidget {
  String title;
  int id;
  RecipeCard({required this.title, required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return RecipePage(id: id);
        }));
      },
      child: Center(
        child: Container(
          height: 600,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: kBlack,
                blurRadius: 3,
                // spreadRadius: 1
              ),
            ],
            backgroundBlendMode: BlendMode.darken,
            image: DecorationImage(
              image: NetworkImage(
                'https://img.spoonacular.com/recipes/$id-636x393.jpg',
              ),
              fit: BoxFit.fitHeight,
              opacity: 0.8,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 36.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LikeButton(
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          CupertinoIcons.suit_heart_fill,
                          color: isLiked ? Colors.red : kSkiesh,
                          size: 36,
                        );
                      },
                    ),
                    Text(
                      '8/10',
                      style: TextStyle(
                          fontSize: 26,
                          color: kSkiesh,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: kSkiesh,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
