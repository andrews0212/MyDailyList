import 'dart:core';

enum Categoria { personal, trabajo, compras, estudio }

enum Prioridad { baja, media, alta }

class Tarea {

  final int? _id;
  String _titulo;
  String _descripcion;
  DateTime _fecha_limite;
  Categoria _categoria;
  Prioridad _prioridad;

  Tarea.withId(this._id, this._titulo, this._descripcion, this._fecha_limite,
      this._categoria, this._prioridad);

  int? get id => _id;

  String get titulo => _titulo;

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha_limite': fecha_limite.millisecondsSinceEpoch,
      'categoria': categoria.toString().split('.').last,
      'prioridad': prioridad.toString().split('.').last,
    };
  }

  factory Tarea.fromMap(Map<String, dynamic> map) {
    return Tarea.withId(
      map['id'],
      map['titulo'],
      map['descripcion'],
      DateTime.fromMillisecondsSinceEpoch(map['fecha_limite']),
      Categoria.values.firstWhere((e) => e.toString().split('.').last == map['categoria']),
      Prioridad.values.firstWhere((e) => e.toString().split('.').last == map['prioridad']),
    );
  }

  @override
  String toString() {
    return 'Tarea{_id: $_id, _titulo: $_titulo, _descripcion: $_descripcion, _fecha_limite: $_fecha_limite, _categoria: $_categoria, _prioridad: $_prioridad}';
  }
}