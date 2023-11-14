import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frases Aleatórias',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Usando Colors.blue como MaterialColor
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RandomPhraseGenerator(),
    );
  }
}

class RandomPhraseGenerator extends StatefulWidget {
  @override
  _RandomPhraseGeneratorState createState() => _RandomPhraseGeneratorState();
}

class _RandomPhraseGeneratorState extends State<RandomPhraseGenerator> {
  List<String> phrases = [
    'A vida é feita de escolhas.',
    'O sucesso é a soma de pequenos esforços repetidos dia após dia.',
    'Se você quer vencer, não fique olhando a escada. Comece a subir degrau por degrau.',
    'A persistência realiza o impossível.',
    'Não espere por uma crise para descobrir o que é importante em sua vida.'
  ];

  String displayedPhrase = 'Pressione o botão para gerar uma frase!';

  void generateRandomPhrase() {
    final random = Random();
    final index = random.nextInt(phrases.length);
    setState(() {
      displayedPhrase = phrases[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frases Aleatórias'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              displayedPhrase,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 150),
            ElevatedButton(
              onPressed: generateRandomPhrase,
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 243, 33, 65), // Usando const Color
                onPrimary: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Text('Gerar Frase Aleatória'),
            ),
          ],
        ),
      ),
    );
  }
}
