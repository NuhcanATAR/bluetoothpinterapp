import 'package:bluetoothpinterapp/feature/print_out/bloc/mixin.dart';
import 'package:bluetoothpinterapp/feature/print_out/printout_view.dart';
import 'package:bluetoothpinterapp/product/core/base/base_state/base_state.dart';
import 'package:flutter/material.dart';

abstract class PrintOutViewModel extends BaseState<PrintOutView>
    with PrintOutBlocMixin {
  final formPrintOutKey = GlobalKey<FormState>();

  late TextEditingController titleController = TextEditingController();
  late TextEditingController explanationController = TextEditingController();
  late TextEditingController productNameController = TextEditingController();
  late TextEditingController productPriceController = TextEditingController();
}
