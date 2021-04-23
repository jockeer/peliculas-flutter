import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{
  String _apikey = '674535e177433f737c75f1f5f7707ffd';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async{

    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language' : _language,
      // 'page' : 1
    });
   
    final resp = await http.get( url );
    
    final decodedData = json.decode(resp.body);

    // print(decodedData['results']);
    
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    // print(peliculas.items[0].title);
    

    return peliculas.items;
  }

}