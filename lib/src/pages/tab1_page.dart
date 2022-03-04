import 'package:appnews/src/services/news_service.dart';
import 'package:appnews/src/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//1. Se conviert de un StatelessWidget a StatefulWidget para poder mantener el estado del Widget (que no lo destruya fluuter)

class Tab1Screen extends StatefulWidget {

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);  

    return Scaffold(
      // body: ListaNoticias(noticias: newsService.headlines),
      body: (newsService.headlines.length == 0)
            ? const Center(child: CircularProgressIndicator.adaptive(),)
            :ListaNoticias(noticias: newsService.headlines),
   );
  }

  @override
  //2. se usa el with AutomaticKeepAliveClientMixin y crear el override que indica el proceso.
  // TODO: implement wantKeepAlive
  //3. true para siempre mantener el estado
  bool get wantKeepAlive => true;
}