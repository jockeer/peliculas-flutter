import 'package:flutter/material.dart';

import 'package:peliculas/src/pages/detail_movie.dart';
import 'package:peliculas/src/pages/home_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    '/' : (BuildContext context) => HomePage(),
    'detalle' : (BuildContext context) => DetailMovie(),
    
  };
}