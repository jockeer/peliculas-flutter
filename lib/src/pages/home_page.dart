import 'package:flutter/material.dart';


import 'package:peliculas/src/widget/card_swiper_widget.dart';

import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widget/movie_horizontal_widget.dart';
import 'package:peliculas/src/search/search_delegate.dart';


class HomePage extends StatelessWidget {
  
  final _peliculasProvider = new PeliculasProvider(); 


  @override
  Widget build(BuildContext context) {

    _peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.lightBlue[900],
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                context: context, 
                delegate: DataSearch(),
                // query: 'Hola',
              
              );  
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    
    return FutureBuilder(
      future: _peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiperWidget(
            peliculas: snapshot.data,
          );
          
        }else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      },
    );
    
  }

  Widget _footer( BuildContext context ) {
    
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Polulares', style: Theme.of(context).textTheme.headline6,)  
          ),
          SizedBox(height: 10.0,),

          StreamBuilder(
            stream: _peliculasProvider.polularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if(snapshot.hasData){
                return MovieHorizonalWidget(peliculas: snapshot.data, siguientePagina: _peliculasProvider.getPopulares,);
              } else{
              return Center(child: CircularProgressIndicator());

              }
                
            },
          ),
        ],
      ),
    );
  }
}