import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_firebase_backend_app/DetailsPage.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Top Post
  StreamSubscription<QuerySnapshot>subscription;
  // For Body Post
  StreamSubscription <QuerySnapshot> sdSubscription;
  List<DocumentSnapshot> sdSnapshot;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference= Firestore.instance.collection("TopPost");
  CollectionReference sdCollectionReference=Firestore.instance.collection("BodyPost");
  @override
  void initState() {
    // TODO: implement initState
    subscription=collectionReference.snapshots().listen((datasnapshot){
      setState(() {
        snapshot=datasnapshot.documents;
      });
    });
    sdSubscription=sdCollectionReference.snapshots().listen((sddataSnapshot){
      sdSnapshot=sddataSnapshot.documents;
    });
    super.initState();
  }
  passData(DocumentSnapshot snap){
    Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>DetailPage(snapshot: snap,)));
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
            height:200,
            child: new ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
              return Card(
                elevation:10.0,
                margin: EdgeInsets.all(10.0),
              child: new Container(
//                padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  child: new Column(
                children: <Widget>[
                  new ClipRRect(
                      borderRadius: new BorderRadius.circular(15.0),
                      child: new Image.network(snapshot[index].data["url"],
                          height:120.0,
                          width: 120.0,
                          fit: BoxFit.cover
                      )
                  ),
                  new SizedBox(height: 10.0,),
                  new Text(snapshot[index].data["title"],
                  style: TextStyle(fontSize: 19.0,color: Colors.pink),
                  ),
                ],
              ))
              );
            },itemCount: snapshot.length),
          ) ,//end of first container
          new Container(
            height:MediaQuery.of(context).size.height,// take the full height of the image
            child: new ListView.builder(
              itemBuilder: (context,index){
                return Card(
                  elevation:7.0,
                  margin:EdgeInsets.all(10.0),
                  child: new Column(
                    children: <Widget>[
                new Row(
                  children: <Widget>[
                    new CircleAvatar(
                      child: new Text(sdSnapshot[index].data["title"][0]),
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                    ),
                   new  SizedBox(width: 10.0,),
                new InkWell(
                  child:new Text(sdSnapshot[index].data["title"],
                      style: TextStyle(fontSize: 20.0,color:Colors.pink)),

                onTap: (){
                    passData(sdSnapshot[index]);
                },
                ),

//                    new Text(sdSnapshot[index].data["title"])
                  ],
                ),

                new Column(
                  children: <Widget>[
                    new ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: new Image.network(sdSnapshot[index].data["url"],
                      height:150.0,
                      fit: BoxFit.cover
                      )
                    ),
            new SizedBox(height: 10.0,),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Icon(Icons.thumb_up, color: Colors.deepPurple,),
                new Icon(Icons.share, color: Colors.green,),
                new Icon(Icons.thumb_up,color: Colors.yellowAccent,)

              ],)
                  ],
                )
                    ],
                  ),


                );
              },
              itemCount: sdSnapshot.length,
            )
          )
        ],
      )
    );
  }
}
