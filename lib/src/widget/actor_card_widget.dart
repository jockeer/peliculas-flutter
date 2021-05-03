import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';

class ActorCardWidget extends StatelessWidget {

  final Actor actor;

  ActorCardWidget({ @required this.actor}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPhoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis,)
        ],
      ),

    );
  }
}