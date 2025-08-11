import 'dart:async';

class Debouncer {
  Timer? _timer;
  final int milliseconds;

  Debouncer({this.milliseconds = 300});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

typedef VoidCallback = void Function();
