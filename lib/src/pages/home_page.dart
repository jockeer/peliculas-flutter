import 'package:flutter/material.dart';


import 'package:peliculas/src/widget/card_swiper_widget.dart';

import 'package:peliculas/src/providers/peliculas_provider.dart';


class HomePage extends StatelessWidget {
  
  final _peliculasProvider = new PeliculasProvider(); 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.lightBlue[900],
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _swiperTarjetas(),
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
          return CardSwiper(
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
}