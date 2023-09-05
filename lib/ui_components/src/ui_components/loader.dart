import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../ui_components.dart';

class Loader {
  Loader._();

  bool _isShowing = false;
  late BuildContext _context;
  late BuildContext _dismissingContext;
  late LoadingImage _dialog;

  static Loader _instance = Loader._();

  static Loader get instance => _instance;

  // @visibleForTesting
  static void newInstance() => _instance = Loader._();

  void dismiss() {
    if (_isShowing) {
      try {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          _isShowing = false;
          if (Navigator.of(_dismissingContext).canPop()) {
            Navigator.of(_dismissingContext).pop();
          }
        });
      } catch (_) {}
    }
  }

  void dismissNow() {
    if (_isShowing) {
      try {
        _isShowing = false;
        if (Navigator.of(_dismissingContext).canPop()) {
          Navigator.of(_dismissingContext).pop();
        }
      } catch (_) {}
    }
  }

  Future<bool> hide() {
    if (_isShowing) {
      try {
        _isShowing = false;
        Navigator.of(_dismissingContext).pop(true);
        return Future.value(true);
      } catch (_) {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  void show(BuildContext context) {
    _context = context;
    if (!_isShowing) {
      _dialog = const LoadingImage();
      _isShowing = true;
      showDialog<dynamic>(
        context: _context,
        barrierColor: Colors.black.withOpacity(0.6),
        barrierDismissible: kDebugMode,
        builder: (BuildContext context) {
          _dismissingContext = context;
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: _dialog,
          );
        },
      );
    }
  }
}

class LoadingImage extends StatelessWidget {
  const LoadingImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: SpinKitFadingCircle(color: AppColors.primary),
    ) // mockApp
        // ? const Text('loading')
        // : const SpinKitFadingCircle(color: AppColors.white),
        );
  }
}
