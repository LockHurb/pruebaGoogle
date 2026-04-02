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

  void _showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Bienvenido!'),
          content: const Text('Este es un diálogo exclusivo de la página principal.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
    AnalyticsService.logEvent(name: 'show_welcome_dialog');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return Center(
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: isWide
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bienvenido a la página principal', style: Theme.of(context).textTheme.titleLarge),
                                const SizedBox(height: 24),
                                Text('Contador:', style: Theme.of(context).textTheme.titleMedium),
                                Text('$_counter', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.deepPurple)),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: () {
                                    AnalyticsService.logEvent(
                                      name: 'click_increment_counter',
                                      params: {'counter_value': _counter + 1, 'page': 'principal'},
                                    );
                                    _incrementCounter();
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade700, foregroundColor: Colors.black),
                                  child: const Text('Incrementar contador'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              alignment: WrapAlignment.center,
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
                                ElevatedButton(
                                  onPressed: () {
                                    AnalyticsService.logEvent(
                                      name: 'click_welcome_dialog',
                                      params: {'page': 'principal'},
                                    );
                                    _showWelcomeDialog();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal.shade600,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 2,
                                  ),
                                  child: const Text('Mostrar diálogo de bienvenida', style: TextStyle(fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Bienvenido a la página principal', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 24),
                          Text('Contador:', style: Theme.of(context).textTheme.titleMedium),
                          Text('$_counter', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.deepPurple)),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              AnalyticsService.logEvent(
                                name: 'click_increment_counter',
                                params: {'counter_value': _counter + 1, 'page': 'principal'},
                              );
                              _incrementCounter();
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade700, foregroundColor: Colors.black),
                            child: const Text('Incrementar contador'),
                          ),
                          const SizedBox(height: 32),
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.center,
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
                              ElevatedButton(
                                onPressed: () {
                                  AnalyticsService.logEvent(
                                    name: 'click_welcome_dialog',
                                    params: {'page': 'principal'},
                                  );
                                  _showWelcomeDialog();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal.shade600,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 2,
                                ),
                                child: const Text('Mostrar diálogo de bienvenida', style: TextStyle(fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
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

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Información'),
          content: const Text('Esta es información adicional exclusiva de la segunda página.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
    AnalyticsService.logEvent(name: 'show_info_dialog_second_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('2da Página imagen'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return Center(
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: isWide
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.network(imageUrl, height: 200),
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    AnalyticsService.logEvent(
                                      name: 'click_enlarge_image_button',
                                      params: {'page': 'segunda'},
                                    );
                                    _showImageDialog();
                                  },
                                  child: const Text('Agrandar imagen'),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    AnalyticsService.logEvent(
                                      name: 'click_info_dialog_button',
                                      params: {'page': 'segunda'},
                                    );
                                    _showInfoDialog();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo.shade700,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 2,
                                  ),
                                  child: const Text('Mostrar información extra', style: TextStyle(fontWeight: FontWeight.w600)),
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    AnalyticsService.logEvent(
                                      name: 'click_nav_button',
                                      params: {'destination': 'Página principal'},
                                    );
                                    context.go('/');
                                  },
                                  child: const Text('Volver a Página principal'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(imageUrl, height: 150),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              AnalyticsService.logEvent(
                                name: 'click_enlarge_image_button',
                                params: {'page': 'segunda'},
                              );
                              _showImageDialog();
                            },
                            child: const Text('Agrandar imagen'),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              AnalyticsService.logEvent(
                                name: 'click_info_dialog_button',
                                params: {'page': 'segunda'},
                              );
                              _showInfoDialog();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo.shade700,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 2,
                            ),
                            child: const Text('Mostrar información extra', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              AnalyticsService.logEvent(
                                name: 'click_nav_button',
                                params: {'destination': 'Página principal'},
                              );
                              context.go('/');
                            },
                            child: const Text('Volver a Página principal'),
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
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
  Color _backgroundColor = const Color(0xFFF5F6FA);

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = _backgroundColor == const Color(0xFFF5F6FA)
          ? const Color(0xFFE3E0F3)
          : const Color(0xFFF5F6FA);
    });
    AnalyticsService.logEvent(name: 'change_background_color_third_page');
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Este es un SnackBar exclusivo de la 3ra página!')),
    );
    AnalyticsService.logEvent(name: 'show_snackbar_third_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('3ra Página botones'),
      ),
      body: Container(
        color: _backgroundColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            return Center(
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: isWide
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      AnalyticsService.logEvent(
                                        name: 'click_nav_button',
                                        params: {'destination': 'Página principal'},
                                      );
                                      context.go('/');
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
                            const SizedBox(width: 48),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      AnalyticsService.logEvent(
                                        name: 'click_change_background_color',
                                        params: {'page': 'tercera'},
                                      );
                                      _changeBackgroundColor();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple.shade400,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      elevation: 2,
                                    ),
                                    child: const Text('Cambiar color de fondo', style: TextStyle(fontWeight: FontWeight.w600)),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      AnalyticsService.logEvent(
                                        name: 'click_show_snackbar',
                                        params: {'page': 'tercera'},
                                      );
                                      _showSnackBar();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange.shade700,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      elevation: 2,
                                    ),
                                    child: const Text('Mostrar SnackBar', style: TextStyle(fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          alignment: WrapAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                AnalyticsService.logEvent(
                                  name: 'click_nav_button',
                                  params: {'destination': 'Página principal'},
                                );
                                context.go('/');
                              },
                              child: const Text('Volver a Página principal'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                AnalyticsService.logEvent(name: 'click_useless_button');
                              },
                              child: const Text('Botón inútil (No hace nada)'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                AnalyticsService.logEvent(
                                  name: 'click_change_background_color',
                                  params: {'page': 'tercera'},
                                );
                                _changeBackgroundColor();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple.shade400,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 2,
                              ),
                              child: const Text('Cambiar color de fondo', style: TextStyle(fontWeight: FontWeight.w600)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                AnalyticsService.logEvent(
                                  name: 'click_show_snackbar',
                                  params: {'page': 'tercera'},
                                );
                                _showSnackBar();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade700,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 2,
                              ),
                              child: const Text('Mostrar SnackBar', style: TextStyle(fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}