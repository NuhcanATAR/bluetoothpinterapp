import 'package:bluetoothpinterapp/product/extension/dynamic_extensions.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  // dynamic extension
  DynamicViewExtensions dynamicViewExtensions = DynamicViewExtensions();

  Logger logger = Logger();
}
