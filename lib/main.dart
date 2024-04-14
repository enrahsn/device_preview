import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
// flutter pub add device_preview
void main() {
  runApp(DevicePreview(builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Flutter device_preview',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter device_preview Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    double scrHight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.amber,
              width: scrWidth,
              height: scrHight,
              child: Center(
                // child: LayoutBuilder(builder: (_, constraints) {
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    var deviceType = getDeviceType(mediaQueryData);
                    print(deviceType);
                    // if (constraints.maxHeight > 200) {
                    // Show a text when the height is bigger than 200
                    // return Text('Show only in landscape mode');
                    double localHeight = constraints.maxHeight;
                    double localWidth = constraints.maxWidth;
                    print("localHeight=$localHeight");
                    print("localWidth=$localWidth");
                    print('height=$scrHight');
                    print('width=$scrWidth');
                    return Container(
                      color: Colors.blue,
                      width: localWidth / 3,
                      height: localHeight / 3,
                    );
                    // } else {
                    // Hide everything else for portrait     mode
                    // }
                    // height: scrHight * .6;
                    // width:  scrWidth * .8;
                  },
                ),
              ),
            ),
            /*
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            */
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // }
  // DeviceType  getDeviceType(BuildContext context) => ResponsiveScreenUtil().getDeviceType(MediaQuery.of(context).size);
  DeviceType getDeviceType(MediaQueryData mediaQueryData) {
    Orientation orientation = mediaQueryData.orientation;
    double width = 0;
    if (orientation == Orientation.landscape) {
      width = mediaQueryData.size.height;
    } else {
      width = mediaQueryData.size.width;
    }
    if (width >= 950) {
      return DeviceType.deskTop;
    } else if (width >= 600) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
      // }
    }
  }
}

//   DeviceType getDeviceType() => MediaQuery.of(context).size.shortestSide < 600
//       ? DeviceType.phone
//       : DeviceType;
// }
enum DeviceType {
  mobile,
  tablet,
  deskTop,
}
