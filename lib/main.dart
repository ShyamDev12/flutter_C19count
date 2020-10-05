import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_one/dashboard.dart';
import 'package:flutter_one/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'C-19',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
          display1: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,
          ),
          headline: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,
          )
        ),
      ),

      home: startScreen(),
    );
  }
}

class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/covidflutter.jpg"),
                  fit: BoxFit.cover,
                )
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "COVID 19\n",
                        style: Theme.of(context).textTheme.display1,
                      ),
                      TextSpan(
                        text: "STAY HOME STAY SAFE",
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ]

                  ),
                ),
              ],
            ),
          ),
          FittedBox(
            child: GestureDetector(
              //button work
              onTap: (){
                //calling dashboard
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Dashboard();
                }));
              },
              child: Container(//bottom button
                margin: EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),color: Colors.red),
                child: Row(
                  children: <Widget>[
                    Text('View Details'),
                    Icon(Icons.arrow_forward_ios)//line in button
                  ],
                ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
