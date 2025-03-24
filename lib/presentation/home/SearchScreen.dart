import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/search_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches(); // Load saved searches on startup
  }

  // Load recent searches from SharedPreferences
Future<void> _loadRecentSearches() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  } catch (e) {
    print("Error loading preferences: $e");
  }
}

  // Save a new search and update SharedPreferences
  Future<void> _saveSearch(String query) async {
    if (query.isEmpty || recentSearches.contains(query)) return;

    setState(() {
      recentSearches.insert(0, query); // Add new search at the top
      if (recentSearches.length > 10) recentSearches.removeLast(); // Limit to 10 items
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recentSearches', recentSearches);
  }

  // Clear all recent searches
  Future<void> _clearRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('recentSearches');

    setState(() {
      recentSearches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          decoration: const InputDecoration(
            hintText: "Search",
            border: InputBorder.none,
          ),
          onSubmitted: (query) => _saveSearch(query), // Save search on enter
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recent Searches Section
            if (recentSearches.isNotEmpty) _buildSectionHeader("Recent search", "Clear all", _clearRecentSearches),
            _buildSearchList(recentSearches, true),

            const SizedBox(height: 20),

            // Trending Searches Section
            _buildSectionHeader("Trending search", null, null),
            _buildSearchList(SearchModel.trendingSearches.map((e) => e.query).toList(), false),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? actionText, VoidCallback? action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          if (actionText != null)
            GestureDetector(
              onTap: action,
              child: Text(actionText, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500)),
            ),
        ],
      ),
    );
  }

  Widget _buildSearchList(List<String> searches, bool showIcon) {
    return Column(
      children: searches.map((query) {
        return ListTile(
          leading: showIcon ? const Icon(Icons.history, size: 20) : null,
          title: Text(query),
          onTap: () {
            // Handle search item tap
          },
        );
      }).toList(),
    );
  }
}
