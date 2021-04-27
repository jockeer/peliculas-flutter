import 'dart:async';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{
  String _apikey = '674535e177433f737c75f1f5f7707ffd';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _polularesPage = 0;
  
  bool _cargando = false;

  List<Pelicula> _polulares = [];

  final _polularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get polularesSink => _polularesStreamController.sink.add;

  Stream<List<Pelicula>> get polularesStream => _polularesStreamController.stream;

  void disposeStreams(){
    _polularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp = await http.get( url );
    
    final decodedData = json.decode(resp.body);

    // print(decodedData['results']);
    
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    // print(peliculas.items[0].title);
    

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async{

    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language' : _language,
      // 'page' : 1
    });
   
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async{
    if (_cargando) {
      return [];
    }
    _cargando = true;
    _polularesPage++;
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language' : _language,
      'page' : _polularesPage.toString()
      // 'page' : 1
    });

    final resp = await _procesarRespuesta(url);

    _polulares.addAll(resp);

    polularesSink(_polulares);
    _cargando = false;
    return resp;
    
    
  }

}