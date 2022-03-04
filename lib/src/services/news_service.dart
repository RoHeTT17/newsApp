import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:appnews/src/models/newsModels.dart';
import 'package:http/http.dart' as http;

const _URL_BASE = 'https://newsapi.org/v2';
const _API = '18544e37314b47369a008d3b57eb0d85';

class NewsService with ChangeNotifier{

  List<Article> headlines = [];

  NewsService(){

    getTopHeadLines();

  }


  getTopHeadLines() async{
    //url del End point

    const url = '$_URL_BASE/top-headlines?apiKey=$_API&country=mx';

    /*
    Otra manera
    var uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'it', 'apiKey': 'myapikey'});
    final resp = await http.get(uri); 
    */

    //Hacer la petición
    final resp = await http.get(Uri.parse(url));

    //El body contiene la respuesta de la petición
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();

  }

}