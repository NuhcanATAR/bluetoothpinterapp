import 'package:bluetoothpinterapp/feature/print_out/bloc/event.dart';
import 'package:bluetoothpinterapp/feature/print_out/bloc/state.dart';
import 'package:bluetoothpinterapp/product/model/product_model.dart';
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

    on<PrintOutFuncEvent>(printOut);
  }

  void addProduct(AddProductEvent event, Emitter<PrintOutState> emit) {
    final updatedProductList = List<ProductModel>.from(state.productList)
      ..add(event.product);

    emit(
      state.copyWith(
        productList: updatedProductList,
        message: 'Ürün Eklendi!',
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

  Future<void> printOut(
    PrintOutFuncEvent event,
    Emitter<PrintOutState> emit,
  ) async {}
}
