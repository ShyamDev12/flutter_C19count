import 'dart:convert';
//http: ^0.12.2
//intl: ^0.16.1
//name: flutter_one
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
Future<Covid> fetchData() async{
  final response = await http
      .get('https://corona.lmao.ninja/v2/countries/india?yesterday=false');
  if(response.statusCode==200){
    return Covid.fromJson(json.decode(response.body));//decode json value we got
  } else{
    throw Exception('Failed to load Covid');
  }
}
class Covid{
  final int cases;
  final int deaths;
  final int recovered;
  final int active;
  final int updated;

  Covid({this.cases, this.deaths, this.recovered, this.active, this.updated});
  factory Covid.fromJson(Map<String,dynamic> jsno){
    return Covid(
      cases: jsno['jsno'],
      deaths: jsno['deaths'],
      recovered: jsno['recovered'],
      active: jsno['active'],
      updated: jsno['updated'],
    );
  }
}
class Dashboard extends StatefulWidget {//stful
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<Covid>futureCovid;
  @override
  void initState() {
    futureCovid=fetchData();
    super.initState();
  }
  String _dataValue(int timeInMillis){
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    var formattedData =
    DateFormat("dd-MM-yyyy hh:mm:ss").format(date);
    return formattedData.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Covid>(
        future: futureCovid,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/covidflutter.jpg"),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter
                      )
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Cases : ',
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.blue,
                            ),
                          ),
                          Text(snapshot.data.cases.toString(),style: TextStyle(fontSize: 25.0),)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Deaths : ',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.red,
                            ),
                          ),
                          Text(snapshot.data.deaths.toString(),style: TextStyle(fontSize: 25.0),)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Recover : ',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.green,
                            ),
                          ),
                          Text(snapshot.data.recovered.toString(),style: TextStyle(fontSize: 25.0),)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Active : ',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.yellow,
                            ),
                          ),
                          Text(snapshot.data.active.toString(),style: TextStyle(fontSize: 25.0),)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Current news \n Last Update : ${_dataValue(snapshot.data.updated)}'
                          ),
                        ],
                      ),
                    ),
                  ),
                )

              ],
            );
          } else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }
            return Center(
              child: CircularProgressIndicator(),
            );
        },

      ),
    );
  }
}
