// Copyright (c) 2022, Alexqwesa.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../app_bar_with_search_switch.dart';

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
        // useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AppBarWithSearch main'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final words = ("There is no justice in the laws of nature, no term for fairness in the equations of motion. "
          "The Universe is neither evil, nor good, it simply does not care. "
          "The stars don't care, or the Sun, or the sky. "
          "But they don't have to! WE care! There IS light in the world, and it is US! "
          "Why does any kind of cynicism appeal to people? Because it seems like a mark of maturity, of sophistication, like you’ve seen everything and know better. "
          "Or because putting something down feels like pushing yourself up. "
          "There is light in the world, and it is us! "
          "World domination is such an ugly phrase. I prefer to call it world optimisation. ")
      .split(' ');

  final isSearchMode = ValueNotifier<bool>(false);
  final searchText = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    final wordsLength = words.length;

    return WillPopScope(
      onWillPop: () async {
        if (searchText.value != '') {
          isSearchMode.value = false;
          searchText.value = '';
          return false;
        }
        return true;
      },
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.blue, selectionColor: Colors.red),
        ),
        child: Scaffold(
          //
          // *** The Widget AppBarWithSearchSwitch
          //
          appBar: AppBarWithSearchSwitch(
            customIsSearchModeNotifier: isSearchMode,
            customTextNotifier: searchText,
            // animation: (child) => AppBarAnimationSlideDown(child: child, milliseconds: 400),
            // animation: (child) => AppBarAnimationSlideLeft(child: child, milliseconds: 400),
            animation: AppBarAnimationSlideLeft.call,
            // animation: (child) => AppBarAnimationSlideLeft(
            // milliseconds: 400,
            // withFade: false,
            // percents: 0.25,
            // percents: .80,
            // child: child,
            // ),

            theme: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                selectionHandleColor: Theme.of(context).splashColor,
                selectionColor:
                    Theme.of(context).colorScheme.background.withOpacity(0.5),
                cursorColor: Theme.of(context).colorScheme.background,
              ),
              textTheme: Theme.of(context).textTheme.copyWith(
                    // hint color
                    headlineSmall:
                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.color
                                  ?.withOpacity(0.6),
                            ),
                  ),
            ),
            appBarBuilder: (context) {
              return AppBar(
                title: Text(title),
                actions: const [
                  AppBarSearchButton(
                      // changeOnlyOnSubmit: true,
                      ),
                  // or
                  // IconButton(onPressed: AppBarWithSearchSwitch.of(context)?startSearch, icon: Icon(Icons.search)),
                ],
              );
            },
          ),
          //
          // > Just some random code to react to input from AppBarWithSearchSwitch.
          //
          body: Column(
            children: [
              AppBarOnEditListener(
                builder: (BuildContext context, searchText, child) {
                  final totalFound = words
                      .where((element) => element.contains(searchText))
                      .length;

                  return totalFound > 0 && searchText != ''
                      ? Text(
                          totalFound.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        )
                      : Container();
                },
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: words.length * 100,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width ~/ 120,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (BuildContext context, int i) {
                    return AppBarOnEditListener(
                      child: SizedBox(
                        height: 110,
                        width: 110,
                        child: GestureDetector(
                          onLongPress: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage(
                                        title: words[i % wordsLength],
                                      )),
                            );
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      words[i % wordsLength],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      builder: (BuildContext context, searchText, child) {
                        return Visibility(
                          visible: words[i % wordsLength].contains(searchText),
                          child: child ?? Container(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          //
          // > Activate search from random place
          //
          // floatingActionButton: AppBarWithSearchFinder(
          //   builder: (context) => FloatingActionButton(
          //     onPressed: () => AppBarWithSearchFinder.of(context)?.triggerSearch(),
          //     tooltip: 'Activate search from random place',
          //     child: const Icon(Icons.search),
          //   ),
          // ),
          floatingActionButton: const AppBarSearchButton(),
        ),
      ),
    );
  }
}
