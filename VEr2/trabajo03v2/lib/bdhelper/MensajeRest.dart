
import 'package:trabajo03v2/Rest/mensaje_provider.dart';
import 'package:trabajo03v2/modelo/Mensaje.dart';

class MensajeRest{
  final mensajeProvider = new MensajeProvider();
  Future<List<Mensaje>> lista;
  Mensaje aux;
  String mensajeText;

  String mensajeEnviar(){
    lista = mensajeProvider.getData();
    lista.then((List<Mensaje> lisMensaje){
      if(lisMensaje != null && lisMensaje.length>0){
          aux = new Mensaje(lisMensaje[0].msg);
          mensajeText = aux.msg.toString();
          print("********************************************************");
          print(mensajeText);
          print("********************************************************");
      }
    });
    return aux.msg;
  }

}