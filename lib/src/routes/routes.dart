import 'package:peliculas/src/pages/home_page.dart';
import 'package:flutter/material.dart';


Map<String, WidgetBuilder> getAplicationRoutes(){
  return <String, WidgetBuilder>{
    '/' : (BuildContext context) => HomePage()
  };
}