
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'GestionTarea.dart';
import 'Tarea.dart';

class VentanaModificar extends StatefulWidget {
  final GestionTarea gestionTarea;
  final VoidCallback onTareaAdded;// esto lo que hace es que cuando se añada uan taraea lo refresque en el home
  final Tarea tarea;

  const VentanaModificar({
    super.key,
    required this.gestionTarea,
    required this.onTareaAdded,
    required this.tarea,
  });

  @override
  _NuevaPantallaState createState() => _NuevaPantallaState();
}

class _NuevaPantallaState extends State<VentanaModificar> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Categoria _selectedCategoria = Categoria.personal;
  Prioridad _selectedPrioridad = Prioridad.media;

  @override
  void initState() {
    tituloController.text = widget.tarea.titulo;
    descripcionController.text = widget.tarea.descripcion;
    _selectedDate = widget.tarea.fecha_limite;
    _selectedCategoria = widget.tarea.categoria;
    _selectedPrioridad = widget.tarea.prioridad;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nueva Tarea"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              dameTextField("Ingrese el título", tituloController),
              const SizedBox(height: 20),
              dameTextFieldArea(
                  "Ingrese la descripción", descripcionController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() => _selectedDate = picked);
                  }
                },
                child: Text(
                    "Seleccionar fecha: ${_selectedDate.toLocal()
                        .toString()
                        .split(' ')[0]}"),
              ),
              DropdownButton<Categoria>(
                value: _selectedCategoria,
                onChanged: (Categoria? newValue) {
                  setState(() {
                    _selectedCategoria = newValue!;
                  });
                },
                items: Categoria.values
                    .map<DropdownMenuItem<Categoria>>((Categoria value) {
                  return DropdownMenuItem<Categoria>(
                    value: value,
                    child: Text(value
                        .toString()
                        .split('.')
                        .last),
                  );
                }).toList(),
              ),
              DropdownButton<Prioridad>(
                value: _selectedPrioridad,
                onChanged: (Prioridad? newValue) {
                  setState(() {
                    _selectedPrioridad = newValue!;
                  });
                },
                items: Prioridad.values
                    .map<DropdownMenuItem<Prioridad>>((Prioridad value) {
                  return DropdownMenuItem<Prioridad>(
                    value: value,
                    child: Text(value
                        .toString()
                        .split('.')
                        .last),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Tarea nuevaTarea = Tarea(
                    tituloController.text,
                    descripcionController.text,
                    _selectedDate,
                    _selectedCategoria,
                    _selectedPrioridad,
                  );
                  widget.gestionTarea.modificar(nuevaTarea, widget.tarea.id);
                  widget.onTareaAdded();
                  Navigator.pop(context);
                },
                child: const Text('modificar Tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dameTextField(String cadena, TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: cadena,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10))));
  }

  Widget dameTextFieldArea(String cadena, TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: cadena,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10))),
        maxLines: 10);
  }
}
