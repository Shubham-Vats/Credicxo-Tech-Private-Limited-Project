import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String trackID;
Map details;
Map lyrics;

class SecondScreen extends StatefulWidget {
  
  final int trackId;
  const SecondScreen({Key key, @required this.trackId}) : super(key: key);
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  
  //Function to get Specific details with Track ID
  Future getSpecificData() async{
    trackID=widget.trackId.toString();
    String url = "https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
    try {
      http.Response response = await http.get(url);
      if(response.statusCode == 200){
        print("Details Successfully Fetched");
        setState(() {
        details = json.decode(response.body);
        });
      }
      else{
        print("No Details Fetched");
      }
    }catch (e) {
      debugPrint(e.toString());
    }
  }

  //Function to get Specific Lyrics with Track ID
  Future getSpecificLyrics() async{
    trackID=widget.trackId.toString();
    String url = "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
    try {
      http.Response response = await http.get(url);
      if(response.statusCode == 200){
        print("Lyrics Successfully Fetched");
        setState(() {
        lyrics = json.decode(response.body);
        });
      }
      else{
        print("No Lyrics Fetched");
      }
    }catch (e) {
      debugPrint(e.toString());
    }  
  }

  @override
  void initState() {
    super.initState();
    getSpecificData();
    getSpecificLyrics();
  }
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      trackID = widget.trackId.toString();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Track Details",style: TextStyle(color: Colors.black),),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.black)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Name",style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 6.0,),
                  Text("${details["message"]["body"]["track"]["track_name"]}", style: TextStyle(fontSize: 20.0),)
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Artist",style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 6.0,),
                  Text("${details["message"]["body"]["track"]["artist_name"]}", style: TextStyle(fontSize: 20.0),)
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Album Name",style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 6.0,),
                  Text("${details["message"]["body"]["track"]["album_name"]}", style: TextStyle(fontSize: 20.0),)
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Explicit",style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 6.0,),
                  Text(details["message"]["body"]["track"]["explicit"] == 0 ? "False" : "True", style: TextStyle(fontSize: 20.0),)
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Rating",style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 6.0,),
                  Text("${details["message"]["body"]["track"]["track_rating"]}", style: TextStyle(fontSize: 20.0),)
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Lyrics",style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
                  SizedBox(height: 6.0,),
                  Text("${lyrics["message"]["body"]["lyrics"]["lyrics_body"]}", style: TextStyle(fontSize: 20.0),)
                ],
              ),
            ]
          ),
        ),
      )
    );
  }
}
