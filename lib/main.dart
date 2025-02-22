import 'package:flutter/material.dart';
import 'package:my_daily_list/GestionTarea.dart';
import 'Tarea.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
      ),
      home: MyHomePage(title: 'My Daily List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //create the list here
  final GestionTarea _gestionTarea = GestionTarea([]);

  void _refreshTareas() {
    setState(() {}); // Rebuilds the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: tareas(gestionTarea: _gestionTarea, refreshTareas: _refreshTareas), // Pasar _refreshTareas
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NuevaPantalla(
                    gestionTarea: _gestionTarea,
                    onTareaAdded: _refreshTareas,
                  ),
            ),
          );
        },
        tooltip: 'añadir Tarea',
        child: const Icon(Icons.add),
      ),
    );
  }
}
Color obtenerColorPrioridad(Prioridad prioridad) {
  if (prioridad == Prioridad.alta) {
    return Colors.red;
  } else if (prioridad == Prioridad.media) {
    return Colors.orange;
  } else {
    return Colors.blue; // Prioridad baja
  }
}

Widget tareas({required GestionTarea gestionTarea, required VoidCallback refreshTareas}) {

  return ListView.builder(
    itemCount: gestionTarea.tareas.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 3),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto a la izquierda
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(text: 'Titulo: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${gestionTarea.tareas[index].titulo}\n'),
                  TextSpan(text: 'Descripcion: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${gestionTarea.tareas[index].descripcion}\n'),
                  TextSpan(text: 'Fecha limite: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${gestionTarea.tareas[index].fecha_limite.toString().split(' ')[0]}\n'),
                  TextSpan(text: 'Categoria: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${gestionTarea.tareas[index].categoria}\n'),
                  TextSpan(text: 'Prioridad: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '${gestionTarea.tareas[index].prioridad.toString().split('.').last.toUpperCase()}', style: TextStyle(color: obtenerColorPrioridad(gestionTarea.tareas[index].prioridad))),
                ],
              ),
            ),
            SizedBox(height: 8), // Espacio entre el texto y el botón
            TextButton(
              onPressed: () {
                gestionTarea.eliminar(gestionTarea.tareas[index].id);
                refreshTareas();
              },
              child: Text("Eliminar"),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        ),
      );
    },
  );
}

class NuevaPantalla extends StatefulWidget {
  final GestionTarea gestionTarea;
  final VoidCallback onTareaAdded; // esto lo que hace es que cuando se añada uan taraea lo refresque en el home

  const NuevaPantalla({
    super.key,
    required this.gestionTarea,
    required this.onTareaAdded,
  });

  @override
  _NuevaPantallaState createState() => _NuevaPantallaState();
}

class _NuevaPantallaState extends State<NuevaPantalla> {
  TextEditingController tituloController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Categoria _selectedCategoria = Categoria.personal;
  Prioridad _selectedPrioridad = Prioridad.media;

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
                  widget.gestionTarea.addTarea(nuevaTarea);
                  widget.onTareaAdded();
                  Navigator.pop(context);
                },
                child: const Text('Añadir Tarea'),
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