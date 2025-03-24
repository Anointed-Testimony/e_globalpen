class Category {
  final String title;
  final String imagePath;

  Category({required this.title, required this.imagePath});
}

// Sample categories list
final List<Category> categories = [
  Category(title: "Horror", imagePath: "assets/categories/horror.jpg"),
  Category(title: "Fairytales", imagePath: "assets/categories/magic.png"),
  Category(title: "Poetry", imagePath: "assets/categories/poetry.jpg"),
  Category(title: "Crime", imagePath: "assets/categories/crime.jpg"),
  Category(title: "Suspense", imagePath: "assets/categories/suspense.jpeg"),
  Category(title: "Action", imagePath: "assets/categories/action.jpg"),
  Category(title: "History", imagePath: "assets/categories/history.jpg"),
  Category(title: "Business", imagePath: "assets/categories/business.jpg"),
  Category(title: "Paid Book", imagePath: "assets/categories/poetry.jpg"),
  Category(title: "Magic", imagePath: "assets/categories/magic.png"),
];
