import 'dart:convert';

import 'package:blogapp/chat/screens/home/child/otes/models/Categories.dart';
import 'package:http/http.dart' as http;

// Fetch our Categories from API
Future<List<Category>> fetchCategories() async {
  const String apiUrl =
      "https://5fb22e5987ed490016ea87b3.mockapi.io/produk/category";

  final response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Category> categories = (json.decode(response.body) as List)
        .map((data) => Category.fromJson(data))
        .toList();
// It retuen list of categories
    return categories;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}
