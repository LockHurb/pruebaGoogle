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
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      navigatorObservers: [routeObserver],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TrackedScreen<MyHomePage> {
  @override
  String get screenName => 'Home Page';

  void _navigateToSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondPage()),
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
          mainAxisAlignment: .center,
          children: const [
            Text('Esta es la pantalla principal'),
            Text('Presiona el botón para ir a la segunda pantalla'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToSecondPage,
        tooltip: 'Ir a segunda pantalla',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
    with TrackedScreen<SecondPage> {
  @override
  String get screenName => 'Second Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Segunda Ventana'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('¡Estás en la segunda pantalla!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver atrás'),
            ),
          ],
        ),
      ),
    );
  }
}
