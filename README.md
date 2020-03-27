<div align="center"><img src="https://github.com/aadarsh-patel/decoding_text_effect/blob/master/example/display/home.gif?raw=true"/></div><br>

<h3><div align="center">This flutter package contains a widget called DecodingTextEffect which is having some cool Decode Effects for texts.</div><br></h3>

<div align="center">  
   <a href="https://flutter.dev">  
    <img src="https://img.shields.io/badge/Platform-Flutter-yellow.svg"  
      alt="Platform" />  
  </a>  
   <a href="https://pub.dev/packages/decoding_text_effect">  
    <img src="https://img.shields.io/pub/v/decoding_text_effect.svg"  
      alt="Pub Package" />  
  </a>  
   <a href="https://github.com/aadarsh-patel/decoding_text_effect/blob/master/LICENSE">  
    <img src="https://img.shields.io/github/license/aadarsh-patel/decoding_text_effect"  
      alt="License: BSD" />  
  </a>  
</div>
<br> 
 
 # Installing

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  decoding_text_effect: ^1.0.0
```

### 2. Install it

You can install packages from the command line:

```css
$ flutter pub get
```

### 3. Import it

Now in your `Dart` code, you can use: 

```dart
import 'package:decoding_text_effect/decoding_text_effect.dart';
```

# Documentation

Decoding effects occurs only for following two cases,
1. When the widget is rendered for the very first time.
2. When the value of `originalString` parameter gets changed.

```dart
DecodingTextEffect(
   this.originalString, {
   @required this.decodeEffect,
   Key key,
   this.textStyle,
   this.textAlign,
   this.refreshDuration,
   this.eachCount = 5,
   this.onTap,
   this.onFinished,
  })  : assert(
         originalString != null,
         'A non-null String must be provided to a Decoding Text Effect Widget.',
        ),
        super(key: key);
```

# Usage

```dart
List<String> myText = [
   'Decoding Text\nEffect',
   'Welcome to\nthe Dart Side!',
   'I have 50\nwatermelons',
   'Quick Maths,\n2 + 2 = 4'
  ];
```

## 1. DecodeEffect.fromStart

<img src="https://github.com/aadarsh-patel/decoding_text_effect/blob/master/example/display/from_start.gif?raw=true" align = "right" height = "200px">

```dart
Container(
   height: 200,
   width: 350,
   color: Colors.pink[100],
   padding: EdgeInsets.all(50),
   child: DecodingTextEffect(
      myText[index],
      decodeEffect: DecodeEffect.fromStart,
      textStyle: TextStyle(fontSize: 30),
   ),
),
```

## 2. DecodeEffect.fromEnd

<img src="https://github.com/aadarsh-patel/decoding_text_effect/blob/master/example/display/from_end.gif?raw=true" align = "right" height = "200px">

```dart
Container(
   height: 200,
   width: 350,
   color: Colors.yellow[100],
   padding: EdgeInsets.all(50),
   child: DecodingTextEffect(
      myText[index],
      decodeEffect: DecodeEffect.fromEnd,
      textStyle: TextStyle(fontSize: 30),
   ),
),
```

## 3. DecodeEffect.toMiddle

<img src="https://github.com/aadarsh-patel/decoding_text_effect/blob/master/example/display/to_middle.gif?raw=true" align = "right" height = "200px">

```dart
Container(
   height: 200,
   width: 350,
   color: Colors.green[100],
   padding: EdgeInsets.all(50),
   child: DecodingTextEffect(
      myText[index],
      decodeEffect: DecodeEffect.to_middle,
      textStyle: TextStyle(fontSize: 30),
   ),
),
```

## 4. DecodeEffect.random

<img src="https://github.com/aadarsh-patel/decoding_text_effect/blob/master/example/display/random.gif?raw=true" align = "right" height = "200px">

```dart
Container(
   height: 200,
   width: 350,
   color: Colors.purple[100],
   padding: EdgeInsets.all(50),
   child: DecodingTextEffect(
      myText[index],
      decodeEffect: DecodeEffect.random,
      textStyle: TextStyle(fontSize: 30),
   ),
),
```

## 5. DecodeEffect.all

<img src="https://github.com/aadarsh-patel/decoding_text_effect/blob/master/example/display/all.gif?raw=true" align = "right" height = "200px">

```dart
Container(
   height: 200,
   width: 350,
   color: Colors.blue[100],
   padding: EdgeInsets.all(50),
   child: DecodingTextEffect(
      myText[index],
      decodeEffect: DecodeEffect.all,
      textStyle: TextStyle(fontSize: 30),
   ),
),
```

## refreshDuration and eachCount

The `refreshDuration` is an optional argument that is having a default value of `Duration(milliseconds: 60)`.
Shorter the value of refreshDuration, faster will be the effect and hence decreasing the duration of effect. `refreshDuration` is also the time gap between two consecutive `setState()` function calls.

The `eachCount` is also an optional argument that is having a default value of `5`. It is the number of random characters that will be shown before showing the original character and then moving on to decode next character and this cycles repeat until the completion of effect.

# Demo

Source code of the below app is available in the example directory of this package's github repository.

<img src="https://github.com/aadarsh-patel/decoding_text_effect/blob/master/example/display/demo_app.gif?raw=true" height = "400px">

Below are some other demonstration of DecoratingTextEffect widget. But the source code of below apps are not in this repository.

|   |   |
|---|---|
|<img src="https://github.com/aadarsh-patel/decoding_text_effect/blob/master/example/display/real_application.gif?raw=true" height = "400px"> | <img src="https://github.com/aadarsh-patel/decoding_text_effect/blob/master/example/display/matrix.gif?raw=true" height = "400px"> |
