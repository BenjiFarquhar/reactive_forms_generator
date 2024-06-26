import 'package:example/drawer.dart';
import 'package:flutter/material.dart';

class SampleScreen extends StatelessWidget {
  final Widget body;
  final Widget? title;

  const SampleScreen({super.key, required this.body, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: body,
        ),
      ),
    );
  }
}
