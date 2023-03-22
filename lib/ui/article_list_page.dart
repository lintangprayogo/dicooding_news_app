import 'package:dicoding_news_app/api/api_service.dart';
import 'package:dicoding_news_app/model/article.dart';
import 'package:dicoding_news_app/widget/card_article.dart';
import 'package:flutter/material.dart';

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
        body: FutureBuilder(
          future: _article,
          builder: (context, AsyncSnapshot<ArticlesResult> snapshot) {
            var state = snapshot.connectionState;
            if (state != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.articles.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data?.articles[index];

                    return CardArticle(article: article!);
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Material(
                    child: Text(snapshot.error.toString()),
                  ),
                );
              } else {
                return const Material(child: Text('Unkownn Error'));
              }
            }
          },
        ));
  }
}
