import 'package:bluetoothpinterapp/feature/bottom_menu/bottommenu_view.dart';
import 'package:bluetoothpinterapp/feature/print_out/printout_view.dart';
import 'package:bluetoothpinterapp/feature/printers/printers_view.dart';
import 'package:bluetoothpinterapp/product/core/base/base_state/base_state.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/bottom_menucontrol.dart';
import 'package:flutter/material.dart';

abstract class BottomMenuViewModel extends BaseState<BottomMenuView> {
  late List<Widget> viewList = <Widget>[
    const PrintersView(),
    const PrintOutView(),
  ];

  late int selectView =
      widget.startView?.menuValue == null ? 0 : widget.startView!.menuValue;

  // menu ontap
  void menuClickChange(int viewValue) {
    setState(() {
      selectView = viewValue;
    });
  }
}
