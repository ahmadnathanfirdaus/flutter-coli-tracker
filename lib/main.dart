import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false,));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String currentDate =
      "[${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}]";
  String date;
  List<String> data = [];
  SharedPreferences prefs;

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  void loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pelacak Coli'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  'Apakah anda coli hari ini?',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    saveData();
                    if(date != currentDate) {
                      date = currentDate;
                      data.add('$currentDate : anda coli');
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Selamat! Anda coli!'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text('Lihat Riwayat'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    history();
                                  },
                                )
                              ],
                            );
                          }
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('Anda sudah absen coli hari ini'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text('Lihat Riwayat'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  history();
                                },
                              )
                            ],
                          );
                        }
                      );
                    }
                  });
                },
                child: Center(
                  child: Text(
                    'Ya',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    saveData();
                    if(date != currentDate) {
                      date = currentDate;
                      data.add('$currentDate : anda tidak coli');
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Selamat! Anda tidak coli!'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text('Lihat Riwayat'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    history();
                                  },
                                )
                              ],
                            );
                          }
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Anda sudah absen coli hari ini'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text('Lihat Riwayat'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    history();
                                  },
                                )
                              ],
                            );
                          }
                      );
                    }
                  });
                },
                child: Center(
                  child: Text(
                    'Tidak',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void saveData() {
    List<String> dataColi = data;
    String dateColi = date;
    prefs.setStringList('data', dataColi);
    prefs.setString('date', dateColi);
  }

  void loadData() {
    List<String> dataColi = prefs.getStringList('data');
    String dateColi = prefs.getString('date');
    if(dataColi != null) data = dataColi;
    date = dateColi;
    setState(() {

    });
  }

  void history() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) {
      return routePage();
    }));
  }

  Scaffold routePage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Coli'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                data[index],
                style: TextStyle(fontSize: 16),
              ),
            );
          }),
    );
  }
}
