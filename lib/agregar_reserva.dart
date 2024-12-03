import "package:flutter/material.dart";
import "firebase/firestore_service.dart";

class AgregarReserva extends StatefulWidget {
  const AgregarReserva({Key? key}) : super(key: key);

  @override
  _AgregarReservaState createState() => _AgregarReservaState();
}

class _AgregarReservaState extends State<AgregarReserva> {
  final _vueloIdController = TextEditingController();
  final _clienteIdController = TextEditingController();
  final _asientosController = TextEditingController();
  DateTime? _fechaReserva;

  void _agregarReserva() {
    if (_vueloIdController.text.isNotEmpty &&
        _clienteIdController.text.isNotEmpty &&
        _asientosController.text.isNotEmpty &&
        _fechaReserva != null) {
      FirestoreService().agregarReserva(
        _vueloIdController.text,
        _clienteIdController.text,
        int.parse(_asientosController.text),
        _fechaReserva!,
        "confirmada",
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Reserva agregada con exito")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Por favor complete todos los campos que se le piden")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Agregar Reserva"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _vueloIdController,
              decoration: const InputDecoration(labelText: "ID del vuelo"),
            ),
            TextField(
              controller: _clienteIdController,
              decoration: const InputDecoration(labelText: "ID del cliente"),
            ),
            TextField(
              controller: _asientosController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: "Numero de Asientos"),
            ),
            ListTile(
              title: Text(
                _fechaReserva == null
                    ? "Selecciona una fecha"
                    : _fechaReserva!.toLocal().toString(),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != _fechaReserva) {
                  setState(() {
                    _fechaReserva = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarReserva,
              child: const Text("Agregar Reserva"),
            ),
          ],
        ),
      ),
    );
  }
}
