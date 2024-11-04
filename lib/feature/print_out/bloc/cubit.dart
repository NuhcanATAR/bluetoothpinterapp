import 'package:bluetoothpinterapp/feature/print_out/bloc/event.dart';
import 'package:bluetoothpinterapp/feature/print_out/bloc/state.dart';
import 'package:bluetoothpinterapp/product/core/base/helper/show_dialog.dart';
import 'package:bluetoothpinterapp/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrintOutBloc extends Bloc<PrintOutEvent, PrintOutState> {
  PrintOutBloc() : super(const PrintOutState()) {
    on<TitleEvent>((event, emit) {
      emit(state.copyWith(title: event.title));
    });

    on<ExplanationEvent>((event, emit) {
      emit(state.copyWith(explanation: event.explanation));
    });

    on<ProductTitleEvent>((event, emit) {
      emit(state.copyWith(productTitle: event.productTitle));
    });

    on<ProductPriceEvent>((event, emit) {
      emit(state.copyWith(productPrice: event.productPrice));
    });

    on<AddProductEvent>(addProduct);

    on<RemoveProductEvent>((event, emit) {
      removeProduct(event.index, emit);
    });

    on<PrintOutProductAddFuncEvent>(productAddFunc);
  }

  void addProduct(AddProductEvent event, Emitter<PrintOutState> emit) {
    final updatedProductList = List<ProductModel>.from(state.productList)
      ..add(event.product);

    emit(
      state.copyWith(
        productList: updatedProductList,
        message: 'Ürün Eklendi!',
        isProductAdded: true,
      ),
    );
  }

  void removeProduct(int index, Emitter<PrintOutState> emit) {
    final updatedProductList = List<ProductModel>.from(state.productList);
    if (updatedProductList.isNotEmpty && index < updatedProductList.length) {
      updatedProductList.removeAt(updatedProductList.length - 1 - index);
      emit(
        state.copyWith(
          productList: updatedProductList,
          message: 'Ürün Silindi!',
        ),
      );
    }
  }

  void productAddFunc(
    PrintOutProductAddFuncEvent event,
    Emitter<PrintOutState> emit,
  ) {
    if (event.productNameController.text.isNotEmpty &&
        event.productPriceController.text.isNotEmpty) {
      final productModel = ProductModel(
        event.productNameController.text,
        int.parse(event.productPriceController.text),
      );
      event.context.read<PrintOutBloc>().add(AddProductEvent(productModel));
      event.productNameController.clear();
      event.productPriceController.clear();
      Navigator.pop(event.context);
    } else {
      CodeNoahDialogs(event.context).showFlush(
        type: SnackType.warning,
        message: 'Ürün Bilgisi Eklemediniz!',
      );
    }
  }
}
