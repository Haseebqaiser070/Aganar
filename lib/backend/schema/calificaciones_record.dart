import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CalificacionesRecord extends FirestoreRecord {
  CalificacionesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "calificacion_promedio" field.
  double? _calificacionPromedio;
  double get calificacionPromedio => _calificacionPromedio ?? 0.0;
  bool hasCalificacionPromedio() => _calificacionPromedio != null;

  // "numero_calificaciones" field.
  int? _numeroCalificaciones;
  int get numeroCalificaciones => _numeroCalificaciones ?? 0;
  bool hasNumeroCalificaciones() => _numeroCalificaciones != null;

  // "suma_calificaciones" field.
  double? _sumaCalificaciones;
  double get sumaCalificaciones => _sumaCalificaciones ?? 0.0;
  bool hasSumaCalificaciones() => _sumaCalificaciones != null;

  // "comentario" field.
  String? _comentario;
  String get comentario => _comentario ?? '';
  bool hasComentario() => _comentario != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "sorteo" field.
  DocumentReference? _sorteo;
  DocumentReference? get sorteo => _sorteo;
  bool hasSorteo() => _sorteo != null;

  void _initializeFields() {
    _calificacionPromedio =
        castToType<double>(snapshotData['calificacion_promedio']);
    _numeroCalificaciones =
        castToType<int>(snapshotData['numero_calificaciones']);
    _sumaCalificaciones =
        castToType<double>(snapshotData['suma_calificaciones']);
    _comentario = snapshotData['comentario'] as String?;
    _user = snapshotData['user'] as DocumentReference?;
    _sorteo = snapshotData['sorteo'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('calificaciones');

  static Stream<CalificacionesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CalificacionesRecord.fromSnapshot(s));

  static Future<CalificacionesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CalificacionesRecord.fromSnapshot(s));

  static CalificacionesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CalificacionesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CalificacionesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CalificacionesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CalificacionesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CalificacionesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCalificacionesRecordData({
  double? calificacionPromedio,
  int? numeroCalificaciones,
  double? sumaCalificaciones,
  String? comentario,
  DocumentReference? user,
  DocumentReference? sorteo,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'calificacion_promedio': calificacionPromedio,
      'numero_calificaciones': numeroCalificaciones,
      'suma_calificaciones': sumaCalificaciones,
      'comentario': comentario,
      'user': user,
      'sorteo': sorteo,
    }.withoutNulls,
  );

  return firestoreData;
}

class CalificacionesRecordDocumentEquality
    implements Equality<CalificacionesRecord> {
  const CalificacionesRecordDocumentEquality();

  @override
  bool equals(CalificacionesRecord? e1, CalificacionesRecord? e2) {
    return e1?.calificacionPromedio == e2?.calificacionPromedio &&
        e1?.numeroCalificaciones == e2?.numeroCalificaciones &&
        e1?.sumaCalificaciones == e2?.sumaCalificaciones &&
        e1?.comentario == e2?.comentario &&
        e1?.user == e2?.user &&
        e1?.sorteo == e2?.sorteo;
  }

  @override
  int hash(CalificacionesRecord? e) => const ListEquality().hash([
        e?.calificacionPromedio,
        e?.numeroCalificaciones,
        e?.sumaCalificaciones,
        e?.comentario,
        e?.user,
        e?.sorteo
      ]);

  @override
  bool isValidKey(Object? o) => o is CalificacionesRecord;
}
