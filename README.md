# AppBar with search switch

An AppBar that can switch into search field.

The [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)
is replacement class for [AppBar](https://api.flutter.dev/flutter/material/AppBar-class.html), essentially, it returns
two different app bars based on whether search is active.

This is complete rewrite of [flutter_search_bar](https://pub.dev/packages/flutter_search_bar) with support:

- ***support Stateless widgets!***,
- work with `ValueNotifier` inside, can easily work with any providers,
- full customization,
- it work in place(no Navigation shenanigans),
- don't need additional variables somewhere.

### Quick overview:

Use [appBarBuilder] property to build default AppBar with a search button which will call [startSearch].

Use one of these callbacks to get text from [TextField]:

- [onChanged],
- [onSubmitted],
- or listen to [textEditingController].

Also, there are callbacks for:

- [onCleared],
- [onClosed].

This widget support almost ***all*** properties of [AppBar], but:

- [leading](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/leading.html)
-
and [title](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/title.html)
properties are now expect - `Widget Function(context)?`:
    - this is made in order to access `AppBarWithSearchSwitch.of(context)` methods,
    - don't change them unless it necessary and use templates if you need to change them.
- [preferredSize] here is a method, you should set it via [toolbarWidth] and [toolbarHeight].

Here is a list of all other new properties(without mentioned above):

- this.[tooltipForClearButton] = 'Clear',
- this.[tooltipForCloseButton] = 'Close search',
- this.[closeSearchButton] = Icons.close,
- this.[clearSearchButton] = Icons.backspace,
- this.[fieldHintText] = 'Search',
- this.[keepAppBarColors] = true,
- this.[closeOnSubmit] = true,
- this.[clearOnSubmit] = false,
- this.[clearOnClose] = false,
- this.[showClearButton] = true,
- this.[closeOnClearTwice] = true,
- this.[keyboardType] = TextInputType.text,
- this.[toolbarWidth] = double.infinity,
- // And notifiers:
- this.[customIsActiveNotifier], // have default static value
- this.[customTextEditingController], // have default static value

## Example:

```dart
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final searchText = ValueNotifier<String>('');
  final _counter = ValueNotifier<int>(0);

  void _incrementCounter() {
    _counter.value++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 
      // *** The Widget AppBarWithSearchSwitch 
      // 
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          searchText.value = text;
        },
        // onSubmitted: (text) {
        //   searchText.value = text;
        // },
        appBarBuilder: (context) {
          final appBar = AppBarWithSearchSwitch.of(context)!;

          return AppBar(
            title: Text(title),
            actions: [
              IconButton(
                icon: Icon(appBar.text != '' ? Icons.search_off : Icons.search),
                tooltip: 'Last input: ${appBar.text}',
                color: appBar.text != '' ? Colors.tealAccent : null,
                onPressed: () {
                  appBar.startSearch();
                  dev.log(appBar.isActive.value.toString() ?? '');
                },
              ),
            ],
          );
        },
      ),
      // 
      // > Just some random code to react to input from AppBarWithSearchSwitch.
      // 
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([searchText, _counter]),
          builder: (BuildContext context, _) {
            return Wrap(
              children: [
                for (var i = 0; i <= _counter.value; i++)
                  if (abc
                      .substring(i % 15, 1 + i % 15 + (i + 9) % 9)
                      .contains(searchText.value))
                    SizedBox(
                      height: 110,
                      width: 110,
                      child: Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  abc.substring(
                                      i % 15, 1 + i % 15 + (i + 9) % 9),
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
            );
          },
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

```

## Screenshot

<img align="center" src="https://raw.githubusercontent.com/alexqwesa/app_bar_with_search_switch/master/screenshot.gif">

## TODO:

Add speech to text support.