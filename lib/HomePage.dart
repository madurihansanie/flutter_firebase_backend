import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription<QuerySnapshot>subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference= Firestore.instance.collection("TopPost");
  @override
  void initState() {
    // TODO: implement initState
    subscription=collectionReference.snapshots().listen((datasnapshot){
      setState(() {
        snapshot=datasnapshot.documents;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Firebase Backend App"),
        backgroundColor: Colors.purple,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.search), onPressed:()=> debugPrint("Search")),
          new IconButton(icon: new Icon(Icons.add), onPressed: ()=>debugPrint("Add"))
        ],
      ),

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text("Maduri Hansanie"), accountEmail: new Text("mad@gmail.com"),
            decoration: new BoxDecoration(color: Colors.deepPurpleAccent),

            ),
        new ListTile(
          title: new Text("First Page"),
          leading: new Icon(Icons.search,color: Colors.green),
        ),
            new ListTile(
              title: new Text("Second Page"),
              leading: new Icon(Icons.cake,color:Colors.green),
            ),
            new ListTile(
              title: new Text("Third Page"),
              leading: new Icon(Icons.add, color:Colors.green),
            ),
            new Divider(
              height: 10.00,
              color: Colors.black,
            ),
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.close,color:Colors.red),
              onTap: (){
                Navigator.of(context).pop();
              },
            )
          ],
        )
      ),
      body:new ListView(
        children: <Widget>[
          new Container(
            height:250,
            child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
              return Card(
                elevation:10.0,
                margin: EdgeInsets.all(10.0),
                child: new Column(
                  children: <Widget>[
                    new ClipRRect(
                    borderRadius: new BorderRadius.circular(10.0),
                      child: new Image.network(snapshot[index].data["url"],
                      height:180.0,
                      width: 180.0,
                      fit: BoxFit.cover
                      )
                    ),
                    new SizedBox(height: 10.0,),
                    new Text(snapshot[index].data["title"])
                  ],
                )
              );
            },itemCount: snapshot.length),
          )
        ],
      )
    );
  }
}
