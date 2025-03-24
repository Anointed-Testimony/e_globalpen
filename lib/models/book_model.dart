import 'package:html/parser.dart'; // Import this package

String removeHtmlTags(String htmlText) {
  final document = parse(htmlText);
  return document.body?.text ?? '';
}

class Review {
  final String userName;
  final String userAvatar;
  final double rating;
  final String date;
  final String comment;

  Review({
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.date,
    required this.comment,
  });

  // Convert from JSON
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userName: json['user_name'] ?? 'Unknown',
      userAvatar: json['user_avatar'] ?? '',
      rating: (json['rating'] ?? 0),
      date: json['date'] ?? '',
      comment: json['comment'] ?? '',
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_name': userName,
      'user_avatar': userAvatar,
      'rating': rating,
      'date': date,
      'comment': comment,
    };
  }
}

class Book {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final double rating;
  final String language;
  final int pages;
  final String description;
  final double price;
  final String category;
  final String bookFile;
  final List<Review> reviews;
  bool isSaved;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.rating,
    required this.language,
    required this.pages,
    required this.description,
    required this.price,
    required this.category,
    required this.bookFile,
    required this.reviews,
    this.isSaved = false,
  });

  // Convert from JSON (for API responses)
  factory Book.fromJson(Map<String, dynamic> json) {
    print("Author JSON: ${json['author']}");
    return Book(
      id: json['id'].toString(),
      title: json['book_title'] ?? 'Unknown',
      author: json['author.author_name'] ?? 'Unknown Author',
      coverUrl: "https://app.globalpconsulting.com.ng/${json['featured_image']}" ?? '',
      rating: (json['rating'] ?? 0),
      language: json['language'] ?? 'Unknown',
      pages: json['pages'] ?? 0,
      description: removeHtmlTags(json['book_description'] ?? '') ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      category: json['category']?['category_name'] ?? 'Unknown',
      bookFile: json['book_file'] ?? '',
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((review) => Review.fromJson(review))
              .toList() ??
          [],
    );
  }

  // Convert to JSON (for sending data to API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book_title': title,
      'author': {'author_name': author},
      'featured_image': coverUrl,
      'rating': rating,
      'language': language,
      'pages': pages,
      'book_description': description,
      'price': price,
      'category': {'category_name': category},
      'book_file': bookFile,
      'reviews': reviews.map((review) => review.toJson()).toList(),
    };
  }
}
