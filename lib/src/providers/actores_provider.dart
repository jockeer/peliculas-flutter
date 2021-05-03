import 'dart:async';

import 'package:http/http.dart'as http;

import 'dart:convert';
import 'package:peliculas/src/models/actor_model.dart';

class ActoresProvider{

  String _apikey = '674535e177433f737c75f1f5f7707ffd';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Actor>> getActores(String peliId) async{

    final url = Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key' : _apikey,
      'language' : _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = new Actores.fromJsonList(decodedData['cast']);
   
    return cast.actores;
  }

}