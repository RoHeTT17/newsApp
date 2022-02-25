
import 'package:appnews/src/services/news_service.dart';
import 'package:flutter/material.dart';
import 'package:appnews/src/pages/tabs_page.dart';

import 'package:appnews/src/theme/tema.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
           ChangeNotifierProvider<NewsService>(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: miTema,
        title: 'Material App',
        home: TabsPage()
      ),
    );
  }
}