import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppBarWithSearch demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AppBarWithSearch widget stateless'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final searchText = ValueNotifier<String>('');
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
    final wordsLength = words.length;

    return Scaffold(
      //
      // *** The Widget AppBarWithSearchSwitch
      //
      appBar: AppBarWithSearchSwitch(
        animation: (child) => AppBarAnimationSlideDown(child: child),
        onChanged: (text) {
          searchText.value = text;
        },
        // onSubmitted: (text) {
        //   searchText.value = text;
        // },
        appBarBuilder: (context) {
          return AppBar(
            title: Text(title),
            actions: const [
              AppBarSearchButton(),
              // or
              // IconButton(onPressed: AppBarWithSearchSwitch.of(context)?startSearch, icon: Icon(Icons.search)),
            ],
          );
        },
      ),
      //
      // > Just some random code to react to input from AppBarWithSearchSwitch.
      //
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              for (var i = 0; i < words.length * 100; i++)
                AppBarOnEditListener(
                  child: SizedBox(
                    height: 110,
                    width: 110,
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                words[i % wordsLength],
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  builder: (BuildContext context, searchText, child) {
                    return Visibility(
                      visible: words[i % wordsLength].contains(searchText),
                      child: child ?? Container(),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
