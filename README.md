# AppBar with search switch

An AppBar that can switch into search field.

The [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)
is replacement class for [AppBar](https://api.flutter.dev/flutter/material/AppBar-class.html), essentially, it returns
two different app bars based on whether search is active.

This is complete rewrite of [flutter_search_bar](https://pub.dev/packages/flutter_search_bar) with support:

- ***support Stateless widgets!***,
- work with [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) inside, which can be
  used directly and it can easily work with any providers,
- full customization,
- it work in place(no Navigation shenanigans),
- don't need additional variables somewhere.

## Quick overview:

Use [appBarBuilder](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/appBarBuilder.html)
property to build default AppBar with a search button which will
call [startSearch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/startSearch.html).

Use one of these callbacks to get text from [TextField](https://api.flutter.dev/flutter/material/TextField-class.html):

- [onChanged](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/onChanged.html),
- [onSubmitted](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/onSubmitted.html),
- or listen to [textEditingController](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/textEditingController.html).

Also, there are callbacks for:

- [onCleared](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/onCleared.html),
- [onClosed](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/onClosed.html).

This widget support almost ***all*** properties of [AppBar](https://api.flutter.dev/flutter/material/AppBar-class.html),
but:

- [leading](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/leading.html)
  and [title](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/title.html)
  properties are now expect - `Widget Function(context)?`:

    - this is made in order to access `AppBarWithSearchSwitch.of(context)` methods in them,
    - don't change them unless it necessary and use templates if you need to change these properties.

- [preferredSize](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/preferredSize.html) here is a method, you should set it
  via [toolbarWidth](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/toolbarWidth.html)
  and [toolbarHeight](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/toolbarHeight.html).

Here is a list of all other new properties(without mentioned above) with their default values:

- this.[tooltipForClearButton](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/tooltipForClearButton.html) = 'Clear',
- this.[tooltipForCloseButton](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/tooltipForCloseButton.html) = 'Close search',
- this.[closeSearchIcon](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/closeSearchIcon.html) = Icons.close,
- this.[clearSearchIcon](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/clearSearchIcon.html) = Icons.backspace,
- this.[fieldHintText](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/fieldHintText.html) = 'Search',
- this.[keepAppBarColors](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/keepAppBarColors.html) = true,
- this.[closeOnSubmit](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/closeOnSubmit.html) = true,
- this.[clearOnSubmit](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/clearOnSubmit.html) = false,
- this.[clearOnClose](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/clearOnClose.html) = false,
- this.[showClearButton](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/showClearButton.html) = true,
- this.[closeOnClearTwice](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/closeOnClearTwice.html) = true,
- this.[keyboardType](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/keyboardType.html) = TextInputType.text,
- this.[toolbarWidth](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/toolbarWidth.html) = double.infinity,
- // And notifiers:
- this.[customIsActiveNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsActiveNotifier.html), // have default static value
- this.[customTextEditingController](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextEditingController.html), // have default static value

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

## FAQ:

How to change search state
of [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)
from somewhere far away?

- Use [customIsActiveNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsActiveNotifier.html),
  1. Initialise variable of type [ValueNotifier<bool>](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) somewhere up in the widget tree,
  2. Set [customIsActiveNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsActiveNotifier.html) property of AppBarWithSearchSwitch with this variable,
  3. Set value of this [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) to true to show Search AppBar, (Note: currently, if you stop search via this variable(by setting it false), `clearOnClose` will not work, and callBack `onClose` will not be called).
