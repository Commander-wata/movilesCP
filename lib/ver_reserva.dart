import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class VerReservas extends StatelessWidget {
  const VerReservas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Ver Reservas"), backgroundColor: Colors.blue),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("reservas").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error al cargar"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No hay reservas"));
          }

          final reservas = snapshot.data!.docs;

          return ListView.builder(
            itemCount: reservas.length,
            itemBuilder: (context, index) {
              var reserva = reservas[index];
              if (reserva.data() == null) {
                return const ListTile(
                  title: Text("Reserva no válida"),
                  subtitle: Text("El documento no tiene datos"),
                );
              }
              final Map<String, dynamic>? reservaData =
                  reserva.data() as Map<String, dynamic>?;
              if (reservaData == null) {
                return const ListTile(
                  title: Text("Reserva no valida"),
                  subtitle: Text("Estructura de datos desconocida"),
                );
              }
              final clienteId = reservaData["cliente_id"] ?? "Desconocido";
              final vueloId = reservaData["vuelo_id"] ?? "Desconocido";
              final estado = reservaData["estado"] ?? "Sin Estado";
              return ListTile(
                title: Text("Cliente ID: $clienteId"),
                subtitle: Text("Vuelo ID: $vueloId"),
                trailing: Text("Estado: $estado"),
              );
            },
          );
        },
      ),
    );
  }
}
