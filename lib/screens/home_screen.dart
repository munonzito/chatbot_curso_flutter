import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List messages = [];
  TextEditingController textController = TextEditingController();
  final gemini = Gemini.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('AI Chatbot', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              bool isUser = messages[index]['role'] == 'user';
              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    messages[index]['text'],
                    style:
                        TextStyle(color: isUser ? Colors.white : Colors.black),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 400,
                  child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true))),
              IconButton(
                  onPressed: () async {
                    messages.add({'text': textController.text, 'role': 'user'});
                    textController.clear();
                    setState(() {});
                    final response = await gemini.chat(messages
                        .map((message) => Content(
                              parts: [Parts(text: message['text'] ?? '')],
                              role: message['role'] ?? '',
                            ))
                        .toList());
                    messages
                        .add({'text': response?.output ?? '', 'role': 'model'});
                    setState(() {});
                  },
                  icon: const Icon(Icons.send))
            ],
          ),
        )
      ]),
    );
  }
}
