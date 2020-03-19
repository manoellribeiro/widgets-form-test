import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Controller();

  _textField({String labelText, onChanged, String Function() errorText, Key key}) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText == null ? null : errorText(),
          border: OutlineInputBorder()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Observer(
              builder: (_) {
                return _textField(
                    labelText: "Name",
                    onChanged: controller.client.changeName,
                    errorText: controller.validateName);
              },
            ),
            SizedBox(height: 20),
            Observer(
              builder: (_) {
                return _textField(
                    labelText: "Email",
                    onChanged: controller.client.changeEmail,
                    errorText: controller.validateEmail);
              },
            ),
            SizedBox(height: 50),
            Observer(
              builder: (_) {
              return RaisedButton(
                onPressed: controller.isValid ?() {

                } : null,
                child: Text("Salvar"),
              );
            })
          ],
        ),
      ),
    );
  }
}
