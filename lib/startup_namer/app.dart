import 'package:flutter/material.dart';
import './random_words_state.dart';

class StartupNamer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new RandomWords(),
    );
  }
}
