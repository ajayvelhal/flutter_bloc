import 'dart:async';

import 'package:sample_bloc_example/bloc/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  final _counterStateController = StreamController<int>();

  // ignore: missing_return
  StreamSink<int> get _inCounter => _counterStateController.sink;

  Stream<int> get counter => _counterStateController.stream;

  final _eventController = StreamController<CounterEvent>();

  Sink<CounterEvent> get counterEventSink => _eventController.sink;

  CounterBloc() {
    _eventController.stream.listen(_mapEventState);
  }

  void _mapEventState(CounterEvent event) {
    if (event is incCounter)
      _counter++;
    else
      _counter--;

    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _eventController.close();
  }
}
