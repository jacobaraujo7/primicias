import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/person.dart';
import 'package:flutter_sandbox/viewmodel/person_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // representaçao da regra de negocio coorporativa
  var person = Person();
  final viewModel = PersonViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IMC Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(decoration: const InputDecoration(labelText: 'weight (m)'), keyboardType: TextInputType.number, onChanged: person.setWeight),
            TextField(decoration: const InputDecoration(labelText: 'Weight (kg)'), keyboardType: TextInputType.number, onChanged: person.setHeight),
            ElevatedButton(onPressed: () => viewModel.calcularIMC(person), child: const Text('Calculate IMC')),
            ListenableBuilder(
              listenable: viewModel,
              builder: (context, child) {
                return Text(viewModel.result);
              },
            ),
          ],
        ),
      ),
    );
  }
}
