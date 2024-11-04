// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bluetoothpinterapp/feature/print_out/bloc/cubit.dart';
import 'package:bluetoothpinterapp/feature/print_out/bloc/state.dart';
import 'package:bluetoothpinterapp/feature/printers/printers_view.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/show_dialog.dart';
import 'package:bluetoothpinterapp/product/extension/dynamic_extensions.dart';
import 'package:bluetoothpinterapp/product/util/base_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin PrintOutBlocMixin {
  void productRemoveListener(BuildContext context, PrintOutState state) {
    if (state.isProductAdded) {
      CodeNoahDialogs(context).showFlush(
        type: SnackType.success,
        message: 'Ürün Eklendi!',
      );

      context.read<PrintOutBloc>().emit(
            state.copyWith(isProductAdded: false),
          );
    }
  }

  void printersBottomModel(
    BuildContext context,
    DynamicViewExtensions dynamicViewExtensions,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            height: dynamicViewExtensions.dynamicHeight(context, 0.9),
            padding: PaddingSizedsUtility.top(
              PaddingSizedsUtility.normalPaddingValue,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: const PrintersView(),
          );
        },
      ),
    );
  }

  List<List<int>> chunkBytes(List<int> bytes, int chunkSize) {
    final List<List<int>> chunks = [];
    for (var i = 0; i < bytes.length; i += chunkSize) {
      chunks.add(
        bytes.sublist(
          i,
          i + chunkSize > bytes.length ? bytes.length : i + chunkSize,
        ),
      );
    }
    return chunks;
  }

  String convertSpecialCharacters(String input) {
    const specialCharacters = '₺çÇğĞıİöÖşŞüÜ';
    const asciiCharacters = 'TcCgGiIoOsSuU';

    for (int i = 0; i < specialCharacters.length; i++) {
      input = input.replaceAll(specialCharacters[i], asciiCharacters[i]);
    }

    return input;
  }
}
