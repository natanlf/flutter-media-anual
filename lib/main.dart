import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nota1Controller =
  TextEditingController(); //o new é implícito no dart, não é obrigatório o uso
  TextEditingController nota2Controller = TextEditingController();
  TextEditingController nota3Controller = TextEditingController();
  TextEditingController nota4Controller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "";

  void _resetFields() {
    nota1Controller.text = "";
    nota2Controller.text = "";
    nota3Controller.text = "";
    nota4Controller.text = "";
    setState(() {
      _infoText = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double n1 = double.parse(nota1Controller.text);
      double n2 = double.parse(nota2Controller.text);
      double n3 = double.parse(nota3Controller.text);
      double n4 = double.parse(nota4Controller.text);

      double media = (n1 + n2 + n3 + n4) / 4;

      if (media < 6.0) {
        _infoText = "Reprovado com média $media";
      } else {
        _infoText = "Aprovado com média $media";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Média anual"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: () => _resetFields())
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.school_outlined, size: 120.0,
                  color: Colors.indigoAccent),
              buildTextField("Nota 1", nota1Controller),
              buildTextField("Nota 2", nota2Controller),
              buildTextField("Nota 3", nota3Controller),
              buildTextField("Nota 4", nota4Controller),
              Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                      color: Colors.indigoAccent,
                    ),
                  )),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.indigoAccent, fontSize: 25.0),
              )
            ],
          ),)
        ,
      )
      ,
    );
  }

  Widget buildTextField(String label, TextEditingController c) {
    TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.indigoAccent)),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.indigoAccent, fontSize: 25.0),
      controller: c,
      validator: (value) {
        if (value.isEmpty) {
          return "Insira a nota 4";
        }
      },
    )
  }
}
