# AppBar with search switch

An AppBar that can switch into search field.

The [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)
is a replacement class for [AppBar](https://api.flutter.dev/flutter/material/AppBar-class.html), essentially, it returns
two different app bars based on whether search is active.

<img align="right" src="https://raw.githubusercontent.com/alexqwesa/app_bar_with_search_switch/master/screenshot.gif" width="262" height="540">

This is complete rewrite of [flutter_search_bar](https://pub.dev/packages/flutter_search_bar) with support:

- ***support [Stateless](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) widgets!***,
- work with [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) inside, which can be
  used directly or can easily work with any providers,
- full customization,
- it work in place(no Navigation shenanigans),
- don't need additional variables somewhere.

## Content

- [Quick overview](#quick-overview)
- [Examples](#examples)
- [Screenshots](#screenshots)
- [TODO](#todo)
- [FAQ](#faq)
- [Known issues](#known-issues)

## Quick overview

Use [appBarBuilder](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/appBarBuilder.html)
property to build default AppBar with: 
- a search button which will call [startSearch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/startSearch.html)
- or with standard search button [AppBarSearchButton](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarSearchButton-class.html).

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
- this.[searchInputDecoration](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/searchInputDecoration.html),
- // And [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) s:
- this.[customIsActiveNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsActiveNotifier.html), // have default static value
- this.[customHasText](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customHasText.html), // has default static value
- // [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html):
- this.[customTextEditingController](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextEditingController.html), // have default static value

## Examples

Full example of **Statefull** widget is here: [https://pub.dev/packages/app_bar_with_search_switch/example](https://pub.dev/packages/app_bar_with_search_switch/example).

Full example of **Stateless** widget is [here: (github)](https://github.com/Alexqwesa/app_bar_with_search_switch/blob/master/example/lib/main_statefull.dart).

**Online example** here: [https://alexqwesa.github.io/app_bar_with_search_switch/](https://alexqwesa.github.io/app_bar_with_search_switch/).

And the fragment of example code is here: 
```dart
final searchText = ValueNotifier<String>(''); // somewhere up in a widget tree
//...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 
      // *** The Widget AppBarWithSearchSwitch 
      // 
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          searchText.value = text;
        }, // onSubmitted: (text) => searchText.value = text,
        appBarBuilder: (context) {
          return AppBar(
            title: Text('Example '),
            actions: [
              AppBarSearchButton(),
              // or 
              // IconButton(onPressed: AppBarWithSearchSwitch.of(context)?startSearch, icon: Icon(Icons.search)),
            ],
          );
        },
      ),
      body: Container(),
    );
  }
```

## Screenshots

<img align="center" src="https://raw.githubusercontent.com/alexqwesa/app_bar_with_search_switch/master/screenshot.gif">


## TODO

- Add speech to text support,
- Add effective riverpod example,
- Add option for placement of SearchButton and MicrophoneButton outside of AppBar (optional GlobalKey?)

## FAQ

How to active search field (`isActive`=true)
of [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)
from somewhere far away?

- Use [customIsActiveNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsActiveNotifier.html),
  1. Initialise variable of type [ValueNotifier<bool>](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) somewhere up in the widget tree,
  2. Set [customIsActiveNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsActiveNotifier.html) property of AppBarWithSearchSwitch with this variable,
  3. Set value of this [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) to true to show Search AppBar, (Note: currently, if you stop search via this variable(by setting it false), `clearOnClose` will not work, and callBack `onClose` will not be called).

## Known issues

- `keepAppBarColors = true` didn't change color of 'Text Selection Handles' (selection bubbles), this is because of 
upstream issue https://github.com/flutter/flutter/issues/74890 with textSelectionTheme: `selectionHandleColor` 