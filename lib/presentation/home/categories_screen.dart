import 'package:e_globalpen_app/presentation/home/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import 'category_books_screen.dart';
import 'saved_screen.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryBooksScreen(category: category.title),
                  ),
                );
              },
              child: CategoryCard(category: category),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context, 1),
    );
  }

Widget _buildBottomNavBar(BuildContext context, int currentIndex) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    selectedItemColor: Color(0xFF790679),
    unselectedItemColor: Colors.grey,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    onTap: (index) {
      if (index == currentIndex) return; // Prevent reloading the same page

      if (index == 0) {
        Navigator.pop(context); // Navigate back to Home
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SavedScreen()), // Navigate to Saved
        );
      }  else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()), // Navigate to Saved
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
}

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(category.imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        category.title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
