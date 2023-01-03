import 'package:rxdart/rxdart.dart';

/// Un almacén en memoria respaldado por BehaviorSubject que se puede utilizar para
/// almacenar los datos de todos los repositorios falsos de la aplicación.
class InMemoryStoret<T> {
  InMemoryStoret(T initial) : _subject = BehaviorSubject<T>.seeded(initial);

  /// El BehaviorSubject que contiene los datos
  final BehaviorSubject<T> _subject;

  /// El flujo de salida que se puede usar para escuchar los datos
  Stream<T> get stream => _subject.stream;

  /// Un getter síncrono para el valor actual
  T get value => _subject.value;

  /// Un setter para actualizar el valor
  set value(T value) => _subject.add(value);
  void close() => _subject.close();
}
