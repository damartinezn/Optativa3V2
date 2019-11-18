import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trabajo03v2/bdhelper/DBHelper.dart';
import 'package:trabajo03v2/bdhelper/Utility.dart';
import 'package:trabajo03v2/modelo/User.dart';

class RegistroUser extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: RegistroPage(),
    );
  }
}

class RegistroPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}




class _StudentPageState extends State<RegistroPage> {

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
//declaramos todas las variables a utilizar

  DBHelper dbHelper;

//variables para el form
  String nombre, apellido, cedula, correo, direccion, user, pass;

//controller para regresar a txt
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final cedulaController = TextEditingController();
  final correoController = TextEditingController();
  final direccionController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();

   File _selectedPicture;
   String auxImagen;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Usuarios'),
      ),
      backgroundColor: Colors.blue[700],
      body: ListView(
        children: <Widget>[
          Container(

            child: Column(
              children: <Widget>[
                if(_selectedPicture != null)
                  SizedBox(
                    height: 150,
                    child: Image.file(_selectedPicture),
                  ),

              ],
            ),
          ),
          componentes(),
        ],
      ),
    );
  }
   IconButton imagenCargar(){
     return new IconButton(
         icon: Icon(Icons.camera_alt, size: 50,),
         color: Colors.deepOrange[300],

         onPressed: () async {
           var imagen = await ImagePicker.pickImage(source: ImageSource.gallery);
           setState((){
              _selectedPicture = imagen;
           });
         }
     );
   }


   SingleChildScrollView componentes (){
     return SingleChildScrollView(
       child: Container(
         margin: new EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
         padding: EdgeInsets.all(10),
         decoration: new BoxDecoration(
           boxShadow: [
             new BoxShadow(
               color: Colors.lightBlueAccent[100],
               offset: new Offset(10.0, 10.0),
               blurRadius: 30.0,
             )
           ],
           borderRadius: new BorderRadius.circular(30),
           color: Colors.lightBlue[200],
         ),
         child: new Form(
           key: _formStateKey,
           autovalidate: true,
           child: Column(
             children: <Widget>[
               imagenCargar(),
               new Text("Seleccione una imagen"),
               new TextFormField(
                 decoration: new InputDecoration(labelText: 'Ingrese su nombre'),
                 validator: (value)=> value.isEmpty ? 'Ingrese el nombre.' : null,
                 onSaved: (value) => nombre = value,
               ),
               new TextFormField(
                 decoration: new InputDecoration(labelText: 'Ingrese su apellido'),
                 //obscureText: true,
                 validator: (value)=> value.isEmpty ? 'Ingrese el apellido.' : null,
                 onSaved: (value) => apellido = value,
               ),
               new TextFormField(
                 keyboardType: TextInputType.number,
                 decoration: new InputDecoration(labelText: 'Ingrese su cedula'),
                 //obscureText: true,
                 validator: (value)=> value.isEmpty ? 'Ingrese su cedula' : null,
                 onSaved: (value) => cedula = value,
               ),
               new TextFormField(
                 keyboardType: TextInputType.emailAddress,
                 decoration: new InputDecoration(labelText: 'Ingrese el correo'),
                 //obscureText: true,
                 validator: (value)=> value.isEmpty ? 'Ingrese el correo.' : null,
                 onSaved: (value) => correo = value,
               ),
               new TextFormField(
                 decoration: new InputDecoration(labelText: 'Ingrese su direccion'),
                 //obscureText: true,
                 validator: (value)=> value.isEmpty ? 'Ingrese su direccion.' : null,
                 onSaved: (value) => direccion = value,
               ),
               Divider(
                 height: 25,
                 color: Colors.black,
               ),

               new TextFormField(
                 decoration: new InputDecoration(labelText: 'Ingrese usuario'),
                 //obscureText: true,
                 validator: (value)=> value.isEmpty ? 'Ingrese un usuario.' : null,
                 onSaved: (value) => user = value,
               ),
               new TextFormField(
                 decoration: new InputDecoration(labelText: 'Ingrese una contraseña'),
                 obscureText: true,
                 validator: (value)=> value.isEmpty ? 'Ingrese una contraseña.' : null,
                 onSaved: (value) => pass = value,
               ),
               new Container(
                 padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                 decoration: new BoxDecoration(
                     borderRadius: BorderRadius.circular(50)
                 ),
                 child: new RaisedButton(
                   hoverElevation: 200,
                   splashColor: Colors.blueAccent,
                   child: new Text('Registrar Usuario',style: new TextStyle(fontSize: 20.0),),
                   onPressed: (){
                     if(_formStateKey.currentState.validate()){
                       _formStateKey.currentState.save();
                       auxImagen = Utility.base64String(_selectedPicture.readAsBytesSync());
                       dbHelper.newClient(User(null, nombre, apellido, cedula, correo, direccion, auxImagen, user, pass));
                       _formStateKey.currentState.reset();
                       Navigator.of(context).pushNamed('/Header');
                     }
                   },
                   color: Colors.amber[100],
                 ),

               ),
             ],
           ),
         ),
       ),
     );
   }

}


