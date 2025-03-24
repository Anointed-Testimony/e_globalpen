import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/book_model.dart';

class BookService {
  static const String baseUrl = "https://app.globalpconsulting.com.ng/api"; // Replace with your API URL

  // Fetch books by category
  static Future<List<Book>> fetchBooksByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/books?category=$category"));

      print("📌 Request URL: $baseUrl/books?category=$category");
      print("📌 Response Status Code: ${response.statusCode}");
      print("📌 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);

        if (jsonData == null) {
          throw Exception("Response is null");
        }

        if (jsonData is! List) {
          throw Exception("Expected a list but got ${jsonData.runtimeType}: $jsonData");
        }

        return jsonData.map<Book>((book) => Book.fromJson(book)).toList();
      } else {
        throw Exception("Failed to load books. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("❌ Error fetching books: $e");
      print("📌 Stack Trace: $stackTrace");
      throw Exception("Error fetching books: $e");
    }
  }

  // Fetch latest 10 books
  Future<List<Book>> getLatestBooks() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/books/latest"));

      print("📌 Request URL: $baseUrl/books/latest");
      print("📌 Response Status Code: ${response.statusCode}");
      print("📌 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);

        if (jsonData == null) {
          throw Exception("Response is null");
        }

        if (jsonData is! List) {
          throw Exception("Expected a list but got ${jsonData.runtimeType}: $jsonData");
        }

        return jsonData.map<Book>((book) => Book.fromJson(book)).toList();
      } else {
        throw Exception("Failed to load latest books. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("❌ Error fetching latest books: $e");
      print("📌 Stack Trace: $stackTrace");
      throw Exception("Error fetching latest books: $e");
    }
  }
}
