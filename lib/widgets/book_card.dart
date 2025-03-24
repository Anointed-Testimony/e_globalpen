import 'package:e_globalpen_app/widgets/rating_widget.dart';
import 'package:flutter/material.dart';
import '../../models/book_model.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookCard({Key? key, required this.book, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(book.coverUrl, height: 120, width: 100, fit: BoxFit.cover),
          ),
          SizedBox(height: 5),
          Text(
            book.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            book.author,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(height: 5),
          RatingWidget(rating: book.rating),
        ],
      ),
    );
  }
}
