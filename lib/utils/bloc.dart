import 'dart:async';

import 'package:flutter/services.dart';

abstract class Bloc {
  void dispose();
}

class DeepLinkBloc extends Bloc {

  static const stream = const EventChannel('mightyweb/events');
  static const platform = const MethodChannel('mightyweb/channel');

  StreamController<String> _stateController = StreamController();

  Stream<String> get state => _stateController.stream;

  Sink<String> get stateSink => _stateController.sink;

  DeepLinkBloc() {
    startUri().then(_onRedirected);
    stream.receiveBroadcastStream().listen((d) => _onRedirected(d));
  }

  _onRedirected(String? uri) {
    stateSink.add(uri!);
  }

  @override
  void dispose() {
    _stateController.close();
  }

  Future<String?> startUri() async {
    try {
      return platform.invokeMethod('initialLink');
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}