import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: LinePlot(plotData: PlotData(result: [15.0, 25.0, 50, 45, 32, 40], maxY: 50.0, minY: 0.0)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PlotData {
  List<double> result;
  double maxY;
  double minY;
  PlotData({
    required this.result,
    required this.maxY,
    required this.minY,
  });
}

class LinePlot extends StatefulWidget {
  final PlotData plotData;
  const LinePlot({
    required this.plotData,
    Key? key,
  }) : super(key: key);

  @override
  _LinePlotState createState() => _LinePlotState();
}

class _LinePlotState extends State<LinePlot> {
  late double minX;
  late double maxX;
  @override
  void initState() {
    super.initState();
    minX = 0;
    maxX = widget.plotData.result.length.toDouble();
    _controller.addListener(_scrollListener);
  }

  ScrollController _controller = ScrollController();
  _scrollListener() {
    print(_controller.offset);
    if (_controller.offset >= _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
      setState(() {
        print("reach the bottom");
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent && !_controller.position.outOfRange) {
      setState(() {
        print("reach the top");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      child: Container(
        width: (barChartWidth + 15) * 24,
        height: 500,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceEvenly,
            maxY: 20,
            minY: 0,
            // groupsSpace: 12,
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (value) => value % 5 == 0,
              getDrawingHorizontalLine: (value) {
                if (value == 0) {
                  return FlLine(
                    color: Colors.blue, //Color(0xff363753),
                    strokeWidth: 3,
                  );
                }
                return FlLine(
                  color: Color(0xff2a2747),
                  strokeWidth: 0.8,
                );
              },
            ),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: getBarchartData(),
          ),
          swapAnimationDuration: animDuration,
        ),
      ),
    );
  }

  double barChartWidth = 15;
  double percent = 0.3;
  Duration animDuration = const Duration(milliseconds: 250);
  getBarchartData() {
    return [
      BarChartGroupData(
        x: 0,
        showingTooltipIndicators: [2, 8],
        barRods: [
          BarChartRodData(
            y: 8,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 2, const Color(0xffff9900)),
              BarChartRodStackItem(2, 8, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            y: 14,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 6, const Color(0xffff9900)),
              BarChartRodStackItem(6, 14, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            y: 13,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 7, const Color(0xffff9900)),
              BarChartRodStackItem(7, 13, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            y: 13.5,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 6, const Color(0xffff9900)),
              BarChartRodStackItem(6, 13.5, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            y: 18,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 9, const Color(0xffff9900)),
              BarChartRodStackItem(9, 18, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            y: 17,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 7, const Color(0xffff9900)),
              BarChartRodStackItem(7, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 7,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 8,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 9,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 10,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 11,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 12,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 13,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 14,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 15,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 16,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 17,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 18,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 19,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 20,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 21,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 22,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
      BarChartGroupData(
        x: 23,
        barRods: [
          BarChartRodData(
            y: 16,
            width: barChartWidth,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            rodStackItems: [
              BarChartRodStackItem(0, 12, const Color(0xffff9900)),
              BarChartRodStackItem(12, 17, const Color(0xfffe5712)),
            ],
          ),
        ],
      ),
    ];
  }
}
