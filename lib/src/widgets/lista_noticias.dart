import 'package:appnews/src/models/newsModels.dart';
import 'package:appnews/src/theme/tema.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;

  const ListaNoticias({Key? key,required  this.noticias}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index){
          // return Text(this.noticias[index].title);
      
        return _Noticia(noticia: this.noticias[index], index: index);
      }
    );
  }
}

class _Noticia extends StatelessWidget {
 
 final Article noticia;
 final int index;

 const _Noticia({Key? key, required this.noticia,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

        child: Column(
          children: [
            _TarjetaTopBar(noticia: noticia, index: index),
            _TarjetaTitulo(noticia: noticia),
            _TarjetaImagen(noticia: noticia),
            _TarjetaBody(noticia: noticia),
            const _TarjetaBotones(),
            const SizedBox( height: 10,),
            const Divider(),
            
          ],
        ),

    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  
  final Article noticia;
  final int index;
  
  const _TarjetaTopBar({Key? key, required this.noticia, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin:  const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Text('${index +1}. ', style: TextStyle(color: miTema.colorScheme.secondary),),
            Text(noticia.source.name,)
          ],
        ),

    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaTitulo({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

          padding: const EdgeInsets.symmetric(horizontal: 15),
          child:Text(noticia.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
        
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaImagen({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String imagenURL = '';

    if(noticia.urlToImage !=null ){

      if(noticia.urlToImage!.contains('https')){
          imagenURL = '${noticia.urlToImage}';
      }else{
          imagenURL = noticia.urlToImage!.replaceFirst('http', 'https');
      }

    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical:10,),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
      
              child: CachedNetworkImage(
                imageUrl: imagenURL,//'${noticia.urlToImage}',
                placeholder: (context,url) => Image.asset('assets/img/giphy.gif'),//CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.asset('assets/img/no-image.png'),
               )
             
              /*child: (noticia.urlToImage !=null) 
                      ? FadeInImage(
                                  placeholder: AssetImage('assets/img/giphy.gif'), 
                                  image: NetworkImage(imagenURL)
                                  )
                      : Image(image: AssetImage('assets/img/giphy.gif'))*/          
                  //image: NetworkImage('${noticia.urlToImage}'
        ),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {

  final Article noticia;

  const _TarjetaBody({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Text( (noticia.description != null) ? noticia.description! : 'No description',textAlign: TextAlign.justify,),
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: (){},
            fillColor: miTema.colorScheme.secondary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20) ),
            child: const Icon(Icons.star_border),
          ),

          const SizedBox(width: 10,),

          RawMaterialButton(
            onPressed: (){},
            fillColor: Colors.amber,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20) ),
            child: const Icon(Icons.more),
          )
        ],
      ),
    );
  }
}