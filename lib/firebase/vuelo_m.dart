import 'package:cloud_firestore/cloud_firestore.dart';

class Vuelo {
  final String nombre;
  final String origen;
  final String destino;
  final DateTime fecha;
  final int duracion;

  Vuelo({
    required this.nombre,
    required this.origen,
    required this.destino,
    required this.fecha,
    required this.duracion,
  });

  Map<String, dynamic> toMap() {
    return {
      "nombre": nombre,
      "origen": origen,
      "destino": destino,
      "fecha": fecha,
      "duracion": duracion,
    };
  }

  factory Vuelo.fromMap(Map<String, dynamic> map) {
    return Vuelo(
      nombre: map["nombre"],
      origen: map["origen"],
      destino: map["destino"],
      fecha: (map["fecha"] as Timestamp).toDate(),
      duracion: map["duracion"],
    );
  }
}
