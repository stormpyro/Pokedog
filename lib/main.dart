import 'package:flutter/material.dart';
import 'package:pokedog/util/dog_helper.dart';
import 'package:pokedog/widgets/dog_galery.dart';

void main() {
  runApp(MyApp());
}

List colores = [
  Color.fromRGBO(55, 59, 94, 1),
  Color.fromRGBO(38, 67, 196, 1),
  Color.fromRGBO(157, 154, 180, 1),
  Color.fromRGBO(244, 246, 253, 1),
  Color.fromRGBO(173, 186, 219, 1),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme: IconThemeData(color: Color.fromRGBO(140, 140, 140, 1)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PokeDog(),
    );
  }
}

class PokeDog extends StatefulWidget {
  @override
  _PokeDogState createState() => _PokeDogState();
}

HttpHelper dogProvider;

class _PokeDogState extends State<PokeDog> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    dogProvider = HttpHelper();
    dogProvider.getRazas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colores[3],
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  'PokeDog',
                  style: TextStyle(fontSize: 20),
                ),
                accountEmail: null,
                currentAccountPicture: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/logo.jpg'))),
                ),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Row(
              children: [
                SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () => _scaffoldKey.currentState.openDrawer()),
                )),
              ],
            ),
            Text(
              'Welcome to PokeDog!!',
              style: TextStyle(
                  fontSize: 30, color: colores[0], fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  shrinkWrap: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: dogProvider.razas.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (c, i) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DogGalery(
                                    dogProvider.razas[i], dogProvider),
                              ));
                        },
                        child: Container(
                            color: Colors.green,
                            child: Center(
                                child: Text(
                              dogProvider.razas[i].toUpperCase(),
                              style: TextStyle(fontSize: 18),
                            ))),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
