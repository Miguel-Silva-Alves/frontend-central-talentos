import 'dart:ui';

class TopbarParameter {
  final VoidCallback onMenuPressed;
  String? goBack;
  Object? args;
  bool showgoback = false;

  TopbarParameter({required this.onMenuPressed, this.goBack, this.args});
}
