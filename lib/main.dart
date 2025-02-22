import 'package:flutter/material.dart';
import 'package:my_daily_list/GestionTarea.dart';
import 'NuevaVentana.dart';
import 'Tarea.dart';
import 'VentanaModificar.dart';


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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [  // Espacio entre el texto y el botón
           IconButton(onPressed: (){
              gestionTarea.eliminar(gestionTarea.tareas[index].id);
            refreshTareas();
            }, icon: const Icon(Icons.delete), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.red)),),

            IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VentanaModificar(
                        gestionTarea: gestionTarea,
                        onTareaAdded: refreshTareas,
                        tarea: gestionTarea.tareas[index],
                      ),
              )
              );
            }, icon: const Icon(Icons.edit),)
      ,],)
          ],

        ),
      );
    },
  );
}
