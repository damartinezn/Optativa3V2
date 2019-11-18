import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:trabajo03v2/bdhelper/DBHelper.dart';
import 'package:trabajo03v2/modelo/User.dart';
import 'package:trabajo03v2/vistas/MostrarDatos.dart';


class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MostrarLogin(),
    );
  }
}

class MostrarLogin extends StatefulWidget {
  @override
  _MostrarLoginState createState() => _MostrarLoginState();
}




class _MostrarLoginState extends State<MostrarLogin>{
  final formkey = new GlobalKey<FormState>();
  final dbHelper = DBHelper();
  String _user , _pass ;
  Future<List<User>> user;
  Future<User> user1;

  void moveToRegister(){
    Navigator.of(context).pushNamed('/RegistrarUsuario');
  }


  @override
  Widget build(BuildContext context) {


    final buttom = new InkWell(
      child: new Container(
        margin: new EdgeInsets.only(top: 30.0, left: 20.0, right: 20),
        padding: EdgeInsets.all(10.0),
        height: 450,
        width: 280.0,
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Color(0xFFf38b02),
              offset: new Offset(10.0, 10.0),
              blurRadius: 30.0,
            )

          ],
          borderRadius: new BorderRadius.circular(30.0),
          color: Color(0xFFfeb800),
        ),
        child: new Form(
          key: formkey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.only(top: 0.0, left: 80.0, right: 80),
                padding: EdgeInsets.all(00.0),
                height: 100,
                width: 100.0,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(200),
                  color: Colors.blueGrey[100],
                ),
                child: ImagenCargar(),
              ),
              new TextFormField(
                decoration: new InputDecoration(prefixIcon: Icon(Icons.supervised_user_circle),labelText: 'Ingrese su usuario'),
                validator: (value)=> value.isEmpty ? 'Ingrese el usuario.' : null,
                onSaved: (value) => _user = value,
              ),
              new TextFormField(
                decoration: new InputDecoration(prefixIcon: Icon(Icons.vpn_key),labelText: 'Ingrese su contraseña'),
                obscureText: true,
                validator: (value)=> value.isEmpty ? 'Ingrese la contraseña.' : null,
                onSaved: (value) => _pass = value,
              ),
              new Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: new RaisedButton(
                  child: new Text('Login',style: new TextStyle(fontSize: 20.0),),
                  onPressed: (){
                    if(formkey.currentState.validate()){
                      formkey.currentState.save();
                      user = dbHelper.getUser(_user, _pass);
                      dbHelper.getUser(_user, _pass)
                          .then((List<User> users){
                        if(users != null && users.length >0 ){
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new MostrarPage(usuario: user),
                          );
                          formkey.currentState.reset();
                          Navigator.of(context).push(route);
                        }else{
                          Toast.show("El usuario o contraseña están incorrectas, ingrese otra vez.", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        }
                      });
                    }
                  },
                  color: Colors.amber[800],
                ),
              ),
              new FlatButton(
                child: new Text(
                  'Crear una cuenta',
                  style: new TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                onPressed: moveToRegister,
              )
            ],
          ),
        ),
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.amber[300],
      body: new Stack(
        children: <Widget>[
          new ListView(
            children: <Widget>[
              new SingleChildScrollView(
                  child: new Container(
                    alignment: Alignment.center,
                    margin: new EdgeInsets.only(top: 50.0),
                    child: new Column(
                      children: <Widget>[
                        new Text(
                          "Login",
                          style: const TextStyle(
                              fontSize: 55.0,
                              color: Color(0xFFFF8F00),
                              fontWeight: FontWeight.w600),
                        ),

                        buttom,
                      ],
                    ),
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ImagenCargar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var imagen = new AssetImage('assets/user2.png');
    var img = new Image(
      image: imagen,
      width: 90.0,
      height: 90.0,
    );
    return new Container(
      child: img,
    );
  }
}



