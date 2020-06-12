import 'package:flutter/material.dart';
import 'package:year_countdown/grid.dart';
import 'package:year_countdown/life.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(ScopedModel(
    child: MyApp(),
    model: Life("me"),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YearCountdown',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateTime.now().toString().substring(0, 10),
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: "Barriecito"),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ScopedModelDescendant<Life>(
          builder: (BuildContext context, Widget child, Life model) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.blue,
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                    value: model.pastDays()/model.life,
                  ),
                ),
                Grid(life: model),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 40),
                        child: Container(
                            height: 48,
                            child: Image.asset("asset/iron_man.png")),
                      ),
                      Text(
                          model.remainingDays().toString() +
                              " / " +
                              model.life.toString(),
                          style: TextStyle(
                              fontSize: 48, fontFamily: "Barriecito")),
                    ],
                  ),
                ),
                Text(
                  "Stay Hungry \t Stay Foolish",
                  style: TextStyle(
                      fontFamily: "Barriecito",
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
