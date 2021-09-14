import 'package:app/passed_painter.dart';
import 'package:app/second_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '沙漏时钟',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final secondLong = 1000;
  final minuteLong = 1000 * 60;
  final hourLong = 1000 * 60 * 60;
  final halfDayLong = 1000 * 60 * 60 * 12;
  final colorGroups = [
    // apple watch
    [
      Color(0xff000000),
      Color(0xfffa1554),
      Color(0xffb4ff00),
      Color(0xff00f7ee),
    ],
    [
      Color(0xff0359ae),
      Color(0xff14b09b),
      Color(0xffebe5d9),
      Color(0xffcc8a56)
    ],
    [
      Color(0xff181b46),
      Color(0xff7a2d59),
      Color(0xfff26322),
      Color(0xfffec804)
    ],
    [
      Color(0xff58d269),
      Color(0xff8772f2),
      Color(0xfff84c78),
      Color(0xfff86e30),
    ],
    // 紫色
    [
      Color(0xff442e91),
      Color(0xff2a8dba),
      Color(0xfff3ad50),
      Color(0xfff05538),
    ],
    [
      Colors.amber,
      Colors.cyan,
      Colors.deepOrange,
      Colors.indigo,
    ],
  ];
  int colorIndex = 0;
  // final colors = [
  //   Color(0xff0359ae),
  //   Color(0xff14b09b),
  //   Color(0xffebe5d9),
  //   Color(0xffcc8a56)
  // ];
  // final colors = [
  //   Color(0xff181b46),
  //   Color(0xff7a2d59),
  //   Color(0xfff26322),
  //   Color(0xfffec804)
  // ];
  // final colors = [
  //   Color(0xff58d269),
  //   Color(0xff8772f2),
  //   Color(0xfff84c78),
  //   Color(0xfff86e30),
  // ];

  @override
  Widget build(BuildContext context) {
    var colors = colorGroups[colorIndex];
    final size = MediaQuery.of(context).size;
    double radio;
    if (size.aspectRatio < 0.6) {
      radio = 40 / 36;
    } else {
      radio = 24 / 60;
    }
    return Scaffold(
      body: StreamBuilder<DateTime>(
        initialData: DateTime.now(),
        stream: Stream.periodic(
          Duration(milliseconds: 1),
          (i) {
            return DateTime.now();
          },
        ),
        builder: (ctx, v) {
          DateTime current = v.data!;
          var startOfDay =
              DateTime(current.year, current.month, current.day, 0, 0, 0, 0, 0);

          var ms = current.millisecondsSinceEpoch -
              startOfDay.millisecondsSinceEpoch;
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: colors[0],
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: size.width * radio,
                child: Container(
                  color: colors[1],
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                child: CustomPaint(
                  painter: PassedPainter(
                    length: ms,
                    color: colors[2],
                  ),
                  foregroundPainter: SecondPainter(
                    length: ms,
                    color: colors[3],
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      colorIndex = (colorIndex + 1) % colorGroups.length;
                    });
                  },
                  child: Container(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
