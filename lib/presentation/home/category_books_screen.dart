import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/book_service.dart';
import '../../models/book_model.dart';
import 'book_details_screen.dart';

class CategoryBooksScreen extends StatefulWidget {
  final String category;

  const CategoryBooksScreen({super.key, required this.category});

  @override
  _CategoryBooksScreenState createState() => _CategoryBooksScreenState();
}

class _CategoryBooksScreenState extends State<CategoryBooksScreen> {
  late Future<List<Book>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = BookService.fetchBooksByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<List<Book>>(
          future: _booksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No books found in this category."));
            }

            List<Book> books = snapshot.data!;

            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];

                return ListTile(
                  leading: Image.network(book.coverUrl, width: 50, fit: BoxFit.cover),
                  title: Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      book.isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: book.isSaved ? Colors.purple : Colors.grey,
                    ),
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        List<String> savedBookIds = prefs.getStringList('saved_books') ?? [];

                        setState(() {
                          book.isSaved = !book.isSaved; // Toggle save state
                        });

                        if (book.isSaved) {
                          savedBookIds.add(book.id.toString());
                        } else {
                          savedBookIds.remove(book.id.toString());
                        }

                        await prefs.setStringList('saved_books', savedBookIds);
                      },

                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsScreen(book: book),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
