# AppBar with search switch

<img align="right" src="https://raw.githubusercontent.com/alexqwesa/app_bar_with_search_switch/master/screenshot.gif" width="262" height="540">

## Content

- [Intro](#intro)
- [Features](#features)
- [Quick overview](#quick-overview)
- [Examples](#examples)
- [Screenshots](#screenshots)
- [TODO](#todo)
- [FAQ](#faq)
- [Known issues](#known-issues)

## Intro

An AppBar that can switch into search field.

The [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)
is a replacement class for [AppBar](https://api.flutter.dev/flutter/material/AppBar-class.html), essentially, it returns
two different app bars based on whether search is active.

Note: **version 1.5+ is lightweight version** of this package, **version 2.0+ uses [SpeechToText](https://pub.dev/packages/speech_to_text)** 
package for speech recognition.

This is complete rewrite of [flutter_search_bar](https://pub.dev/packages/flutter_search_bar) with support of these features:

## Features

- **support [Stateless](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) widgets!**,
- work with [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) inside, which can be
  used directly or can easily work with any providers,
- full customization,
- it works in place(no Navigation shenanigans),
- don't need additional variables somewhere,
- support custom animation (and have nice prebuilt animations: [AppBarAnimationSlideDown](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarAnimationSlideDown-class.html) and [AppBarAnimationSlideLeft](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarAnimationSlideLeft-class.html) ) (**new in 2.0.0-dev.11+**),
- Also, there are a few **helpers(optional)**:
  - [AppBarSearchButton](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarSearchButton-class.html),
  - [AppBarOnEditListener](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarOnEditListener-class.html),
  - [AppBarOnSubmitListener](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarOnSubmitListener-class.html),
  - [AppBarWithSearchFinder](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchFinder-class.html),
  - [AppBarSpeechButton](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarSpeechButton-class.html) ( **in version 2.0+ only** )


## Quick overview

Use [appBarBuilder](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/appBarBuilder.html)
parameter to build default AppBar with: 
- a search button which will call [startSearch](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/startSearch.html)
- or with standard search button [AppBarSearchButton](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarSearchButton-class.html).

The [appBarBuilder](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/appBarBuilder.html) 
**is the only required parameter**, all other parameters are optional! 

Use one of these callbacks to get text from [TextField](https://api.flutter.dev/flutter/material/TextField-class.html):

- [onChanged](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/onChanged.html),
- [onSubmitted](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/onSubmitted.html),
- or listen to [textEditingController](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/textEditingController.html),
- or just [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html): [textNotifier](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/textNotifier.html) ...

Also, there are callbacks for:

- [onCleared](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/onCleared.html),
- [onClosed](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/onClosed.html).

This widget support almost ***all*** properties of [AppBar](https://api.flutter.dev/flutter/material/AppBar-class.html),
but:

- [leading](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/leading.html)
  and [title](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/title.html)
  properties are now expect - `Widget Function(context)?`:

    - this is made in order to access `AppBarWithSearchSwitch.of(context)` methods in them,
    - don't change them unless it necessary and use templates if you need to change these properties.

- [preferredSize](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/preferredSize.html) here is a method, you should set it
  via [toolbarWidth](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/toolbarWidth.html)
  and [toolbarHeight](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/toolbarHeight.html).

Here is a list of all other new properties(without mentioned above) with their default values:

- this.[tooltipForClearButton](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/tooltipForClearButton.html) = 'Clear',
- this.[tooltipForCloseButton](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/tooltipForCloseButton.html) = 'Close search',
- this.[closeSearchIcon](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/closeSearchIcon.html) = Icons.close,
- this.[clearSearchIcon](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/clearSearchIcon.html) = Icons.backspace,
- this.[fieldHintText](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/fieldHintText.html) = 'Search',
- this.[keepAppBarColors](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/keepAppBarColors.html) = true,
- this.[closeOnSubmit](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/closeOnSubmit.html) = true,
- this.[clearOnSubmit](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/clearOnSubmit.html) = false,
- this.[clearOnClose](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/clearOnClose.html) = false,
- this.[showClearButton](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/showClearButton.html) = true,
- this.[closeOnClearTwice](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/closeOnClearTwice.html) = true,
- this.[submitOnClearTwice](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/submitOnClearTwice.html) = true,
- this.[keyboardType](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/keyboardType.html) = TextInputType.text,
- this.[toolbarWidth](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/toolbarWidth.html) = double.infinity,
- this.[searchInputDecoration](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/searchInputDecoration.html),
- this.[animation](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/animation.html) - (**new in 1.5+**),
- this.[animationOfSpeechBar](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.11/app_bar_with_search_switch/AppBarWithSearchSwitch/animationOfSpeechBar.html) - (**new in 2.0.0-dev.11+**),
- // And optional [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) s 
 (can be used to control state of [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)): 
- this.[customIsSearchModeNotifier](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsSearchModeNotifier.html),
- this.[customTextNotifier](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextNotifier.html),
- // And optional [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) s (read only):
- this.[customHasText](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customHasText.html), 
- this.[customSubmitNotifier](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customSubmitNotifier.html),
- // And optional [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html):
- this.[customTextEditingController](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextEditingController.html), 
- // And optional [SpeechToText](https://pub.dev/packages/speech_to_text), version 2+ only,
- this.[customSpeechToText](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customSpeechToText.html),
- this.[speechSubBar](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/speechSubBar.html),
- this.[speechSubBarHeight](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/speechSubBarHeight.html) = kToolbarHeight * 1.2,

For using [SpeechToText](https://pub.dev/packages/speech_to_text) 
it is required to setup build configurations of your project:
- [setup permissions](https://pub.dev/packages/speech_to_text#permissions),
- use newer sdk (compileSdkVersion 21+)
- and use [SpeechToText](https://pub.dev/packages/speech_to_text) documentation for fine tuning...

## Examples

**Online example** here: [https://alexqwesa.github.io/app_bar_with_search_switch/](https://alexqwesa.github.io/app_bar_with_search_switch/).

Full example of **Stateful** widget is here: [https://pub.dev/packages/app_bar_with_search_switch/example](https://pub.dev/packages/app_bar_with_search_switch/example).

Full example of **Stateless** widget is [here: (github)](https://github.com/Alexqwesa/app_bar_with_search_switch/blob/master/example/lib/main_statefull.dart).

Full example of Stateless widget with **10000 elements** searched in place and with search button outside of app bar is 
[here: (github)](https://github.com/Alexqwesa/app_bar_with_search_switch/blob/master/example/lib/main_in_place_effective.dart).

Full example of Stateless widget there **android back button will close search** is [here: (github)](https://github.com/Alexqwesa/app_bar_with_search_switch/blob/master/example/lib/main_android_back_button_clear_search.dart).

And the fragment of example code is here:
```dart
  //...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      // *** The Widget AppBarWithSearchSwitch
      //
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          // update you provider here
          // searchText.value = text;
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
      // search in body by any way you want, example:
      body: AppBarOnEditListener(builder: (context) { return /* your code here */ ;} ),
    );
  }
```

## Screenshots

<img align="center" src="https://raw.githubusercontent.com/alexqwesa/app_bar_with_search_switch/master/screenshot.gif">


## TODO

- [x] Add speech to text support - done in version 2.0+,
- [ ] Add riverpod example,
- [x] Add option for placement of SearchButton and MicrophoneButton outside of AppBar (optional GlobalKey?) - see FAQ
- [x] Animation for Search app bar activation - done in versions 1.5+
- [ ] use iconTheme for icons?
- [ ] don't use shared default [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) and [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) ?
- [ ] support CupertinoPageScaffold

## FAQ

**How to activate search field (`isSearchMode=true`)
of [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)
from somewhere far away?**

- If it is inside the same [Scaffold](https://api.flutter.dev/flutter/material/Scaffold-class.html) or its children, then:
  1. use [AppBarWithSearchFinder](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchFinder-class.html),
  2. call `AppBarWithSearchFinder.of(context)?.triggerSearch()` inside.

- If it is outside of [Scaffold](https://api.flutter.dev/flutter/material/Scaffold-class.html),
use [customIsSearchModeNotifier](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsSearchModeNotifier.html),
  1. Initialise variable of type [ValueNotifier<bool>](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) somewhere up in the widget tree,
  2. Set [customIsSearchModeNotifier](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsSearchModeNotifier.html) property of AppBarWithSearchSwitch with this variable,
  3. Set value of this [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) to true to show Search AppBar, 
  4. (Note: currently, if you stop search via this variable(by setting it false), `clearOnClose` will not work, and callBack `onClose` will not be called), so use `GlobalKey` if you need them.

**How to make android back button close search?** (instead of going to previous screen or exit app)

1. Initialise variable searchText and isSearchMode of type [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) somewhere up in the widget tree,
2. Assign these variables to [customIsSearchModeNotifier](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsSearchModeNotifier.html), 
 [customTextNotifier](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextNotifier.html),
3. Wrap [WillPopScope](https://api.flutter.dev/flutter/material/WillPopScope-class.html) widget over [Scaffold](https://api.flutter.dev/flutter/material/Scaffold-class.html), 
 and define parameter `onWillPop` as in example below:

```dart
... // inside a widget
  final isSearchMode = ValueNotifier<bool>(false);
  final searchText = ValueNotifier<String>(''); 

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async { // android back button handler
        if (searchText.value != '') {
          isSearchMode.value = false;
          searchText.value = ''; 
          return false;
        }
        return true;
      },
      child: Scaffold(
        //
        // *** The Widget AppBarWithSearchSwitch
        //
        appBar: AppBarWithSearchSwitch(
          customIsSearchModeNotifier: isSearchMode,
          customTextNotifier: searchText,
          appBarBuilder: (context) {
            return AppBar(
... // you code here
```

**How to add autocompletion to search field?**

* Use [Autocomplete](https://api.flutter.dev/flutter/material/Autocomplete-class.html) widget in [title](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/title.html) 
 parameter:

```dart
... // inside a widget
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBarWithSearchSwitch(
          title:  (context) {
                return Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    // your code here
                  },
                ); 
          }
          appBarBuilder: (context) {
            return AppBar(
... // you code here
```

**Speech to text didn't work in emulator, how to fix?**

- check: are you added [permissions](https://pub.dev/packages/speech_to_text#permissions) to AndroidManifest.xml,
- check: are you granted permission to you app in Android(see about app page in android settings),
- check: are emulator settings allow access to microphone,
- check: is [Google](https://play.google.com/store/apps/details?id=com.google.android.googlequicksearchbox) installed,
- check: is Google work,
- check: is you microphone work on host side,
- see [https://pub.dev/packages/speech_to_text#troubleshooting](https://pub.dev/packages/speech_to_text#troubleshooting) 
 for troubleshooting...

## Known issues

- `keepAppBarColors = true` didn't change color of 'Text Selection Handles' (selection bubbles), this is because of 
upstream issue https://github.com/flutter/flutter/issues/74890 with textSelectionTheme: `selectionHandleColor` 
- If for some reason you use **more than one** [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)
 **on the same page** (how? and why?) provide them with their own: [customIsSearchModeNotifier](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsSearchModeNotifier.html), 
[customTextNotifier](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextNotifier.html), 
[customTextEditingController](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextEditingController.html), 
[customHasText](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.10/app_bar_with_search_switch/AppBarWithSearchSwitch/customHasText.html)... 
 