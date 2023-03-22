import 'package:dicoding_news_app/api/api_service.dart';
import 'package:dicoding_news_app/model/article.dart';
import 'package:dicoding_news_app/provider/news_provider.dart';
import 'package:dicoding_news_app/ui/article_web_view.dart';
import 'package:dicoding_news_app/ui/article_list_page.dart';
import 'package:dicoding_news_app/ui/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: ArticleListPage.routeName,
      routes: {
        ArticleListPage.routeName: (context) =>
            ChangeNotifierProvider<NewsProvider>(
              create: (_) {
                return NewsProvider(apiService: ApiService());
              },
              child: const ArticleListPage(),
            ),
        ArticleDetailPage.routeName: (context) => ArticleDetailPage(
            article: ModalRoute.of(context)?.settings.arguments as Article),
        ArticleWebPage.routeName: (context) => ArticleWebPage(
            url: ModalRoute.of(context)?.settings.arguments as String)
      },
    );
  }
}
