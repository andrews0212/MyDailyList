enum Categoria { personal, trabajo, compras, estudio }

enum Prioridad { baja, media, alta }
class Tarea{
  static int _contador = 1;
  final int _id;
  String _titulo;
  String _descripcion;
  DateTime _fecha_limite;
  Categoria _categoria;
  Prioridad _prioridad;

  Tarea(this._titulo, this._descripcion, this._fecha_limite, this._categoria, this._prioridad)
   : _id = _contador++ {
  }


  int get id => _id;

  String get titulo {
    return _titulo;
  }

  set titulo(String value) {
    _titulo = value;
  }


  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  DateTime get fecha_limite => _fecha_limite;

  set fecha_limite(DateTime value) {
    _fecha_limite = value;
  }

  Categoria get categoria => _categoria;

  set categoria(Categoria value) {
    _categoria = value;
  }

  Prioridad get prioridad => _prioridad;

  set prioridad(Prioridad value) {
    _prioridad = value;
  }

  @override
  String toString() {
    return 'Tarea{_id: $_id, _titulo: $_titulo, _descripcion: $_descripcion, _fecha_limite: $_fecha_limite, _categoria: $_categoria, _prioridad: $_prioridad}';
  }

}


