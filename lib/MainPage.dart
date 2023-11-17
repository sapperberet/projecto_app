import 'package:flutter/material.dart';
import 'package:projecto_app/Login.dart';
import 'package:projecto_app/SignUp.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Hello")),
      body: Column(mainAxisAlignment: MainAxisAlignment.center , children: [Row(children: [ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),)), child: Text("Login")),SizedBox(height:20,width: 20,),ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),)), child: Text("SignUp")) ])],),
    );
  }
}
