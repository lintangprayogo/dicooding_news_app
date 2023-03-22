import 'package:dicoding_news_app/model/article.dart';
import 'package:dicoding_news_app/ui/article_web_view.dart';
import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            article.urlToImage != null
                ? Image.network(article.urlToImage!)
                : const Text("no image"),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(article.description!),
                  const Divider(color: Colors.grey),
                  Text(
                    article.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  Text('Date: ${article.publishedAt ?? ""}'),
                  const SizedBox(height: 10),
                  Text('Author: ${article.author ?? ""}'),
                  const Divider(color: Colors.grey),
                  Text(
                    article.description!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: const Text('Read more'),
                    onPressed: () {
                      Navigator.pushNamed(context, ArticleWebPage.routeName,
                          arguments: article.url);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
