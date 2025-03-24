import 'book_model.dart';
import 'package:html/parser.dart' as htmlParser;

class Author {
  final int id;
  final String name;
  final String imageUrl;
  final String bio;
  final int bookCount;
  final List<Book> books;
  bool isSaved;

  Author({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.bio,
    required this.bookCount,
    required this.books,
    this.isSaved = false,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] ?? 0,
      name: json['author_name'] ?? 'Unknown Author',
      imageUrl: json['author_image'] != null
          ? "https://app.globalpconsulting.com.ng/${json['author_image']}"
          : "https://via.placeholder.com/150",
      bio: json['author_description'] != null
          ? htmlParser.parse(json['author_description']).body?.text.trim() ?? 'No biography available'
          : 'No biography available',
      bookCount: (json['books'] as List?)?.length ?? 0,
      books: (json['books'] as List?)
              ?.map((book) => Book.fromJson(book))
              .toList() ??
          [],
    );
  }
}
