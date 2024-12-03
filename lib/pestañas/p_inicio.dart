import "package:flutter/material.dart";
import "package:prueba_aerolinea/agregar_vuelo.dart";
import "package:prueba_aerolinea/agregar_reserva.dart";
import "package:prueba_aerolinea/cancelar_reserva.dart";
import "package:prueba_aerolinea/ver_vuelo.dart";
import "package:prueba_aerolinea/ver_reserva.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pagina de inicio",
        ),
        backgroundColor: Colors.blue,
      ),
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        children: [
          CardWidget(
            title: "Agregar Reserva",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AgregarReserva()),
              );
            },
          ),
          CardWidget(
            title: "Agregar Vuelo",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AgregarVuelo()),
              );
            },
          ),
          CardWidget(
            title: 'Ver Reservas',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VerReservas()),
              );
            },
          ),
          CardWidget(
            title: "Ver Vuelos",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VerVuelos()),
              );
            },
          ),
          CardWidget(
            title: "Cancelar Reserva",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CancelarReserva()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CardWidget({required this.title, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Center(
          child: Text(title, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
