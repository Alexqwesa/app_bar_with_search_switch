import 'package:app_bar_with_search_switch/src/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';

const abc = 'abcdefghijklmnopqrstuvwxyz';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppBarWithSearch demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'AppBarWithSearch widget'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String searchText = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          setState(() => searchText = text);
        },
        appBarBuilder: (context) => AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(AppBarWithSearchSwitch.of(context)?.text != ''
                  ? Icons.search_off
                  : Icons.search),
              tooltip:
                  'Last input text: ${AppBarWithSearchSwitch.of(context)?.text}',
              color: AppBarWithSearchSwitch.of(context)?.text != ''
                  ? Colors.tealAccent
                  : null,
              onPressed: () {
                AppBarWithSearchSwitch.of(context)?.triggerSearch();
                print(AppBarWithSearchSwitch.of(context)?.isActive.value);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Wrap(
          children: [
            for (var i = 0; i <= _counter; i++)
              if (abc
                  .substring(i % 15, 1 + i % 15 + (i + 9) % 9)
                  .contains(searchText))
                SizedBox(
                  height: 110,
                  width: 110,
                  child: Card(
                    child: Column(
                      children: [
                        // Text(
                        //   '$i',
                        // ),
                        Expanded(
                          child: Center(
                            child: Text(
                              abc.substring(i % 15, 1 + i % 15 + (i + 9) % 9),
                              style: Theme.of(context).textTheme.headline4,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
