import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Future<void> agregarVuelo(String nombre, String origen, String destino,
      DateTime fecha, int duracion) async {
    CollectionReference vuelos =
        FirebaseFirestore.instance.collection("vuelos");
    await vuelos.add({
      "nombre": nombre,
      "origen": origen,
      "destino": destino,
      "fecha": fecha,
      "duracion": duracion,
    }).then((value) {
      print("Vuelo agregado con id: ${value.id}");
    }).catchError((error) {
      print("Error al agregar vuelo: $error");
    });
  }

  Future<void> agregarReserva(String vueloId, String clienteId, int asientos,
      DateTime fechaReserva, String estado) async {
    CollectionReference reservas =
        FirebaseFirestore.instance.collection("reservas");
    await reservas.add({
      "vuelo_id": vueloId,
      "cliente_id": clienteId,
      "asientos": asientos,
      "fecha_reserva": fechaReserva,
      "estado": estado,
    }).then((value) {
      print("Reserva agregada con id: ${value.id}");
    }).catchError((error) {
      print("Error al agregar reserva: $error");
    });
  }
}
