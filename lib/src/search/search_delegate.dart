import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';


class DataSearch extends SearchDelegate {

  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America',
  ];
  final peliculasRecientes = [
    'Spiderman',
    'Capitan America'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
      // las acciones de nuestro AppBar
      
      return[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = '';
          },
        )
      ];

      // throw UnimplementedError();

    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono ala izquiera del AppBar

      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        },
      );
    
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Crea los resultados que vamos a mostrar
      return Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.blueAccent,
          child: Text(seleccion),
        ),
      );

    }
  
    @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias cuando la persona escribe
  
    if (query.isEmpty) {
      return Container();
    }else{
      return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;
            return ListView(
              children: peliculas.map((peli){
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(peli.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(peli.title),
                  subtitle: Text(peli.originalTitle),
                  onTap: (){
                    close(context, null);
                    peli.id_pelicula_card='';
                    Navigator.pushNamed(context, 'detalle', arguments: peli);
                  },
                );
              }).toList()
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }

  // Widget buildSuggestions(BuildContext context) {
  //   // Son las sugerencias cuando la persona escribe
     
  //   final listaSugerida = (query.isEmpty) 
  //                           ? peliculasRecientes 
  //                           : peliculas.where((movie) => movie.toLowerCase().startsWith(query.toLowerCase())
  //                         ).toList();

  //   return ListView.builder(
  //      itemCount: listaSugerida.length,
  //      itemBuilder: (context, i){
  //        return ListTile(
  //          leading: Icon(Icons.movie),
  //          title: Text(listaSugerida[i]),
  //          onTap: (){
  //            seleccion = listaSugerida[i];
  //            showResults(context);
  //          },
  //        );
  //      },
  //    );
  //   // throw UnimplementedError();
  // }

}