import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiperWidget extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiperWidget({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: _screenSize.width,
      height: _screenSize.height *0.5,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.6,
        itemBuilder: (BuildContext context, int index){
          peliculas[index].id_pelicula_card = '${peliculas[index].id}-card-pelicula';
          return Hero(
              tag: peliculas[index].id_pelicula_card,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: ()=>Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                  child: FadeInImage(
                    height: _screenSize.height *0.5,
                    image: NetworkImage( peliculas[index].getPosterImg() ),
                    placeholder: AssetImage('assets/img/loading.gif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          );
        },
        itemCount: peliculas.length,
        // pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}