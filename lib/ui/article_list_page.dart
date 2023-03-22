import 'package:dicoding_news_app/api/api_service.dart';
import 'package:dicoding_news_app/model/article.dart';
import 'package:dicoding_news_app/provider/news_provider.dart';
import 'package:dicoding_news_app/widget/card_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  static const routeName = '/article_list';

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<ArticlesResult> _article;

  @override
  void initState() {
    super.initState();
    _article = ApiService().topHeadLines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("News App"),
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return Consumer<NewsProvider>(builder: (context, value, child) {
      if (value.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (value.state == ResultState.hasData) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: value.result.articles.length,
            itemBuilder: (context, index) {
              return CardArticle(article: value.result.articles[index]);
            });
      } else if (value.state == ResultState.error) {
        return Center(
          child: Material(
            child: Text(value.message),
          ),
        );
      } else {
        return const Center(
          child: Material(
            child: Text("Tidak Ada Data"),
          ),
        );
      }
    });
  }
}
