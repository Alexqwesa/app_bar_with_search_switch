# Changelog

## 2.0.0-dev.12

* update documentation,
* new parameter for [AppBarAnimationSlideLeft].boxDecorationBehind,
* a new tear-off constructors: [AppBarAnimationSlideLeft].call, [AppBarAnimationSlideDown].call,
* required Dart Sdk >= 2.15.0 (for factory constructor tear-off).

## 2.0.0-dev.11

* added AppBarWithSearchSwitch.**animationOfSpeechBar** (the same as **animation** but for transition
  to search mode with speech to text support)

## 2.0.0-dev.10

* changes in AppBarAnimationSlideDown and AppBarAnimationSlideLeft: new parameters **switchInCurve** and
  **switchOutCurve**

## 2.0.0-dev.8, 2.0.0-dev.9

* minor fixes, documentation links

## 2.0.0-dev.7

* added AppBarWithSearchSwitch.**animation** parameter, which can be used for any **custom animation**,
  also there are two ready to use animations: [AppBarAnimationSlideLeft], [AppBarAnimationSlideDown].

## 2.0.0-dev.6

* fix for dark theme: use theme.appBarTheme colors by default and fallback to theme.canvasColor (which was used before)

## 2.0.0-dev.5

* minor cleanup

## 2.0.0-dev.4

* update dependency v2.0.0-dev.4

## 2.0.0-dev.3

* minor: tests and examples cleaned from deprecated code

## 2.0.0-dev.2

* minor: warnings cleaned

## 2.0.0-dev.1

* AppBarSpeechButton - Speech to text recognition for AppBarWithSearchSwitch,
* new parameters: speechSubBar, speechSubBarHeight and final variable isListeningToSpeech,
* added innerStartListening function (for speechSubBar)

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
