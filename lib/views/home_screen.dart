import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import 'detail_screen.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Tự động gọi API khi vào App
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteScreen())),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Tìm kiếm tin tức...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (val) => newsProvider.searchNews(val),
            ),
          ),
        ),
      ),
      body: newsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : newsProvider.errorMessage.isNotEmpty
          ? Center(child: Text(newsProvider.errorMessage))
          : RefreshIndicator(
        onRefresh: () => newsProvider.fetchNews(),
        child: ListView.builder(
          itemCount: newsProvider.displayNews.length,
          itemBuilder: (context, index) {
            final item = newsProvider.displayNews[index];
            return ListTile(
              leading: Image.network(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
              title: Text(item.title, maxLines: 1),
              subtitle: Text(item.date),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(news: item))),
            );
          },
        ),
      ),
    );
  }
}