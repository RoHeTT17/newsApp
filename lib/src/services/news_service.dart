import 'package:appnews/src/models/categoryModel.dart';
import 'package:flutter/material.dart';
import 'package:appnews/src/models/newsModels.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

const _URL_BASE = 'https://newsapi.org/v2';
const _API = '18544e37314b47369a008d3b57eb0d85';

class NewsService with ChangeNotifier{

  List<Article> headlines = [];

  //Categoría seleccionada, por default es business
  String _selectedCategory = 'business';

  List<Category> categories = [
      Category(FontAwesomeIcons.building,        'business'),
      Category(FontAwesomeIcons.tv,              'entertainment'),
      Category(FontAwesomeIcons.addressCard,     'general'),
      Category(FontAwesomeIcons.headSideVirus,   'health'),
      Category(FontAwesomeIcons.vials,           'science'),
      Category(FontAwesomeIcons.volleyballBall,  'sports'),
      Category(FontAwesomeIcons.memory,          'technology'),  
  ];

 //Crear un map, para almacenar los datos cargados y tenerlos en cache, dando la sensación de que la app es mas rapida
  Map<String, List<Article>> categoryArticles ={};

  NewsService(){

    getTopHeadLines();

    //Inicializar el Map categoryArticles
    //recorrer el arreglo de las categorias
    categories.forEach((element) { 
        //Pasamos el nombre de la categoria al  categoryArticles
        categoryArticles[element.name] = new List.empty();
    });

    //Para cargar por default el busines
    this.getArticlesByCategory(this._selectedCategory);

  }

  //getters y setters
  get getSelectedCategory => this._selectedCategory;

  set setSelectedCategory(String categoria){
      this._selectedCategory = categoria;

      //Hacer la petición de la categoria seleccionada
      getArticlesByCategory(categoria);

      //Avisar que cambio la categoría
      notifyListeners();
  }

  //Métodos
  getTopHeadLines() async{
    //url del End point

    const url = '$_URL_BASE/top-headlines?apiKey=$_API&country=mx';

    //Hacer la petición
    final resp = await http.get(Uri.parse(url));

    /*
    Otra manera
    var uri = Uri.https('newsapi.org', '/v2/top-headlines',
        {'country': 'it', 'apiKey': 'myapikey'});
    final resp = await http.get(uri); 
    */

    //El body contiene la respuesta de la petición
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();

  }

  getArticlesByCategory( String category) async{

    if(categoryArticles[category]!.length>0){
      
      return this.categoryArticles[category];

    } else{


   /* final url = '$_URL_BASE/top-headlines?apiKey=$_API&country=mx&category=$category';
    //Hacer la petición
    final resp = await http.get(Uri.parse(url));*/

    var uri = Uri.https('newsapi.org', '/v2/top-headlines',{
      'country' : 'mx', 
      'apiKey'  : '$_API',
      'category': '$category'
      });
    
    final resp = await http.get(uri); 

    //El body contiene la respuesta de la petición
    final newsResponse = newsResponseFromJson(resp.body);

    //this.categoryArticles[category]?.addAll(newsResponse.articles);
    this.categoryArticles[category] = newsResponse.articles;

    }
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>  this.categoryArticles[_selectedCategory];

}