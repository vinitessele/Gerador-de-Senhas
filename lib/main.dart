import 'dart:math';

import 'package:flutter/material.dart';

main() {
  runApp(GeradorSenhasApp());
}

class GeradorSenhasAppState extends State<GeradorSenhasApp> {
  bool maiuscula = true;
  bool minusculas = true;
  bool caracterespecial = true;
  bool numeros = true;
  double range = 6;
  String pass = '';

  void geradorPasswordState() {
    setState(() {
      pass = geradorPassword();
    });
  }

  String geradorPassword() {
    List<String> charList = <String>[
      maiuscula ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : '',
      minusculas ? 'abcdefghijklmnopqrstuvwxyz' : '',
      numeros ? '0123456789' : '',
      caracterespecial ? '!@#\$%&*-=+,.<>;:/?' : ''
    ];

    final String chars = charList.join('');
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        range.round(), (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gerador de senha'),
        ),
        body: Column(
          children: [
            sizedBoxImg(),
            textoMaior(),
            textoMenor(),
            sizedBox(),
            opcoes(),
            sizedBox(),
            slider(),
            botao(),
            sizedBox(),
            resultado(),
          ],
        ),
      ),
    );
  }

  Widget resultado() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * .70,
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: Text(
          pass,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  Widget slider() {
    return Slider(
      value: range,
      max: 50,
      divisions: 50,
      label: range.round().toString(),
      onChanged: (double newRange) {
        setState(() {
          range = newRange;
        });
      },
    );
  }

  Widget opcoes() {
    return Row(children: [
      Checkbox(
          value: maiuscula,
          onChanged: (bool? value) {
            setState(() {
              maiuscula = value!;
            });
          }),
      Text('[A-Z]'),
      Checkbox(
          value: minusculas,
          onChanged: (bool? value) {
            setState(() {
              minusculas = value!;
            });
          }),
      Text('[a-z]'),
      Checkbox(
          value: numeros,
          onChanged: (bool? value) {
            setState(() {
              numeros = value!;
            });
          }),
      Text('[0-9]'),
      Checkbox(
          value: caracterespecial,
          onChanged: (bool? value) {
            setState(() {
              caracterespecial = value!;
            });
          }),
      Text('[@#!]')
    ]);
  }

  Widget botao() {
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        child: const Text('Gerar senha'),
        onPressed: geradorPasswordState,
      ),
    );
  }

  Widget sizedBox() {
    return SizedBox(
      height: 30,
    );
  }

  Widget sizedBoxImg() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.network(
          "https://cdn.pixabay.com/photo/2013/04/01/09/02/read-only-98443_1280.png"),
    );
  }

  Widget textoMaior() {
    return const Text(
      'Gerador automático de senha',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }

  Widget textoMenor() {
    return const Text(
      'Aqui você escolhe como deseja gerar sua senha',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    );
  }
}

class GeradorSenhasApp extends StatefulWidget {
  GeradorSenhasAppState createState() {
    return GeradorSenhasAppState();
  }
}
