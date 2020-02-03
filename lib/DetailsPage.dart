import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DetailPage extends StatefulWidget {

  @override
  _DetailPageState createState() => _DetailPageState();
  DocumentSnapshot snapshot;
  DetailPage({this.snapshot});
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Post Details"),
        backgroundColor: Colors.green,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.all(5.0),
        child:new Card(
          elevation:9.0 ,
          child: new Container(
            child: new Row(
              children: <Widget>[
                new CircleAvatar(
                  child: new Text(widget.snapshot.data["title"][0]),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                new SizedBox(width: 10.0,),
                new Text(widget.snapshot.data["title"],
                    style:TextStyle(fontSize: 21.0,color:Colors.green)),

              ],

            ),
          ),
         )
          ),
          new Container(
            margin: EdgeInsets.all(10.0),
            child: new ClipRRect(
              borderRadius: new BorderRadius.circular(10.0),
              child: new Image.network(widget.snapshot.data["url"],
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,),
            ),
          )

        ],
      )
    );
  }
}
