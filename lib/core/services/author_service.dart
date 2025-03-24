import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/author.dart';

class AuthorService {
static Future<List<Author>> fetchAuthors() async {
  try {
    final response = await http.get(Uri.parse('https://app.globalpconsulting.com.ng/api/authors-with-books'));
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    final jsonData = json.decode(response.body);
    if (jsonData == null) {
      throw Exception("Response is null");
    }
    if (!jsonData.containsKey('authors') || jsonData['authors'] == null) {
      throw Exception("Key 'authors' not found in response");
    }

    List<dynamic> authorsList = jsonData['authors']; // Ensure it's a list
    return authorsList.map((author) {
      if (author == null) {
        throw Exception("Author object is null");
      }
      return Author.fromJson(author);
    }).toList();
  } catch (e) {
    print("Error fetching authors: $e");
    throw Exception("Error fetching authors: $e");
  }
}


}
