import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'ChatScreen';

  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Map<String, dynamic> _decisionTree = decisionTree;
  final List<Map<String, String>> _chatMessages = [];
  bool _isInputEnabled = true;
  dynamic _currentQuestion;

  @override
  void initState() {
    super.initState();
    _currentQuestion = _decisionTree;
  }

  void _handleResponse(String userResponse) {
    setState(() {
      _chatMessages.add({"text": userResponse, "isUser": true.toString()});
      if (_currentQuestion['options'] != null &&
          _currentQuestion['options'][userResponse] != null) {
        final nextQuestion = _currentQuestion['options'][userResponse];
        _chatMessages.add(
            {"text": nextQuestion['question'], "isUser": false.toString()});
        _currentQuestion = nextQuestion;
      } else {
        _isInputEnabled = false;
      }
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
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                return Align(
                  alignment: message['isUser'] == 'true'
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message['isUser'] == 'true'
                          ? Colors.grey[300]
                          : Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        color: message['isUser'] == 'true'
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                if (_isInputEnabled)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _currentQuestion['options'] != null
                        ? _currentQuestion['options']
                            .keys
                            .map<Widget>((option) {
                            return ElevatedButton(
                              onPressed: () {
                                _handleResponse(option);
                              },
                              child: Text(option),
                            );
                          }).toList()
                        : [],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final Map<String, dynamic> decisionTree = {
  "question": "¿Cómo puedo ayudarte?",
  "options": {
    "Información sobre la app": {
      "question": "¿Qué información necesitas?",
      "options": {
        "Funcionalidades": {
          "question": "¿Qué funcionalidades te interesan?",
          "options": {
            "Descargar GIFs": {
              "question": "¿Quieres saber cómo descargar GIFs?",
              "options": {
                "Sí": {
                  "question":
                      "Aquí tienes un tutorial sobre cómo descargar GIFs."
                },
                "No": {"question": "¿Hay algo más en lo que pueda ayudarte?"},
              },
            },
            "Compartir GIFs": {
              "question": "¿Quieres saber cómo compartir GIFs?",
              "options": {
                "Sí": {
                  "question":
                      "Aquí tienes un tutorial sobre cómo compartir GIFs."
                },
                "No": {"question": "¿Hay algo más en lo que pueda ayudarte?"},
              },
            },
          },
        },
        "Acerca de la app": {
          "question": "¿Quieres saber más sobre la app?",
          "options": {
            "Sí": {
              "question": "Aquí tienes información detallada sobre la app."
            },
            "No": {
              "question": "Bien, te deseo suerte al explorar nuestra app :) ."
            },
          },
        },
      },
    },
    "Otra cosa": {
      "question": "¿Cuál es tu pregunta?",
      "options": {
        "Preguntar sobre un tema específico": {
          "question": "Por favor, especifica tu pregunta.",
        },
        "Terminar la conversación": {
          "question": "¿Estás seguro de que quieres terminar la conversación?",
          "options": {
            "Sí": {
              "question":
                  "Entendido. Si tienes más preguntas, ¡estaré aquí para ayudarte!"
            },
            "No": {
              "question":
                  "Bien, recuerda estar pendiente a nuestros nuevas actualizaciones ;)"
            },
          },
        },
      },
    },
  },
};
