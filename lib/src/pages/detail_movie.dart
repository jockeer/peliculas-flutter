import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/actores_provider.dart';
import 'package:peliculas/src/widget/actor_card_widget.dart';


class DetailMovie extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar( pelicula ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo( context, pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),
                _descripcion( pelicula ),
                Container(
                  child: Text('Actores', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                  padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
          
                ),
                _actores( pelicula ),
              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo( BuildContext context,Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.id_pelicula_card,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow[700],),
                    Text( pelicula.voteAverage.toString(),style: Theme.of(context).textTheme.subtitle1)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(pelicula.overview, textAlign: TextAlign.justify,),
    );
  }

  Widget _actores(Pelicula pelicula) {
    final actorProvider = new ActoresProvider();

    return FutureBuilder(
      future: actorProvider.getActores(pelicula.id.toString()),
      // initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.hasData) {
          return _crearActoresPageView( snapshot.data );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );


  }

  Widget _crearActoresPageView(List<Actor> actores ) {
    return Container(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemCount: actores.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemBuilder: (BuildContext context, idx){
          return ActorCardWidget(actor: actores[idx]);
        },
      )
    );
  }
}