import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_mobx_with_tests/main.dart';

void main() {
  testWidgets("Teste da tela inicial", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text("Salvar"), findsOneWidget);
    expect(find.text("Name"), findsOneWidget);
    expect(find.text("Email"), findsOneWidget);
    expect(find.text("Formulário"), findsOneWidget);
    expect(find.text("Este campo é obrigatório"), findsNWidgets(2));
    expect(find.byType(RaisedButton), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });
  group("Teste do TextField Name", (){
 
    testWidgets("Teste de valores com menos de 3 caracteres", (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.enterText(find.widgetWithText(TextField, "Name"), "An");
      await tester.pump();
      expect(find.text("Seu nome precisa ter pelo menos 3 caracteres"), findsOneWidget);
    });

    testWidgets("Teste de valores não nulos e com mais de 3 caracteres", (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.enterText(find.widgetWithText(TextField, "Name"), "Ana");
      await tester.pump();
      expect(find.text("Este campo é obrigatório"), findsOneWidget);
    });
  });
  group("Teste do TextField Email", (){
    
    testWidgets("Teste de valores que não contém @", (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.enterText(find.widgetWithText(TextField, "Email"), "Ana_hotmail.com");
      await tester.pump();
      expect(find.text("Esse não é um e-mail válido"), findsOneWidget);
    });

    testWidgets("Teste de valores não nulos e que contém @", (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.enterText(find.widgetWithText(TextField, "Email"), "Ana@hotmail.com");
      await tester.pump();
      expect(find.text("Este campo é obrigatório"), findsOneWidget);
    });
  });

  group("Teste do RaisedButton", (){
      testWidgets("RaisedButton está desabilitado", (WidgetTester tester) async {
        await tester.pumpWidget(MyApp());
        await tester.enterText(find.widgetWithText(TextField, "Name"), "Ana");
        await tester.enterText(find.widgetWithText(TextField, "Email"), "Ana_hotmail.com"); 
        await tester.pump(); 
        final raisedButton =  tester.firstWidget(find.widgetWithText(RaisedButton, "Salvar")) as RaisedButton;
        expect(raisedButton.enabled, false); 
      });
      testWidgets("RaisedButton está desabilitado pelo TextField Name", (WidgetTester tester) async {
        await tester.pumpWidget(MyApp());
        await tester.enterText(find.widgetWithText(TextField, "Name"), "An");
        await tester.enterText(find.widgetWithText(TextField, "Email"), "Ana@hotmail.com"); 
        await tester.pump(); 
        final raisedButton =  tester.firstWidget(find.widgetWithText(RaisedButton, "Salvar")) as RaisedButton;
        expect(raisedButton.enabled, false); 
      });
      testWidgets("RaisedButton está habilitado", (WidgetTester tester) async {
        await tester.pumpWidget(MyApp());
        await tester.enterText(find.widgetWithText(TextField, "Name"), "Ana");
        await tester.enterText(find.widgetWithText(TextField, "Email"), "Ana@hotmail.com"); 
        await tester.pump(); 
        final raisedButton =  tester.firstWidget(find.widgetWithText(RaisedButton, "Salvar")) as RaisedButton;
        expect(raisedButton.enabled, true); 
      });
  });
}
