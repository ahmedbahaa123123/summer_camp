class BooksModel {
  final int id;
  final String title;
  final String? subTitle;
  final List<String> authors;
  final String? publishDate;
  final String? language;
  final String? image;
  final int? page;
  String webView;
  final String? description;

  BooksModel({
    required this.id,
    required this.title,
    this.subTitle,
    required this.authors,
    this.publishDate,
    this.language,
    this.image,
    this.page,
    required this.webView,
    this.description,
  });

  factory BooksModel.fromMap(Map<String, dynamic> data) {
    return BooksModel(
      id: data['id'] is int ? data['id'] : int.tryParse(data['id'].toString()) ?? 0,
      title: data['volumeInfo']['title'].toString(),
      subTitle: data['volumeInfo']['subtitle']?.toString(),
      authors: data['volumeInfo']['authors'] != null
          ? List<String>.from(data['volumeInfo']['authors'])
          : [],
      publishDate: data['volumeInfo']['publishedDate']?.toString(),
      language: data['volumeInfo']['language']?.toString(),
      image: data['volumeInfo']['imageLinks'] != null
          ? data['volumeInfo']['imageLinks']['thumbnail']?.toString()
          : '',
      page: data['volumeInfo']['pageCount'] is int
          ? data['volumeInfo']['pageCount']
          : int.tryParse(data['volumeInfo']['pageCount'].toString()),
      webView: data['volumeInfo']['previewLink'],
      description: data['volumeInfo']['description']?.toString(),
    );
  }
}