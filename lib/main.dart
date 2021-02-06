import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Numeros ",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  var data;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://examenfinalnas.azurewebsites.net/api/Literal"),
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
        });
    data = json.decode(response.body);

    print(data["Literal"]);
    myController.text = data["Literal "];
    return "Satisfactorio";
  }

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Numero"),
      ),
      body: ListView(children: <Widget>[
        Container(
          child: Image.network(
              "https://c8.alamy.com/compes/kd3hpx/jugar-un-juego-de-dados-en-el-aire-kd3hpx.jpg"),
          padding: EdgeInsets.all(20.0),
        ),
        Center(
            child: new RaisedButton(
                child: Text("Lanzar los dados para obtener un número"),
                onPressed: getData)),
        Container(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            controller: myController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ),
      ]),
    );
  }
}
