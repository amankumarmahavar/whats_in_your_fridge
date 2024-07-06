import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:whats_in_your_fridge/services/api_requests.dart';
import 'package:whats_in_your_fridge/utils/colors.dart';

// https://api.spoonacular.com/recipes/634873/information?apiKey=2166f50937b34677ab4602d5485baa83

// https://api.spoonacular.com/recipes/complexSearch?apiKey=2166f50937b34677ab4602d5485baa83&query=pasta&diet=gluten-free&includeIngredients=vitamin+b12,vitamin+d&type=main+course

class RecipePage extends StatefulWidget {
  RecipePage({super.key, required this.id});
  int id;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  var recipeData;

  @override
  void initState() {
    getRecipe(widget.id.toString()).then((data) {
      recipeData = data;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            recipeData != null
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.green,
                    child: Stack(
                      children: [
                        Image.network(
                            fit: BoxFit.fitHeight,
                            height: 400,
                            'https://img.spoonacular.com/recipes/656544-312x231.jpg'),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.5,
                            decoration: BoxDecoration(
                                color: kSkiesh,
                                borderRadius: BorderRadius.circular(32)
                                    .copyWith(
                                        bottomLeft: Radius.zero,
                                        bottomRight: Radius.zero)),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(32.0),
                                child: RecipeProcedure(
                                  recipeData: recipeData,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                    color: kPink,
                  ))
          ],
        ),
      ),
    );
  }
}

class RecipeProcedure extends StatelessWidget {
  RecipeProcedure({required this.recipeData});
  final recipeData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Text(
            recipeData['title'],
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        RecipeTabs(
          recipeData: recipeData,
        )
      ],
    );
  }
}

class RecipeTabs extends StatefulWidget {
  const RecipeTabs({super.key, required this.recipeData});
  final recipeData;

  @override
  State<RecipeTabs> createState() => _RecipeTabsState();
}

class _RecipeTabsState extends State<RecipeTabs>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(21)),
            child: TabBar(
                controller: _tabController,
                dividerHeight: 0,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: kBlack),
                // isScrollable: true,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kSkin),
                tabs: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Ingradients',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Recipes',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Information',
                    ),
                  ),
                ]),
          ),
          SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: TabBarView(controller: _tabController, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (widget.recipeData['extendedIngredients']
                          as List<dynamic>)
                      .map((ingradients) {
                    return Text(
                      '\u2022 ${ingradients['original']}',
                    );
                  }).toList(),
                ),
                Html(
                  data: widget.recipeData['instructions'],
                  style: {
                    "ol": Style(
                      margin: Margins.symmetric(vertical: 8.0),
                    ),
                    "li": Style(
                      margin: Margins.only(left: 8.0),
                    ),
                  },
                ),
                Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 21),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 21),
                      decoration: BoxDecoration(
                          // border: Border.all(),
                          color: kSkiesh,
                          borderRadius: BorderRadius.circular(21),
                          boxShadow: [
                            BoxShadow(color: Colors.black, blurRadius: 3)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          widget.recipeData['readyInMinutes'] != null
                              ? Column(
                                  children: [
                                    Icon(
                                      Icons.watch_later,
                                      size: 36,
                                      color: kPink,
                                    ),
                                    Text(
                                      'Ready In',
                                      style: TextStyle(color: kPink),
                                    ),
                                    Text(
                                        '${widget.recipeData['readyInMinutes'].toString()} minutes')
                                  ],
                                )
                              : Container(),
                          widget.recipeData['servings'] != null
                              ? Column(
                                  children: [
                                    Icon(
                                      Icons.dining_sharp,
                                      size: 36,
                                      color: kPink,
                                    ),
                                    Text(
                                      'Servings',
                                      style: TextStyle(color: kPink),
                                    ),
                                    Text(
                                      '${widget.recipeData['servings'].toString()}',
                                    )
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ),
                    widget.recipeData['diets'].isNotEmpty
                        ? ListTile(
                            title: Text('Diets'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (widget.recipeData['diets'] as List)
                                  .map((list) {
                                print(list);
                                return Text(list) as Widget;
                              }).toList(),
                            ),
                          )
                        : Container(),
                    widget.recipeData['dishTypes'].isNotEmpty
                        ? ListTile(
                            title: Text('dishTypes'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (widget.recipeData['dishTypes'] as List)
                                  .map((list) {
                                return Text(list) as Widget;
                              }).toList(),
                            ),
                          )
                        : Container(),
                    widget.recipeData['creditsText'] != null
                        ? Center(
                            child: Text(
                              'creadits: ${widget.recipeData['creditsText'].toString()}',
                              style: TextStyle(color: kBlack),
                            ),
                          )
                        : Container()
                  ],
                )
              ]),
            ),
          )
        ],
      );
    } on Exception catch (e) {
      return Center(
        child: Text('Something went wrong ... '),
      );
    }
  }
}
