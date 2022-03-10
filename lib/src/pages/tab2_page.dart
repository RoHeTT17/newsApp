import 'package:appnews/src/models/categoryModel.dart';
import 'package:appnews/src/services/news_service.dart';
import 'package:appnews/src/theme/tema.dart';
import 'package:appnews/src/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Tab2Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newService = Provider.of<NewsService>(context);  

    return SafeArea(
      child: Scaffold(
        body: Column(

          children: [
            
            const _ListCategory(),
            Expanded(

              child: ( newService.getArticulosCategoriaSeleccionada!.length ==0)
                     ? Center(child: CircularProgressIndicator(color: miTema.colorScheme.secondary,),) 
                     : ListaNoticias(noticias: newService.getArticulosCategoriaSeleccionada!)
              )

          ],

        )
       ),
    );
  }
}

class _ListCategory extends StatelessWidget {
  
  const _ListCategory({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   final categories = Provider.of<NewsService>(context).categories;   

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){

            final categoryName = categories[index].name;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _CategoryButton(categoria: categories[index]),
                  const SizedBox(height: 5,),
                  //Mostrar la primer letra de la categoría en mayúsculas
                  Text('${categoryName[0].toUpperCase()}${categoryName.substring(1)}')
                ],
              ),
              
              );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  
  final Category categoria;

  const _CategoryButton({Key? key, required this.categoria, }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: (categoria.name == newsService.getSelectedCategory)
                 ? miTema.colorScheme.secondary
                 : Colors.black54,
        ),
      ),

      onTap:(){
          final newsService = Provider.of<NewsService>(context,listen: false);
          newsService.setSelectedCategory = categoria.name;
      },

    );
  }
}