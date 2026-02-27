import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'tracked_screen.dart';
import 'app_lifecycle_tracker.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

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
  runApp(const AppLifecycleTracker(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Página Principal'),
      navigatorObservers: [routeObserver],
    );
  }
}

//Página principal con 3 botones para navegar a otras pantallas

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Mixin para el rastreo de eventos de pantalla 

class _MyHomePageState extends State<MyHomePage>
    with TrackedScreen<MyHomePage> {
  @override
  String get screenName => 'Página principal';

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              child: const Text('Ir a 2da Página imagen'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdPage()),
                );
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

//Segunda página con una imagen

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with TrackedScreen<SecondPage> {
  @override
  String get screenName => 'Segunda página';

  final String imageUrl = 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: InteractiveViewer(
            child: Image.network(imageUrl, fit: BoxFit.contain),
          ),
        );
      },
    );
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
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver a Página principal'),
            ),
          ],
        ),
      ),
    );
  }
}

// Tercera página

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> with TrackedScreen<ThirdPage> {
  @override
  String get screenName => '3ra Página botones';

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
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver a Página principal'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {}, // Botón inactivo
              child: const Text('Botón inútil (No hace nada)'),
            ),
          ],
        ),
      ),
    );
  }
}