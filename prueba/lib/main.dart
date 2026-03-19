import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'analytics_service.dart';

import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDyCHOLq23iezJyMdopKqVZdOfB6semEnU",
      authDomain: "prueba-flutter-98316.firebaseapp.com",
      projectId: "prueba-flutter-98316",
      storageBucket: "prueba-flutter-98316.firebasestorage.app",
      messagingSenderId: "425438544932",
      appId: "1:425438544932:web:92f11bbe64c4a7425644b1",
      measurementId: "G-GTRN6K8RQV",
    ),
  );
  
  setupAnalyticsTracking(appRouter);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: appRouter,
    );
  }
}

// ----------------------------------------------------
// PÁGINA PRINCIPAL
// ----------------------------------------------------

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    AnalyticsService.logEvent(
      name: 'click_counter',
      params: {'counter_value': _counter},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                AnalyticsService.logEvent(
                  name: 'click_nav_button',
                  params: {'destination': 'Segunda página'},
                );
                context.push('/second');
              },
              child: const Text('Ir a 2da Página imagen'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                AnalyticsService.logEvent(
                  name: 'click_nav_button',
                  params: {'destination': '3ra Página botones'},
                );
                context.push('/third');
              },
              child: const Text('Ir a 3ra Página botones'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _incrementCounter,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: Text('Clicks: $_counter'),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// SEGUNDA PÁGINA
// ----------------------------------------------------

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final String imageUrl = 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';

  void _showImageDialog() {
    AnalyticsService.logEvent(name: 'click_enlarge_image');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: InteractiveViewer(
            child: Image.network(imageUrl, fit: BoxFit.contain),
          ),
        );
      },
    ).then((_) {
      AnalyticsService.logEvent(name: 'close_image_dialog');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('2da Página imagen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl, height: 150),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _showImageDialog,
              child: const Text('Agrandar imagen'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                AnalyticsService.logEvent(
                  name: 'click_nav_button',
                  params: {'destination': 'Página principal'},
                );
                context.pop();
              },
              child: const Text('Volver a Página principal'),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// TERCERA PÁGINA
// ----------------------------------------------------

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('3ra Página botones'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                AnalyticsService.logEvent(
                  name: 'click_nav_button',
                  params: {'destination': 'Página principal'},
                );
                context.pop();
              },
              child: const Text('Volver a Página principal'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                AnalyticsService.logEvent(name: 'click_useless_button');
              },
              child: const Text('Botón inútil (No hace nada)'),
            ),
          ],
        ),
      ),
    );
  }
}