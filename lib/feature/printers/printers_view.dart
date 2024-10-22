import 'package:flutter/material.dart';

class PrintersView extends StatefulWidget {
  const PrintersView({super.key});

  @override
  State<PrintersView> createState() => _PrintersViewState();
}

class _PrintersViewState extends State<PrintersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yazıcılar"),
      ),
    );
  }
}
