import 'package:flutter/material.dart';

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  @override
  final onTap;
  final Widget? child;
  MyPopupMenuItem({@required this.child, required this.onTap})
      : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopMenuIterm>
    extends PopupMenuItemState<T, PopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onTap!();
  }
}
