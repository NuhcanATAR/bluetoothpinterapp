import 'package:bluetoothpinterapp/feature/print_out/bloc/state.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/show_dialog.dart';
import 'package:flutter/material.dart';

mixin PrintOutBlocMixin {
  void productRemoveListener(BuildContext context, PrintOutState state) {
    if (state.message.isNotEmpty) {
      CodeNoahDialogs(context).showFlush(
        type: SnackType.success,
        message: state.message,
      );
    }
  }
}
