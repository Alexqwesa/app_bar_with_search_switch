# Changelog

## 1.6.0

* [AppBarWithSearchSwitch].titleTextStyle now also applied to default 
TextField (in search mode),
* update documentation.

## 1.5.4

* new parameter: [AppBarAnimationSlideLeft].background.

## 1.5.3

* update documentation.

## 1.5.2

* update documentation, minor changes,
* a new tear-off constructors: [AppBarAnimationSlideLeft].call, [AppBarAnimationSlideDown].call,
* required Dart Sdk >= 2.15.0 (for factory constructor tear-off).

## 1.5.1

* changes in AppBarAnimationSlideDown and AppBarAnimationSlideLeft: new parameters **switchInCurve** and
**switchOutCurve**

## 1.5.0

* added AppBarWithSearchSwitch.**animation** parameter, which can be used for any **custom animation**,
  also there are two ready to use animations: [AppBarAnimationSlideLeft], [AppBarAnimationSlideDown].

## 1.4.0

* fix for dark theme: use theme.appBarTheme colors by default and fallback to theme.canvasColor (which was used before)

## 1.3.9

* minor cleanup

## 1.3.8

* minor cleanup

## 1.3.7

* minor: tests were cleaned from deprecated code

## 1.3.6

* remove support for old flutter versions
* update README

## 1.3.5

* this is special release with **support for old flutter versions**, tested with 2.10.0,
* use this version if you want to use old flutter sdk

## 1.3.4

* update README

## 1.3.3

* by default: selectionHandleColor uses theme.splashColor

## 1.3.2

* textNotifier is now can change state of AppBarWithSearchSwitch
* update FAQ: How to make android back button close search?

## 1.3.1

* isActive renamed to isSearchMode (old name supported, but marked as deprecated),
* fix: return global default Notifiers, and controller,
* new parameter submitOnClearTwice

## 1.3.0

* added AppBarWithSearchFinder - a class for accessing AppBarWithSearchSwitch everywhere in Scaffold
* added helpers: AppBarOnEditListener and AppBarOnSubmitListener (just simple wrappers for ValueListenableBuilder)
* update documentation

## 1.2.4

* remove speech_to_text dependency (it will be reintroduced lately, in version 2)

## 1.2.3

* Added online example https://alexqwesa.github.io/app_bar_with_search_switch/
* update documentation

## 1.2.2

Added options:

* searchInputDecoration,
* searchActiveButtonColor,

## 1.2.1

* added example directory,
* added hasText Notifier,
* updated documentation

## 1.2.0

* added AppBarSearchButton

## 1.1.2+1

* update documentation

## 1.1.1+1

* update documentation

## 1.1.0+1

* added support for custom icons,
* property keepAppBarColors finished,
* added few other properties.

## 1.0.0+1

* Initial release.
