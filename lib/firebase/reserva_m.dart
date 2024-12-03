import 'package:cloud_firestore/cloud_firestore.dart';

class Reserva {
  final String vueloId;
  final String clienteId;
  final int asientos;
  final DateTime fechaReserva;
  final String estado;

  Reserva({
    required this.vueloId,
    required this.clienteId,
    required this.asientos,
    required this.fechaReserva,
    required this.estado,
  });

  Map<String, dynamic> toMap() {
    return {
      "vuelo_id": vueloId,
      "cliente_id": clienteId,
      "asientos": asientos,
      "fecha_reserva": fechaReserva,
      "estado": estado,
    };
  }

  factory Reserva.fromMap(Map<String, dynamic> map) {
    return Reserva(
      vueloId: map["vuelo_id"],
      clienteId: map["cliente_id"],
      asientos: map["asientos"],
      fechaReserva: (map["fecha_reserva"] as Timestamp).toDate(),
      estado: map["estado"],
    );
  }
}
