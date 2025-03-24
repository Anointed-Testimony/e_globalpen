import 'package:e_globalpen_app/models/book_model.dart';
import 'package:e_globalpen_app/presentation/home/book_details_screen.dart';
import 'package:e_globalpen_app/presentation/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/services/author_service.dart';
import '../../core/services/book_service.dart';
import '../../core/services/user_service.dart';
import '../../models/author.dart';
import 'AuthorDetailsScreen.dart';
import 'SearchScreen.dart';
import 'saved_screen.dart';
import 'view_all_authors_screen.dart';
import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "Guest";
  final UserService _userService = UserService();
  List<Book> trendingBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    fetchTrendingBooks();
  }

  Future<void> _loadUserName() async {
    String? storedName = await _userService.getUserName();
    if (storedName != null && storedName.isNotEmpty) {
      setState(() {
        userName = storedName;
      });
    }
  }

  Future<void> fetchTrendingBooks() async {
    try {
      BookService bookService = BookService();
      List<Book> books = await bookService.getLatestBooks();
      setState(() {
        trendingBooks = books;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching trending books: $e");
    }
  }
  Widget _buildTrendingBooks(BuildContext context) {
    return SizedBox(
      height: 220,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : trendingBooks.isEmpty
              ? Center(child: Text("No trending books available"))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingBooks.length,
                  itemBuilder: (context, index) {
                    return _buildBookCard(trendingBooks[index], context);
                  },
                ),
    );
  }

    Widget _buildBookCard(Book book, BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsScreen(book: book),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 15, bottom: 10),
          child: Container(
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    book.coverUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 120,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        book.author,
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 14),
                          Text(
                            " ${book.rating.toStringAsFixed(1)}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
        ),
        title: Text(
          "Welcome $userName",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            _buildSearchBar(context),
            SizedBox(height: 20),
            _buildSectionTitle(context, "Top Authors"),
            _buildAuthorsList(),
            SizedBox(height: 20),
            _buildSectionTitle(context, "Trending Books"),
            _buildTrendingBooks(context),
            SizedBox(height: 20),
            _buildSectionTitle(context, "AudioBooks"),
            // _buildRecommendedBooks(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }
}


  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.black45),
            SizedBox(width: 10),
            Text(
              "Search",
              style: TextStyle(color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: onTap ??
              () {
                if (title == "Top Authors") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewAllAuthorsScreen(),),
                    
                  );
                }
              },
          child: const Text(
            "View all",
            style: TextStyle(color: Color(0xFF790679)),
          ),
        ),
      ],
    );
  }

Widget _buildAuthorsList() {
  return FutureBuilder<List<Author>>(
    future: AuthorService.fetchAuthors(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text("Error loading authors"));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text("No authors found"));
      }

      List<Author> authors = snapshot.data!;

      return SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: authors.length,
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index) {
            final author = authors[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
              onTap: () {
                try {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthorDetailsScreen(author: author),
                    ),
                  );
                } catch (e) {
                  print('Error navigating: $e');
                }
              },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(author.imageUrl),
                    ),
                    SizedBox(height: 5),
                    Text(
                      author.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}







  // Widget _buildRecommendedBooks(BuildContext context) {
  //   return SizedBox(
  //     height: 220,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: Book.dummyBooks.length,
  //       itemBuilder: (context, index) => Padding(
  //         padding: EdgeInsets.only(right: 15),
  //         child: _buildBookCard(index, context),
  //       ),
  //     ),
  //   );
  // }



Widget _buildBottomNavBar(BuildContext context) {
  return BottomNavigationBar(
    currentIndex: 0, // Make sure to update this dynamically based on the selected page
    selectedItemColor: Color(0xFF790679),
    unselectedItemColor: Colors.grey,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    onTap: (index) {
      if (index == 1) { 
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoriesScreen()),
        );
      } else if (index == 2) { 
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SavedScreen()), // Navigate to Saved Screen
        );
      } else if (index == 3) { 
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()), // Navigate to Saved Screen
        );
      }
    },
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Categories"),
      BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ],
  );
}


