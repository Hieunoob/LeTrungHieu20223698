import 'package:intl/intl.dart';

class News {
  final int id;
  final String title;
  final String body;
  final String date;
  final String imageUrl;
  bool isFavorite;

  News({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
      imageUrl: 'https://picsum.photos/200/300?random=${json['id']}',
    );
  }
}