import 'package:flutter/material.dart';
import 'package:pokedog/util/dog_helper.dart';

import '../main.dart';

class DogGalery extends StatefulWidget {
  String raza;
  HttpHelper provider;
  DogGalery(this.raza, this.provider);
  @override
  _DogGaleryState createState() => _DogGaleryState(raza, provider);
}

class _DogGaleryState extends State<DogGalery> {
  String raza;
  HttpHelper provider;
  _DogGaleryState(this.raza, this.provider);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(raza),
      ),
      body: FutureBuilder(
        future: provider.getDogs(raza),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List imgs = snapshot.data;
            return ListView.builder(
              itemCount: imgs.length,
              itemBuilder: (c, i) => FadeInImage.assetNetwork(
                placeholder: 'assets/logo.jpg',
                image: imgs[i],
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: colores[0],
              ),
            );
          }
        },
      ),
    );
  }
}
