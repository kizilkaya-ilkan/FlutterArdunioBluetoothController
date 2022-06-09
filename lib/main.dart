import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:counter_button/counter_button.dart';
import 'package:ryzen5/screens/left-arm.dart';
import 'package:ryzen5/screens/right-arm.dart';
import 'package:ryzen5/screens/left-leg.dart';
import 'package:ryzen5/screens/right-leg.dart';

final veriyol0 = StateProvider<String?>((ref) => null);
final veriyol1 = StateProvider<String?>((ref) => null);

class ClassName {}

String Sens0 = "00:19:10:09:30:FD";
String Sens1 = "98:D3:41:F9:6D:43";

void main() async {
  runApp(ProviderScope(child: MainPage()));
}

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  int sensor = 1;
  int sensor1 = 0;
  int sensor2 = 0;
  int sensor3 = 0;
  int _currentIndex = 0;

  void initState() {
    super.initState();
    baglantifonksiyoniki();
    baglantifonksiyon();
  }

  @override
  PageController _pageController = PageController(initialPage: 0);
  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.handshake),
      label: 'Left Arm',
      backgroundColor: Colors.black,
    ),
    BottomNavigationBarItem(icon: Icon(Icons.handshake), label: 'Right Arm'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Left Leg'),
    BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Right Leg'),
  ];

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Color.fromARGB(255, 99, 99, 99),
          selectedItemColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Color.fromARGB(255, 37, 37, 37),
          currentIndex: _currentIndex,
          items: _bottomNavigationBarItems,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF404040),
          title: Text(style: TextStyle(color: Colors.white), "NorthTech v1.0"),
          actions: [],
        ),
        drawer: Drawer(
          backgroundColor: Color(0xFF505050),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                // <-- SEE HERE
                decoration: BoxDecoration(color: const Color(0xFF404040)),
                accountName: Text(
                  "NorthTech Yazılım v1.0",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  "northtech@northtech.com.tr",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: FlutterLogo(),
              ),
              ListTile(
                leading: Icon(
                  Icons.help,
                  color: Colors.white,
                ),
                title: Text(style: TextStyle(color: Colors.white), 'Destek'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title:
                    Text(style: TextStyle(color: Colors.white), 'Hakkımızda'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: PageView(
              controller: _pageController,
              onPageChanged: (newIndex) {
                setState(() {
                  _currentIndex = newIndex;
                });
              },
              children: <Widget>[
                Column(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        margin: EdgeInsets.only(top: 50),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new CircularPercentIndicator(
                              animateFromLastPercent: true,
                              animation: true,
                              radius: 60.0,
                              lineWidth: 12.0,
                              percent: ref.watch(veriyol0) == null
                                  ? 0
                                  : int.parse(ref.watch(veriyol0)!) / 100,
                              center: new Text(
                                ref.watch(veriyol0) == null
                                    ? 'NorthTech'
                                    : ref.watch(veriyol0)!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              footer: CounterButton(
                                loading: false,
                                onChange: (int val) {
                                  setState(() {
                                    sensor = val;
                                  });
                                },
                                count: sensor,
                                countColor: Colors.white,
                                buttonColor: Colors.white,
                                progressColor: Colors.white,
                              ),
                              header: new Text(
                                "Sensor 0",
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                  color: Colors.white,
                                ),
                              ),
                              progressColor: Colors.green,
                              backgroundColor: Color(0xFF006600),
                            ),
                            new Padding(
                              padding: EdgeInsets.symmetric(horizontal: 35.0),
                            ),
                            new CircularPercentIndicator(
                              animateFromLastPercent: true,
                              animation: true,
                              radius: 60.0,
                              lineWidth: 12.0,
                              percent: ref.watch(veriyol1) == null
                                  ? 0
                                  : int.parse(ref.watch(veriyol1)!) / 100,
                              center: new Text(
                                ref.watch(veriyol1) == null
                                    ? 'NorthTech'
                                    : ref.watch(veriyol1)!,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              footer: CounterButton(
                                loading: false,
                                onChange: (int val) {
                                  setState(() {
                                    sensor1 = val;
                                  });
                                },
                                count: sensor1,
                                countColor: Colors.white,
                                buttonColor: Colors.white,
                                progressColor: Colors.white,
                              ),
                              header: new Text(
                                "Sensor 1",
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                  color: Colors.white,
                                ),
                              ),
                              progressColor: Colors.pink,
                              backgroundColor: Color(0xFF006600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircularPercentIndicator(
                        animateFromLastPercent: true,
                        animation: true,
                        radius: 60.0,
                        lineWidth: 12.0,
                        percent: ref.watch(veriyol0) == null
                            ? 0
                            : int.parse(ref.watch(veriyol0)!) / 100,
                        center: new Text(
                          ref.watch(veriyol0) == null
                              ? 'NorthTech'
                              : ref.watch(veriyol0)!,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        footer: CounterButton(
                          loading: false,
                          onChange: (int val) {
                            setState(() {
                              sensor2 = val;
                            });
                          },
                          count: sensor2,
                          countColor: Colors.white,
                          buttonColor: Colors.white,
                          progressColor: Colors.white,
                        ),
                        header: new Text(
                          "Sensor 2",
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                        progressColor: Colors.red,
                        backgroundColor: Color(0xFF006600),
                      ),
                      new Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35.0),
                      ),
                      new CircularPercentIndicator(
                        animateFromLastPercent: true,
                        animation: true,
                        radius: 60.0,
                        lineWidth: 12.0,
                        percent: ref.watch(veriyol0) == null
                            ? 0
                            : int.parse(ref.watch(veriyol0)!) / 100,
                        center: new Text(
                          ref.watch(veriyol0) == null
                              ? 'NorthTech'
                              : ref.watch(veriyol0)!,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        footer: CounterButton(
                          loading: false,
                          onChange: (int val) {
                            setState(() {
                              sensor3 = val;
                            });
                          },
                          count: sensor3,
                          countColor: Colors.white,
                          buttonColor: Colors.white,
                          progressColor: Colors.white,
                        ),
                        header: new Text(
                          "Sensor 3",
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                        progressColor: Colors.yellow,
                        backgroundColor: Color(0xFF006600),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  void baglantifonksiyoniki() async {
    try {
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(Sens1);
      print('Connecting Succesfull on Sensor1 Device');

      connection.input?.listen((Uint8List data1) {
        print('Sensor1: ${ascii.decode(data1)}');
        ref.read(veriyol1.notifier).update((state) => ascii.decode(data1));
        connection.output.add(data1); // Sending data
        if (ascii.decode(data1).contains('!')) {
          connection.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      }).onDone(() {
        print('Disconnected by remote request');
      });
    } catch (exception) {
      print('Error:404!');
    }
  }

  void baglantifonksiyon() async {
    try {
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(Sens0);
      print('Connecting Succesfull on Sensor0 Device');
      connection.input?.listen((Uint8List data0) {
        print('Sensor0: ${ascii.decode(data0)}');
        ref.read(veriyol0.notifier).update((state) => ascii.decode(data0));

        connection.output.add(data0); // Sending data

        if (ascii.decode(data0).contains('!')) {
          connection.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      }).onDone(() {
        print('Disconnected by remote request');
      });
    } catch (exception) {
      print('Error:404!');
    }
  }
}
