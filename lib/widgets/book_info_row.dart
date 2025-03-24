import 'package:flutter/material.dart';
import '../../models/book_model.dart';

class BookInfoRow extends StatelessWidget {
  final Book book;

  const BookInfoRow({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoItem("Rating", book.rating.toString()),
        _buildInfoItem("Language", book.language),
        _buildInfoItem("Pages", book.pages.toString()),
      ],
    );
  }

  Widget _buildInfoItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(height: 5),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
