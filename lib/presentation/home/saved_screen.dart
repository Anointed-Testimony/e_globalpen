import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/author_service.dart';
import '../../models/author.dart';
import '../../models/book_manager.dart';
import '../../models/book_model.dart';
import 'AuthorDetailsScreen.dart';
import 'book_details_screen.dart';
import 'categories_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  int _selectedIndex = 2; // Set index to 2 since it's the saved tab
  List<Book> savedBooks = [];
  List<Author> savedAuthors = [];
  bool isLoadingAuthors = true;

  @override
  void initState() {
    super.initState();
    _loadSavedItems();
  }

void _loadSavedItems() {
  SharedPreferences.getInstance().then((prefs) {
    List<String> savedBookIds = prefs.getStringList('saved_books') ?? [];
    List<Book> allBooks = BookManager.getBooks(); // Get books from memory

    setState(() {
      savedBooks = allBooks.where((book) => savedBookIds.contains(book.id.toString())).toList();
    });
  });

    AuthorService.fetchAuthors().then((authors) {
      setState(() {
        savedAuthors = authors.where((author) => author.isSaved).toList();
        isLoadingAuthors = false;
      });
    }).catchError((error) {
      setState(() => isLoadingAuthors = false);
      print("Error fetching authors: $error");
    });
  }

  void _removeBook(Book book) {
    setState(() {
      book.isSaved = false;
      savedBooks.remove(book);
    });

    _showSnackBar("Book successfully removed");
  }

  void _removeAuthor(Author author) {
    setState(() {
      author.isSaved = false;
      savedAuthors.remove(author);
    });

    _showSnackBar("Author successfully removed");
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return; // Prevent unnecessary navigation

    Widget destinationScreen;
    switch (index) {
      case 0:
        destinationScreen = HomeScreen();
        break;
      case 1:
        destinationScreen = CategoriesScreen();
        break;
      case 2:
        return; // Already on the Saved tab
      case 3:
        destinationScreen = ProfileScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destinationScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (savedBooks.isNotEmpty) ...[
              _buildSectionTitle("Books"),
              ...savedBooks.map((book) => _buildDismissibleBookTile(book)).toList(),
              SizedBox(height: 16),
            ],
            if (isLoadingAuthors)
              Center(child: CircularProgressIndicator())
            else if (savedAuthors.isNotEmpty) ...[
              _buildSectionTitle("Authors"),
              ...savedAuthors.map((author) => _buildDismissibleAuthorTile(author)).toList(),
            ],
            if (savedBooks.isEmpty && savedAuthors.isEmpty && !isLoadingAuthors)
              Center(child: Text("No saved books or authors.")),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xFF790679),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDismissibleBookTile(Book book) {
    return Dismissible(
      key: Key(book.title),
      direction: DismissDirection.endToStart,
      background: _buildDismissBackground(),
      onDismissed: (direction) => _removeBook(book),
      child: _buildSavedBookTile(book),
    );
  }

  Widget _buildDismissibleAuthorTile(Author author) {
    return Dismissible(
      key: Key(author.name),
      direction: DismissDirection.endToStart,
      background: _buildDismissBackground(),
      onDismissed: (direction) => _removeAuthor(author),
      child: _buildSavedAuthorTile(author),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      color: Colors.red,
      child: Icon(Icons.delete, color: Colors.white),
    );
  }

  Widget _buildSavedBookTile(Book book) {
    return GestureDetector(
      onTap: () => _navigateTo(BookDetailsScreen(book: book)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(book.coverUrl, width: 50, height: 50, fit: BoxFit.cover),
          ),
          title: Text(book.title, style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 14),
              SizedBox(width: 4),
              Text("${book.rating} (220)", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSavedAuthorTile(Author author) {
    return GestureDetector(
      onTap: () => _navigateTo(AuthorDetailsScreen(author: author)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(author.imageUrl),
          ),
          title: Text(author.name, style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text("${author.bookCount} books"),
        ),
      ),
    );
  }

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
