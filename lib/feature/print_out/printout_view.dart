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
      appBar: AppBar(
        title: const Text("Çıktı Al"),
      ),
    );
  }
}
