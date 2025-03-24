import 'package:flutter/material.dart';
import '../../core/services/author_service.dart';
import '../../models/author.dart';
import 'AuthorDetailsScreen.dart';

class ViewAllAuthorsScreen extends StatefulWidget {
  const ViewAllAuthorsScreen({super.key});

  @override
  State<ViewAllAuthorsScreen> createState() => _ViewAllAuthorsScreenState();
}

class _ViewAllAuthorsScreenState extends State<ViewAllAuthorsScreen> {
  late Future<List<Author>> _authorsFuture;

  @override
  void initState() {
    super.initState();
    _authorsFuture = AuthorService.fetchAuthors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Authors"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Author>>(
          future: _authorsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No authors found.'));
            }

            final authors = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: authors.length,
              itemBuilder: (context, index) {
                final author = authors[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthorDetailsScreen(author: author),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(author.imageUrl),
                        backgroundColor: Colors.grey[200],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        author.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}