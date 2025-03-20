import 'package:flutter/material.dart';
import 'views/home.dart';

void main() => runApp(AmvaliInsights());


class AmvaliInsights extends StatelessWidget {
  const AmvaliInsights({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Amvali Insights',
      home: Home(),
    );
  }
}
