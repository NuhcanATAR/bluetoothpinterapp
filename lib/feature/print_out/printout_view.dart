import 'package:bluetoothpinterapp/product/widget/text_widget/body_medium_text.dart';
import 'package:flutter/material.dart';

class PrintOutView extends StatefulWidget {
  const PrintOutView({super.key});

  @override
  State<PrintOutView> createState() => _PrintOutViewState();
}

class _PrintOutViewState extends State<PrintOutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        centerTitle: true,
        title: const BodyMediumBlackBoldText(
          text: 'Çıktı Al',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
