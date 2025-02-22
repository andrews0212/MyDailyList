
import 'package:my_daily_list/Tarea.dart';

class GestionTarea{
    List<Tarea> _tareas;

    GestionTarea(this._tareas);

    List<Tarea> get tareas => _tareas;


  set tareas(List<Tarea> value) {
      _tareas = value;
    }

    // metodos crud

    void addTarea(Tarea tarea){
      this._tareas.add(tarea);
    }
    List<Tarea> findAll(){
      return this._tareas;
    }
    Tarea? find(int id){
      for (Tarea element in tareas){
        if(element.id == id){
          return element;
        }
      }
      return null;
    }
    bool modificar(Tarea tarea, int id){
        for(Tarea element in tareas){
          if(element.id == id){
            element.titulo = tarea.titulo;
            element.descripcion = tarea.descripcion;
            element.fecha_limite = tarea.fecha_limite;
            element.categoria = tarea.categoria;
            element.prioridad = tarea.prioridad;
            return true;
          }
        }
        return false;
    }

    bool eliminar(int id){
      for(Tarea element in tareas){
        if(element.id == id){
          tareas.remove(element);
          return true;
        }
      }
      return false;
    }




}
