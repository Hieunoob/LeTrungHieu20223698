import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news_model.dart';
import '../providers/news_provider.dart';

class DetailScreen extends StatelessWidget {
  final News news;
  const DetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chi tiết tin tức')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(news.imageUrl, width: double.infinity, height: 250, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(news.date, style: const TextStyle(color: Colors.grey)),
                  const Divider(),
                  Text(news.body, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<NewsProvider>(context, listen: false).toggleFavorite(news);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã cập nhật yêu thích!')));
        },
        child: Icon(news.isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
      ),
    );
  }
}