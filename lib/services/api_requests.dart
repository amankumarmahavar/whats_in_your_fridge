import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;

Future<String?> geminyQuery(String query) async {
  const apiKey = 'AIzaSyAAvmxbVy8qcLotR34MB36klygYgNGnS2g';
  final contentString =
      'i am using spoonacular api for finding recipes. this is the string: \'$query\'. simply just give me a url without any description, remove apikey parameter from url. if url generation is not possible replay with "NO".';

  // print(contentString);

  final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      safetySettings: [
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.low),
      ]);

  final content = [Content.text(contentString)];
  final response = await model.generateContent(content);
  print(response.text);
  return response.text;
}

Future<Map<String, dynamic>?> getRecipeList(String query) async {
  String? url = await geminyQuery(query);

  // 'https://api.spoonacular.com/recipes/complexSearch?apiKey=2166f50937b34677ab4602d5485baa83&query=pasta&diet=gluten-free&includeIngredients=vitamin+b12,vitamin+d&type=main+course'

  if (url != null && url.trim() != 'NO') {
    String apiKey = '&apiKey=2166f50937b34677ab4602d5485baa83';
    url = '${url.trim()}$apiKey';
    print('url: $url');

    Uri uri = Uri.parse(url);

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  } else {
    return null;
  }
}

Future<Map<String, dynamic>?> getRecipe(String id) async {
  const apiKey = '2166f50937b34677ab4602d5485baa83';
  String url =
      'https://api.spoonacular.com/recipes/$id/information?apiKey=$apiKey';

  Uri uri = Uri.parse(url);

  var response = await http.get(uri);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}
