import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CancelarReserva extends StatelessWidget {
  const CancelarReserva({Key? key}) : super(key: key);
  Future<void> eliminarReserva(String reservaId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("reservas")
          .doc(reservaId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Reserva cancelada exitosamente")));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al cancelar la reserva: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Cancelar Reserva"), backgroundColor: Colors.blue),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("reservas").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error al cargar las reservas"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No hay reservas para cancelar"));
          }

          final reservas = snapshot.data!.docs;

          return ListView.builder(
            itemCount: reservas.length,
            itemBuilder: (context, index) {
              var reserva = reservas[index];
              String reservaId = reserva.id;

              final clienteId = reserva["cliente_id"] ?? "Desconocido";
              final vueloId = reserva["vuelo_id"] ?? "Desconocido";
              final estado = reserva["estado"] ?? "Sin Estado";

              return ListTile(
                title: Text("Cliente ID: $clienteId"),
                subtitle: Text("Vuelo ID: $vueloId"),
                trailing: Text("Estado: $estado"),
                onTap: () async {
                  bool? confirmar = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirmar cancelacion"),
                        content: const Text(
                            "¿Estás seguro de que quieres cancelar la reserva?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text("Sí"),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmar == true) {
                    eliminarReserva(reservaId, context);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
