import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<NewsProvider>(context).favoriteNews;
    return Scaffold(
      appBar: AppBar(title: const Text('Tin tức yêu thích')),
      body: favorites.isEmpty
          ? const Center(child: Text('Chưa có bài viết yêu thích'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) => ListTile(
          leading: Image.network(favorites[index].imageUrl, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(favorites[index].title),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(news: favorites[index]))),
        ),
      ),
    );
  }
}