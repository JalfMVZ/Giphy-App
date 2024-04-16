import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'ChatScreen';

  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _conversation = [];
  final List<Map<String, dynamic>> _decisionTree = [
    {
      "id": 1,
      "question": "¿Cómo puedo ayudarte?",
      "options": ["Información sobre la app", "Otra cosa"]
    },
    {
      "id": 2,
      "question": "¿Qué información necesitas?",
      "options": ["Funcionalidades", "Acerca de la app"]
    },
    {
      "id": 3,
      "question": "¿Qué funcionalidades te interesan?",
      "options": ["Descargar GIFs", "Compartir GIFs"]
    },
    {
      "id": 4,
      "question": "¿Quieres saber cómo descargar GIFs?",
      "options": ["Sí", "No"]
    },
    {
      "id": 5,
      "question": "¿Quieres saber cómo compartir GIFs?",
      "options": ["Sí", "No"]
    },
    {
      "id": 6,
      "question": "¿Quieres saber más sobre la app?",
      "options": ["Sí", "No"]
    },
    {
      "id": 7,
      "question": "¿Cuál es tu pregunta?",
      "options": [
        "Preguntar sobre un tema específico",
        "Terminar la conversación"
      ]
    },
    {"id": 8, "question": "Por favor, especifica tu pregunta.", "options": []},
    {
      "id": 9,
      "question": "¿Estás seguro de que quieres terminar la conversación?",
      "options": ["Sí", "No"]
    }
  ];

  Map<String, dynamic>? _currentQuestion;

  @override
  void initState() {
    super.initState();
    _currentQuestion = _decisionTree.first;
  }

  void _handleResponse(String userResponse) {
    setState(() {
      _conversation.add({"text": userResponse, "isUser": true});
      final nextQuestionId =
          _currentQuestion!['options'].indexOf(userResponse) + 1;
      _currentQuestion = _decisionTree.firstWhere(
          (question) => question['id'] == nextQuestionId,
          orElse: () => _decisionTree.first);
      _conversation
          .add({"text": _currentQuestion!['question'], "isUser": false});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _conversation.length,
              itemBuilder: (context, index) {
                final message = _conversation[index];
                return Align(
                  alignment: message['isUser']
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message['isUser'] ? Colors.grey[300] : Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      message['text'],
                      style: TextStyle(
                        color: message['isUser'] ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _currentQuestion!['options'].map<Widget>((option) {
                return ElevatedButton(
                  onPressed: () {
                    _handleResponse(option);
                  },
                  child: Text(option),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
