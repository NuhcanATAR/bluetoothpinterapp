import 'package:bluetoothpinterapp/product/model/product_model.dart';
import 'package:equatable/equatable.dart';

class PrintOutState extends Equatable {
  final String title;
  final String explanation;
  final String productTitle;
  final String productPrice;
  final String message;
  final List<ProductModel> productList;
  final bool isProductAdded;

  const PrintOutState({
    this.title = '',
    this.explanation = '',
    this.productTitle = '',
    this.productPrice = '',
    this.message = '',
    this.productList = const [],
    this.isProductAdded = false,
  });

  PrintOutState copyWith({
    String? title,
    String? explanation,
    String? productTitle,
    String? productPrice,
    String? message,
    List<ProductModel>? productList,
    bool? isProductAdded,
  }) {
    return PrintOutState(
      title: title ?? this.title,
      explanation: explanation ?? this.explanation,
      productTitle: productTitle ?? this.productTitle,
      productPrice: productPrice ?? this.productPrice,
      message: message ?? this.message,
      productList: productList ?? this.productList,
      isProductAdded: isProductAdded ?? this.isProductAdded,
    );
  }

  @override
  List<Object> get props => [
        title,
        explanation,
        productTitle,
        productPrice,
        message,
        productList,
        isProductAdded,
      ];
}

class PrintOutLoadingState extends PrintOutState {}

class PrintOutSuccessState extends PrintOutState {
  final String messageValue;

  const PrintOutSuccessState(this.messageValue);
}

class PrintOutErrorState extends PrintOutState {
  final String messageValue;

  const PrintOutErrorState(this.messageValue);
}
