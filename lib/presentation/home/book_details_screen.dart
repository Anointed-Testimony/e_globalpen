import 'package:flutter/material.dart';
import '../../models/book_model.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book; // ✅ Keep only the Book object

  const BookDetailsScreen({super.key, required this.book}); // ✅ Remove unnecessary bookId parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(book.coverUrl, height: 180),
              ),
            ),
            SizedBox(height: 10),

            // Title & Author
            Center(
              child: Column(
                children: [
                  Text(book.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text("By ${book.author}", style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Book Info (Rating, Language, Pages)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBookInfo("Rating", book.rating.toString()),
                _buildBookInfo("Language", book.language),
                _buildBookInfo("Pages", book.pages.toString()),
              ],
            ),
            SizedBox(height: 16),

            // Description
            Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(book.description, style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 16),

            // Price
            Text("Price: \$${book.price.toStringAsFixed(2)}", 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            SizedBox(height: 16),

            // Reviews Section
            if (book.reviews.isNotEmpty) ...[
              Text("Top review", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Column(
                children: book.reviews.map((review) => _buildReviewCard(review)).toList(),
              ),
            ],
            SizedBox(height: 20),

            // Read Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF790679),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                ),
                onPressed: () {},
                child: Text("Read", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget to Build Book Info (Rating, Language, Pages)
  Widget _buildBookInfo(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  // Helper Widget to Build Review Card
  Widget _buildReviewCard(Review review) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Avatar
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(review.userAvatar, width: 50, height: 50),
          ),
          SizedBox(width: 10),

          // User Review Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Name & Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(review.userName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(review.date, style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 4),

                // Star Rating
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 18,
                    );
                  }),
                ),
                SizedBox(height: 4),

                // Review Comment
                Text(review.comment, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
