// Copyright (c) 2020, Aadarsh Patel
// All rights reserved.
// This source code is licensed under the BSD-style license found in the LICENSE file in the root directory of this source tree.

library decoding_text_effect;

import 'dart:core';
import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';

final _capitalLetters = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

final _smallLetters = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];

final _integers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

final _specialCharacters = [
  '!',
  '#',
  '\$',
  '%',
  '&',
  '(',
  ')',
  '*',
  '+',
  ',',
  '-',
  '.',
  '/',
  ':',
  ';',
  '<',
  '=',
  '>',
  '?',
  '@',
  '[',
  ']',
  '^',
  '_',
  '`',
  '{',
  '|',
  '}',
  '~'
];

enum DecodeEffect {
  /// Decoding effect starts from the first character of the String and ends at
  /// last character of the String.
  fromStart,

  /// Decoding effect starts from the last character of the String and ends at the
  /// first character of the String.
  fromEnd,

  /// Decoding effect starts from both first and last character of the String and ends at
  /// the middle character of the String.
  toMiddle,

  ///Decoding effect is applied to all the characters of the String simultaneously.
  all,

  ///Decoding effect is applied one by one to random index of the String.
  random,
}

class DecodingTextEffect extends StatefulWidget {
  /// Creates a Decoding Text Effect widget.
  ///
  /// The [decodeEffect] is required and [originalString] must not be `null`.
  ///
  /// The [refreshDuration] argument has a default value of `Duration(milliseconds: 60)` and the
  /// [eachCount] argument has a default value of `5`.
  DecodingTextEffect(
    this.originalString, {
    required this.decodeEffect,
    Key? key,
    this.textStyle,
    this.textAlign,
    this.refreshDuration,
    this.eachCount = 5,
    this.onTap,
    this.onFinished,
  }) : super(key: key);

  /// The string on which decoding effect will be performed and then displayed on
  /// `DecodingTextEffect` widget.
  final String originalString;

  /// This defines what type of decoding effect will be performed on `originalString`.
  final DecodeEffect decodeEffect;

  /// TextStyle for text in `DecodingTextEffect` widget.
  final TextStyle? textStyle;

  /// This defines the rate at which decoding effect will be performed, the speed of effect
  /// gets faster as the value of [refreshDuration] gets smaller.
  /// It has a default value of `Duration(milliseconds: 60)`. It is also the duration gap between
  /// any two consecutive `setState()` calls of the widget.
  final Duration? refreshDuration;

  /// This defines the number of random characters will be shown before showing the actual character
  /// for every character in the `originalString`.
  /// It has a default value of `5`.
  /// Note: In `DecodeEffect.all` the whole string is considered as a single character.
  final int eachCount;

  /// TextAlign for text in `DecodingTextEffect` widget.
  final TextAlign? textAlign;

  /// Adds the onTap [VoidCallback] to the Decoding Text Effect widget.
  final VoidCallback? onTap;

  /// Adds the onFinished [VoidCallback] to the Decoding Text Effect widget.
  final VoidCallback? onFinished;

  @override
  _DecodingTextEffectState createState() => _DecodingTextEffectState();
}

class _DecodingTextEffectState extends State<DecodingTextEffect> {
  int? _length;
  int? _eachCount;
  late Random _random;
  String? _originalString;
  String? _currentString;
  DecodeEffect? _effect;
  Duration? _refreshDuration;
  Duration _defaultRefreshDuration = Duration(milliseconds: 60);
  Timer? _timer;

  String _getRandomChar(int codePoint) {
    if (codePoint >= 48 && codePoint <= 57) {
      return _integers[_random.nextInt(10)];
    } else if (codePoint >= 65 && codePoint <= 90) {
      return _capitalLetters[_random.nextInt(26)];
    } else if (codePoint >= 97 && codePoint <= 122) {
      return _smallLetters[_random.nextInt(26)];
    } else if ((codePoint >= 33 && codePoint <= 47) ||
        (codePoint >= 58 && codePoint <= 64) ||
        (codePoint >= 91 && codePoint <= 96) ||
        (codePoint >= 123 && codePoint <= 126)) {
      return _specialCharacters[_random.nextInt(_specialCharacters.length)];
    } else {
      return String.fromCharCode(codePoint);
    }
  }

  String _getInitialString() {
    String _result = '';
    for (int i = 0; i < _length!; i++) {
      _result += _getRandomChar(_originalString!.codeUnitAt(i));
    }
    return _result;
  }

  void _onTap() {
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  void _onFinished() {
    if (widget.onFinished != null) {
      widget.onFinished!();
    }
  }

  @override
  void initState() {
    super.initState();

    _random = new Random();
    _originalString = widget.originalString;
    _length = widget.originalString.length;
    _effect = widget.decodeEffect;
    _refreshDuration = widget.refreshDuration;
    _eachCount = widget.eachCount;
    _currentString = _getInitialString();

    if (_refreshDuration == null) {
      _refreshDuration = _defaultRefreshDuration;
    }

    _startDecoding();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void _startDecoding() async {
    if (_effect == DecodeEffect.fromStart) {
      int _index = 0;
      int _count = 0;
      _timer = Timer.periodic(_refreshDuration!, (timer) {
        setState(() {
          if (_index == _length) {
            _currentString = _originalString;
            timer.cancel();
            _onFinished();
          } else {
            setState(() {
              for (int i = _index; i < _length!; i++) {
                _currentString = _currentString!.substring(0, i) +
                    _getRandomChar(_currentString!.codeUnitAt(i)) +
                    _currentString!.substring(i + 1);
              }
              _count += 1;
              if (_count == _eachCount) {
                _count = 0;
                _index += 1;
                _currentString = _originalString!.substring(0, _index) +
                    _currentString!.substring(_index);
              }
            });
          }
        });
      });
    } else if (_effect == DecodeEffect.fromEnd) {
      int _index = _length! - 1;
      int _count = 0;
      _timer = Timer.periodic(_refreshDuration!, (timer) {
        setState(() {
          if (_index == -1) {
            _currentString = _originalString;
            timer.cancel();
            _onFinished();
          } else {
            for (int i = 0; i <= _index; i++) {
              _currentString = _currentString!.substring(0, i) +
                  _getRandomChar(_currentString!.codeUnitAt(i)) +
                  _currentString!.substring(i + 1);
            }
            _count += 1;
            if (_count == _eachCount) {
              _count = 0;
              _currentString = _currentString!.substring(0, _index) +
                  _originalString!.substring(_index);
              _index -= 1;
            }
          }
        });
      });
    } else if (_effect == DecodeEffect.all) {
      String _temp;
      int _count = 0;
      _timer = Timer.periodic(_refreshDuration!, (timer) {
        setState(() {
          _temp = '';
          for (int i = 0; i < _length!; i++) {
            _temp += _getRandomChar(_originalString!.codeUnitAt(i));
          }
          _currentString = _temp;
          _count += 1;
          if (_count == _eachCount) {
            _currentString = _originalString;
            timer.cancel();
            _onFinished();
          }
        });
      });
    } else if (_effect == DecodeEffect.toMiddle) {
      int _head = 0;
      int _tail = _length! - 1;
      String _temp;
      int _count = 0;
      _timer = Timer.periodic(_refreshDuration!, (timer) {
        setState(() {
          if (_head >= _tail) {
            _currentString = _originalString;
            timer.cancel();
            _onFinished();
          } else {
            _temp = '';
            for (int i = _head; i < _tail; i++) {
              _temp += _getRandomChar(_currentString!.codeUnitAt(i));
            }
            _currentString = _originalString!.substring(0, _head) +
                _temp +
                _originalString!.substring(_tail);

            _count += 1;
            if (_count == _eachCount) {
              _count = 0;
              _head += 1;
              _tail -= 1;
            }
          }
        });
      });
    } else if (_effect == DecodeEffect.random) {
      List _indexList = Iterable<int>.generate(_length!).toList();
      List _shuffledList = Iterable<int>.generate(_length!).toList();
      int _index = 0;
      _shuffledList.shuffle();
      int _count = 0;
      String _temp;
      _timer = Timer.periodic(_refreshDuration!, (timer) {
        setState(() {
          if (_index == _length) {
            _currentString = _originalString;
            timer.cancel();
            _onFinished();
          } else {
            _temp = '';
            for (int i = 0; i < _length!; i++) {
              if (_indexList[i] == -1) {
                _temp += _originalString![i];
              } else {
                _temp += _getRandomChar(_originalString!.codeUnitAt(i));
              }
            }
            _currentString = _temp;
            _count += 1;
            if (_count == _eachCount) {
              _count = 0;
              _indexList[_shuffledList[_index]] = -1;
              _index += 1;
            }
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.originalString != _originalString) {
      _originalString = widget.originalString;
      _length = widget.originalString.length;
      _effect = widget.decodeEffect;
      _refreshDuration = widget.refreshDuration;
      _eachCount = widget.eachCount;
      _currentString = _getInitialString();
      if (_refreshDuration == null) {
        _refreshDuration = _defaultRefreshDuration;
      }
      _timer!.cancel();
      _startDecoding();
    }

    return GestureDetector(
      onTap: _onTap,
      child: Text(
        _currentString!,
        style: widget.textStyle,
        textAlign: widget.textAlign,
      ),
    );
  }
}
