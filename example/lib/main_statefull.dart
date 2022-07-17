import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'AppBarWithSearch Stateful widget'),
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
  String searchText = '';
  final words = ("There is no justice in the laws of nature, no term for fairness in the equations of motion. "
          "The Universe is neither evil, nor good, it simply does not care. "
          "The stars don't care, or the Sun, or the sky. "
          "But they don't have to! WE care! There IS light in the world, and it is US! "
          "Why does any kind of cynicism appeal to people? Because it seems like a mark of maturity, of sophistication, like you’ve seen everything and know better. "
          "Or because putting something down feels like pushing yourself up. "
          "There is light in the world, and it is us! "
          "World domination is such an ugly phrase. I prefer to call it world optimisation. ")
      .split(' ');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          setState(() => searchText = text);
        },
        // keepAppBarColors: false,
        appBarBuilder: (context) => AppBar(
          title: Text(widget.title),
          actions: const [
            AppBarSearchButton(),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              for (var i = 0; i < words.length; i++)
                if (words[i].contains(searchText))
                  SizedBox(
                    height: 110,
                    width: 110,
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                words[i],
                                style: Theme.of(context).textTheme.headline5,
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
      ),
    );
  }
}
