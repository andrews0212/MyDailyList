import 'dart:developer';
import 'package:my_daily_list/BaseDato_Helper.dart';
import 'package:my_daily_list/Tarea.dart';

class GestionTarea {
  BaseDato_Helper baseDato_Helper;

  GestionTarea(this.baseDato_Helper);

  void addTarea(Tarea tarea) {
    this.baseDato_Helper.add(tarea.toMap());
  }

  Future<List<Tarea>> findAll() async {
    List<Map<String, dynamic>> maps = await baseDato_Helper.findAll();
    return maps.map((map) => Tarea.fromMap(map)).toList();
  }

  Future<Tarea?> find(int id) async {
    List<Tarea> tareas = await findAll();
    try {
      return tareas.firstWhere((tarea) => tarea.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<bool> modificar(Tarea tarea, int id) async {
    Map<String, dynamic> tareaMap = tarea.toMap();
    tareaMap['id'] = id;
    log(tareaMap.toString());
    var update = await baseDato_Helper.update(tareaMap);
    return update == 1;
  }

  bool eliminar(int id) {
    var delete = baseDato_Helper.delete(id);
    return delete == 1;
  }
}