import 'package:bluetoothpinterapp/product/model/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class PrintOutEvent extends Equatable {
  const PrintOutEvent();

  @override
  List<Object> get props => [];
}

class TitleEvent extends PrintOutEvent {
  final String title;

  const TitleEvent(this.title);

  @override
  List<Object> get props => [title];
}

class ExplanationEvent extends PrintOutEvent {
  final String explanation;

  const ExplanationEvent(this.explanation);

  @override
  List<Object> get props => [explanation];
}

class ProductTitleEvent extends PrintOutEvent {
  final String productTitle;

  const ProductTitleEvent(this.productTitle);

  @override
  List<Object> get props => [productTitle];
}

class ProductPriceEvent extends PrintOutEvent {
  final String productPrice;

  const ProductPriceEvent(this.productPrice);

  @override
  List<Object> get props => [productPrice];
}

class AddProductEvent extends PrintOutEvent {
  final ProductModel product;

  const AddProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveProductEvent extends PrintOutEvent {
  final int index;

  const RemoveProductEvent(this.index);

  @override
  List<Object> get props => [index];
}

class PrintOutFuncEvent extends PrintOutEvent {
  final String title;
  final String explanation;
  final List<ProductModel> products;

  const PrintOutFuncEvent(this.title, this.explanation, this.products);
}
