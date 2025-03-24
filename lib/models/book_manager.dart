import 'book_model.dart';

class BookManager {
  static List<Book> allBooks = []; // This will hold all books in memory

  static void setBooks(List<Book> books) {
    allBooks = books; // Update the book list
  }

  static List<Book> getBooks() {
    return allBooks; // Return all books
  }
}
