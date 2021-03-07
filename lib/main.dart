import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'forfait voyages',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.destination,this.dateDepart,this.dateRetour,this.prix,this.rabais,this.vedette, this.hotel, this.villeDepart}) : super(key: key);

  final String destination;
  final String dateDepart;
  final String dateRetour;
  final String villeDepart;
  final int prix;
  final int rabais;
  final bool vedette;
  final String hotel;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List data;

  Future<String> getData() async {
    var response =await http.get(Uri.https('forfaits-voyages.herokuapp.com', '/api/forfaits/da/1996457', {}));


    setState(() {
      data = json.decode(response.body);
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voyages Miguel"),
      ),
      body: Center(
        child: getList(),
      ),
    );
  }

  Widget getList() {
    if (data == null || data.length < 1) {
      return Container(
        width: 50,
        height: 50,
        child: Center(
          child: Text("Please wait..."),
        ),
      );
    }
    return ListView.separated(
      itemCount: data?.length,
      itemBuilder: (BuildContext context, int index) {
        return getListItem(index);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget getListItem(int i) {
    if (data == null || data.length < 1) return null;
    if (i == 0) {
      return Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.all(4),
        child: Center(
          child: Text(
            "Forfaits voyages",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Container(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent)
        ),
        margin: EdgeInsets.all(60.0),
        child: Padding(
          padding: EdgeInsets.all(5),

          child: Text( 'Destination :'+
            data[i]['destination'].toString()+ '\n\nDate de départ : ' + data[i]['dateDepart'].toString()+ '\n\nDate de Retour : ' + data[i]['dateRetour'].toString()+data[i]['dateDepart'].toString()+ '\n\nVille de départ : '+ data[i]['villeDepart'].toString()+ '\n\nPrix : ' +data[i]['prix'].toString()+'\u0024'+ '\n\nRabais : '+data[i]['rabais'].toString()+'\u0024'+ '\n\nVedette : '+data[i]['vedette'].toString(),

              style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

}


