class SearchModel {
  final String query;

  SearchModel({required this.query});

  static List<SearchModel> trendingSearches = [
    SearchModel(query: "One Indian girl"),
    SearchModel(query: "Scary House"),
    SearchModel(query: "I too had a love story"),
    SearchModel(query: "India positive"),
    SearchModel(query: "Dark secret"),
    SearchModel(query: "Rich dad poor dad"),
    SearchModel(query: "The secret"),
  ];
}
