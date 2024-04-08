import 'package:aichatbot_curso/screens/home_screen.dart';
import 'package:aichatbot_curso/secrets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() {
  Gemini.init(apiKey: geminiApiKey);
  runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));
}
