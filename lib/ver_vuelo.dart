import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerVuelos extends StatelessWidget {
  const VerVuelos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Ver vuelos"), backgroundColor: Colors.blue),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("vuelos").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error al cargar"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No hay vuelos"));
          }

          final vuelos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: vuelos.length,
            itemBuilder: (context, index) {
              var vuelo = vuelos[index];

              final vueloData = vuelo.data();
              if (vueloData == null) {
                return const ListTile(
                  title: Text("Vuelo no valido"),
                  subtitle: Text("El documento no tiene datos"),
                );
              }

              final Map<String, dynamic>? vueloDataMap =
                  vueloData as Map<String, dynamic>?;

              if (vueloDataMap == null) {
                return const ListTile(
                  title: Text("Vuelo no válido"),
                  subtitle: Text("Estructura de datos desconocida."),
                );
              }

              final nombre = vueloDataMap["nombre"] ?? "Desconocido";
              final origen = vueloDataMap["origen"] ?? "Desconocido";
              final destino = vueloDataMap["destino"] ?? "Desconocido";
              final fecha = vueloDataMap["fecha"]?.toDate() ?? DateTime.now();

              return ListTile(
                title: Text("Nombre: $nombre"),
                subtitle: Text("Origen: $origen - Destino: $destino"),
                trailing: Text("Fecha: ${fecha.toLocal()}"),
              );
            },
          );
        },
      ),
    );
  }
}
