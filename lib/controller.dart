import 'package:form_mobx_with_tests/models/client.dart';
import 'package:mobx/mobx.dart';

part 'controller.g.dart';

class Controller = _ControllerBase with _$Controller;

abstract class _ControllerBase with Store {
  
  var client = Client();

  @computed
  bool get isValid{
    return validateName() == null && validateEmail() == null;
  }

  String validateName(){
    if(client.name == null || client.name.isEmpty){
      return "Este campo é obrigatório";
    }else if(client.name.length < 3){
      return "Seu nome precisa ter pelo menos 3 caracteres";
    }
    return null;
  }
  String validateEmail(){
    if(client.email == null || client.email.isEmpty){
      return "Este campo é obrigatório";
    }else if(!client.email.contains("@")){
      return "Esse não é um e-mail válido";
    }
    return null;
  }

}