

# AppBar con conmutación a búsqueda

<img align="right" src="https://raw.githubusercontent.com/alexqwesa/app_bar_with_search_switch/master/screenshot.gif" width="262" height="540">

## Contenido

- [Introducción](#intro)
- [Características](#features)
- [Vista rápida](#quick-overview)
- [Ejemplos](#examples)
- [Capturas de pantalla](#screenshots)
- [TODO](#todo)
- [Preguntas frecuentes](#faq)
- [Problemas conocidos](#known-issues)

## Introducción

Un AppBar que puede cambiar a un campo de búsqueda.

La clase [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)
es un reemplazo para [AppBar](https://api.flutter.dev/flutter/material/AppBar-class.html); esencialmente, devuelve
dos barras de aplicación diferentes según si la búsqueda está activa o no.

Nota: **la versión 1.5+ es una versión ligera** de este paquete, **la versión 2.0+ utiliza el paquete [SpeechToText](https://pub.dev/packages/speech_to_text)** 
para el reconocimiento de voz.

Esta es una reescritura completa de [flutter_search_bar](https://pub.dev/packages/flutter_search_bar) con soporte para estas características:

## Características

- **¡Soporte para widgets [Stateless](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html)!**,
- trabaja con [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) internamente, el cual puede usarse
  directamente o integrarse fácilmente con cualquier proveedor,
- personalización completa,
- funciona en su lugar (sin redirecciones de navegación),
- no requiere variables adicionales en otros lugares,
- soporte para animaciones personalizadas (y incluye animaciones preconstruidas atractivas: [AppBarAnimationSlideDown](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarAnimationSlideDown-class.html) y [AppBarAnimationSlideLeft](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarAnimationSlideLeft-class.html) ) (**nuevo en v1.5+**),
- Además, hay algunas **clases auxiliares (opcionales)**:
  - [AppBarSearchButton](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarSearchButton-class.html),
  - [AppBarOnEditListener](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarOnEditListener-class.html),
  - [AppBarOnSubmitListener](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarOnSubmitListener-class.html),
  - [AppBarWithSearchFinder](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchFinder-class.html),
  - [AppBarSpeechButton](https://pub.dev/documentation/app_bar_with_search_switch/2.0.0-dev.2/app_bar_with_search_switch/AppBarSpeechButton-class.html) ( **solo en la versión 2.0+** )


## Vista rápida

Usa el parámetro [appBarBuilder](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/appBarBuilder.html)
para construir un AppBar predeterminado con: 
- un botón de búsqueda que llamará a [startSearch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/startSearch.html)
- o con el botón de búsqueda estándar [AppBarSearchButton](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarSearchButton-class.html).

El [appBarBuilder](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/appBarBuilder.html) 
**es el único parámetro obligatorio**, ¡todos los demás son opcionales! 

Usa una de estas funciones de devolución de llamada (callbacks) para obtener el texto del [TextField](https://api.flutter.dev/flutter/material/TextField-class.html):

- [onChanged](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/onChanged.html),
- [onSubmitted](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/onSubmitted.html),
- o escucha [textEditingController](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/textEditingController.html),
- o simplemente el [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html): [textNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/textNotifier.html) ...

También hay callbacks para:

- [onCleared](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/onCleared.html),
- [onClosed](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/onClosed.html).

Este widget soporta casi ***todas*** las propiedades de [AppBar](https://api.flutter.dev/flutter/material/AppBar-class.html),
excepto:

- las propiedades [leading](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/leading.html)
  y [title](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/title.html)
  ahora esperan `Widget Function(context)?`:

    - esto se hizo para permitir acceder a los métodos `AppBarWithSearchSwitch.of(context)` dentro de ellas,
    - no las modifiques a menos que sea necesario y usa plantillas si necesitas cambiar estas propiedades.

- [preferredSize](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/preferredSize.html) aquí es un método; deberías configurarlo
  mediante [toolbarWidth](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/toolbarWidth.html)
  y [toolbarHeight](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/toolbarHeight.html).

A continuación se muestra una lista de todas las demás propiedades nuevas (excluyendo las mencionadas anteriormente) con sus valores predeterminados:

- this.[tooltipForClearButton](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/tooltipForClearButton.html) = 'Clear',
- this.[tooltipForCloseButton](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/tooltipForCloseButton.html) = 'Close search',
- this.[fieldHintText](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/fieldHintText.html) = 'Search',
- this.[closeSearchIcon](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/closeSearchIcon.html) = Icons.close,
- this.[clearSearchIcon](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/clearSearchIcon.html) = Icons.backspace,
- this.[keepAppBarColors](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/keepAppBarColors.html) = true,
- this.[closeOnSubmit](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/closeOnSubmit.html) = true,
- this.[clearOnSubmit](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/clearOnSubmit.html) = false,
- this.[clearOnClose](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/clearOnClose.html) = false,
- this.[showClearButton](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/showClearButton.html) = true,
- this.[closeOnClearTwice](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/closeOnClearTwice.html) = true,
- this.[submitOnClearTwice](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/submitOnClearTwice.html) = true,
- this.[keyboardType](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/keyboardType.html) = TextInputType.text,
- this.[toolbarWidth](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/toolbarWidth.html) = double.infinity,
- // Estilo
- this.[searchInputDecoration](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/searchInputDecoration.html),
- this.[theme](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/theme.html),
- this.[titleTextStyle](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/titleTextStyle.html),
- this.[animation](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/animation.html) - (**nuevo en 1.5+**),
- // Y [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) opcionales 
 (pueden usarse para controlar el estado de [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)): 
- this.[customIsSearchModeNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsSearchModeNotifier.html),
- this.[customTextNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextNotifier.html),
- // Y [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) opcionales (solo lectura):
- this.[customHasText](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customHasText.html), 
- this.[customSubmitNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customSubmitNotifier.html),
- // Y [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) opcional:
- this.[customTextEditingController](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextEditingController.html), 

## Ejemplos

**Ejemplo en línea** aquí: [https://alexqwesa.github.io/app_bar_with_search_switch/](https://alexqwesa.github.io/app_bar_with_search_switch/).

Ejemplo completo de widget **Stateful** aquí: [https://pub.dev/packages/app_bar_with_search_switch/example](https://pub.dev/packages/app_bar_with_search_switch/example).

Ejemplo completo de widget **Stateless** [aquí: (github)](https://github.com/Alexqwesa/app_bar_with_search_switch/blob/master/example/lib/main_statefull.dart).

Ejemplo completo de widget Stateless con **10000 elementos** buscados en su lugar y con el botón de búsqueda fuera de la barra de aplicación es 
[aquí: (github)](https://github.com/Alexqwesa/app_bar_with_search_switch/blob/master/example/lib/main_in_place_effective.dart).

Ejemplo completo de widget Stateless donde **el botón Atrás de Android cerrará la búsqueda** es [aquí: (github)](https://github.com/Alexqwesa/app_bar_with_search_switch/blob/master/example/lib/main_android_back_button_clear_search.dart).

Y un fragmento del código de ejemplo es aquí:
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

## Capturas de pantalla

<img align="center" src="https://raw.githubusercontent.com/alexqwesa/app_bar_with_search_switch/master/screenshot.gif">


## Tareas pendientes

- [x] Agregar soporte de voz a texto - completado en la versión 2.0+,
- [x] Animación para la activación de la barra de búsqueda - completado en las versiones 1.5+
- [ ] ¿No utilizar [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) y [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) predeterminados compartidos?

## Preguntas frecuentes

**¿Cómo activar el campo de búsqueda (`isSearchMode=true`)
de [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)
desde algún lugar remoto?**

- Si está dentro del mismo [Scaffold](https://api.flutter.dev/flutter/material/Scaffold-class.html) o de sus hijos, entonces:
  1. usa [AppBarWithSearchFinder](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchFinder-class.html),
  2. llama a `AppBarWithSearchFinder.of(context)?.triggerSearch()` dentro de él.

- Si está fuera del [Scaffold](https://api.flutter.dev/flutter/material/Scaffold-class.html),
usa [customIsSearchModeNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsSearchModeNotifier.html),
  1. Inicializa una variable de tipo [ValueNotifier<bool>](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) en algún lugar superior en el árbol de widgets,
  2. Establece la propiedad [customIsSearchModeNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsSearchModeNotifier.html) de AppBarWithSearchSwitch con esta variable,
  3. Establece el valor de este [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) en `true` para mostrar el AppBar de búsqueda, 
  4. (Nota: actualmente, si detienes la búsqueda a través de esta variable (estableciéndola en `false`), `clearOnClose` no funcionará y el callback `onClose` no se llamará), por lo que usa `GlobalKey` si los necesitas.

**¿Cómo hacer que el botón Atrás de Android cierre la búsqueda?** (en lugar de volver a la pantalla anterior o salir de la aplicación)

1. Inicializa las variables `searchText` y `isSearchMode` de tipo [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) en algún lugar superior en el árbol de widgets,
2. Asigna estas variables a [customIsSearchModeNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsSearchModeNotifier.html), 
 [customTextNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextNotifier.html),
3. Envuelve el widget [Scaffold](https://api.flutter.dev/flutter/material/Scaffold-class.html) con [WillPopScope](https://api.flutter.dev/flutter/material/WillPopScope-class.html), 
 y define el parámetro `onWillPop` como en el ejemplo a continuación:

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

**¿Cómo agregar autocompletado al campo de búsqueda?**

* Usa el widget [Autocomplete](https://api.flutter.dev/flutter/material/Autocomplete-class.html) en el parámetro [title](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/title.html) 
:

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

**¿Se puede usar con versiones antiguas del SDK de Flutter?**

La versión 1.3.5 es un lanzamiento especial con soporte para SDKs de Flutter antiguos, ha sido probada con Flutter 2.10.0

## Problemas conocidos

- **CORREGIDO EN FLUTTER (UPSTREAM)** `keepAppBarColors = true` no cambiaba el color de los 'Text Selection Handles' (burbujas de selección), esto se debe a un problema en Flutter https://github.com/flutter/flutter/issues/74890 con textSelectionTheme: `selectionHandleColor` 
- Si por alguna razón usas **más de un** [AppBarWithSearchSwitch](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch-class.html)
 **en la misma página** (¿cómo? ¿y por qué?) proporciona a cada uno sus propios: [customIsSearchModeNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customIsSearchModeNotifier.html), 
[customTextNotifier](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextNotifier.html), 
[customTextEditingController](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customTextEditingController.html), 
[customHasText](https://pub.dev/documentation/app_bar_with_search_switch/latest/app_bar_with_search_switch/AppBarWithSearchSwitch/customHasText.html)...
