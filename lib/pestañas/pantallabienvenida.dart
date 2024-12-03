import "package:flutter/material.dart";
import "p_inicio.dart";

class Bienvenida extends StatelessWidget {
  const Bienvenida({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenida"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                "https://static.vecteezy.com/system/resources/previews/000/620/261/non_2x/aircraft-airplane-airline-logo-label-journey-air-travel-airliner-symbol-vector-illustration.jpg"),
            const Text(
              "Bienvenido a Aerolínea Watin",
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const Text(
              "Te dejamos alla bien rapidin",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text("Empezar a viajar"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            ),
          ],
        ),
      ),
    );
  }
}
