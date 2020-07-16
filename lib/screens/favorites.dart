import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/favorite_bloc.dart';
import 'package:fluttertube/model/video.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.values.isEmpty) {
              return Center(
                child: Icon(Icons.not_interested, color: Colors.white70, size: 100,),
              );
            } else {
              return ListView(
                children: snapshot.data.values.map((v) {
                  return InkWell(
                    onTap: () => {},
                    onLongPress: () => bloc.toggleFavorite(v),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 50,
                          child: Image.network(v.thumb),
                        ),
                        Expanded(
                          child: Text(
                            v.title,
                            style: TextStyle(color: Colors.white70),
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
