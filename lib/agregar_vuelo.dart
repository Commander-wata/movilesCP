import 'package:flutter/material.dart';
import 'firebase/firestore_service.dart';

class AgregarVuelo extends StatefulWidget {
  const AgregarVuelo({Key? key}) : super(key: key);

  @override
  _AgregarVueloState createState() => _AgregarVueloState();
}

class _AgregarVueloState extends State<AgregarVuelo> {
  final _nombreController = TextEditingController();
  final _origenController = TextEditingController();
  final _destinoController = TextEditingController();
  final _duracionController = TextEditingController();
  DateTime? _fecha;

  void _agregarVuelo() {
    if (_nombreController.text.isNotEmpty &&
        _origenController.text.isNotEmpty &&
        _destinoController.text.isNotEmpty &&
        _duracionController.text.isNotEmpty &&
        _fecha != null) {
      FirestoreService().agregarVuelo(
        _nombreController.text,
        _origenController.text,
        _destinoController.text,
        _fecha!,
        int.parse(_duracionController.text),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vuelo agregado")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor complete todos los campos")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Agregar vuelo"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: "Nombre del vuelo"),
            ),
            TextField(
              controller: _origenController,
              decoration: const InputDecoration(labelText: "Origen"),
            ),
            TextField(
              controller: _destinoController,
              decoration: const InputDecoration(labelText: "Destino"),
            ),
            TextField(
              controller: _duracionController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: "Duracion (minutos)"),
            ),
            ListTile(
              title: Text(_fecha == null
                  ? "Selecciona una fecha"
                  : _fecha!.toLocal().toString()),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != _fecha) {
                  setState(() {
                    _fecha = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _agregarVuelo,
              child: const Text("Agregar vuelo"),
            ),
          ],
        ),
      ),
    );
  }
}
