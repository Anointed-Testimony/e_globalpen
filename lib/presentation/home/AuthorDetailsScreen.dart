import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/author.dart';
import '../../models/book_model.dart';
import '../../widgets/book_card.dart';
import 'book_details_screen.dart';

class AuthorDetailsScreen extends StatelessWidget {
  final Author author;

  const AuthorDetailsScreen({Key? key, required this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _AuthorInfoSection(author: author),
          const SizedBox(height: 10),
          _buildTabView(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.share, color: Colors.black), onPressed: () {}),
        IconButton(icon: const Icon(Icons.bookmark_border, color: Colors.black), onPressed: () {}),
      ],
    );
  }

  Widget _buildTabView(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.orange,
              tabs: const [
                Tab(text: "About"),
                Tab(text: "Books"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _AboutSection(author: author),
                  _BooksSection(author: author),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthorInfoSection extends StatelessWidget {
  final Author author;

  const _AuthorInfoSection({Key? key, required this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(author.imageUrl),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(author.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  '${author.bookCount} Books',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  final Author author;

  const _AboutSection({Key? key, required this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Text(
          author.bio,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}

class _BooksSection extends StatelessWidget {
  final Author author;

  const _BooksSection({Key? key, required this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return author.books.isEmpty
        ? Center(child: Text("No books available", style: GoogleFonts.poppins()))
        : Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: author.books.length,
              itemBuilder: (context, index) {
                return BookCard(
                  book: author.books[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsScreen(book: author.books[index]),
                      ),
                    );
                  },
                );
              },
            ),
          );
  }
}
