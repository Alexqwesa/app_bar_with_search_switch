/// # AppBar with search switch
///
/// An AppBar with switch into search field.
///
/// A simple usage example:
///
/// ```dart
///class MyHomePage extends StatelessWidget {
///  MyHomePage({Key? key, required this.title}) : super(key: key);
///
///  final String title;
///  final searchText = ValueNotifier<String>('');  // create notifier
///  final _counter = ValueNotifier<int>(0);
///
///  void _incrementCounter() {
///    _counter.value++;
///  }
///
///  @override
///  Widget build(BuildContext context) {
///    return Scaffold(
///      //
///      // > The Widget AppBarWithSearchSwitch
///      //
///      appBar: AppBarWithSearchSwitch(
///        onChanged: (text) {
///          searchText.value = text;
///        },
///        // onSubmitted: (text) {
///        //   searchText.value = text;
///        // },
///        appBarBuilder: (context) {
///          final appBar = AppBarWithSearchSwitch.of(context)!;
///
///          return AppBar(
///            title: Text(title),
///            actions: [
///              IconButton(
///                icon: Icon(appBar.text != '' ? Icons.search_off : Icons.search),
///                tooltip: 'Last input: ${appBar.text}',
///                color: appBar.text != '' ? Colors.tealAccent : null,
///                onPressed: () {
///                  appBar.startSearch();
///                  dev.log(appBar.isActive.value.toString());
///                },
///              ),
///            ],
///          );
///        },
///      ),
///      //
///      // > Just some random code to react to input from AppBarWithSearchSwitch.
///      //
///      body: Center(
///        child: AnimatedBuilder(
///          animation: Listenable.merge([searchText, _counter]),
///          builder: (BuildContext context, _) {
///            return Wrap(
///              children: [
///                for (var i = 0; i <= _counter.value; i++)
///                  if (abc
///                      .substring(i % 15, 1 + i % 15 + (i + 9) % 9)
///                      .contains(searchText.value))
///                    SizedBox(
///                      height: 110,
///                      width: 110,
///                      child: Card(
///                        child: Column(
///                          children: [
///                            Expanded(
///                              child: Center(
///                                child: Text(
///                                  abc.substring(
///                                      i % 15, 1 + i % 15 + (i + 9) % 9),
///                                  style: Theme.of(context).textTheme.headline4,
///                                  textAlign: TextAlign.center,
///                                ),
///                              ),
///                            ),
///                          ],
///                        ),
///                      ),
///                    ),
///              ],
///            );
///          },
///        ),
///      ),
///      floatingActionButton: FloatingActionButton(
///        onPressed: _incrementCounter,
///        tooltip: 'Increment',
///        child: const Icon(Icons.add),
///      ),
///    );
///  }
///}
/// ```
library app_bar_with_search_switch;

export 'package:app_bar_with_search_switch/src/app_bar_with_search_switch.dart';
