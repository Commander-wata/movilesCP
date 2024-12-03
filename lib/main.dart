import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "firebase_options.dart";
import "pestañas/pantallabienvenida.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Aerolinea_app());
}

class Aerolinea_app extends StatelessWidget {
  const Aerolinea_app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aerolinea Watin",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Bienvenida(),
    );
  }
}
