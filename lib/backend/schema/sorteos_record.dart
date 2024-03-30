import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SorteosRecord extends FirestoreRecord {
  SorteosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "nombre_sorteo" field.
  String? _nombreSorteo;
  String get nombreSorteo => _nombreSorteo ?? '';
  bool hasNombreSorteo() => _nombreSorteo != null;

  // "descripcion" field.
  String? _descripcion;
  String get descripcion => _descripcion ?? '';
  bool hasDescripcion() => _descripcion != null;

  // "limite_participantes" field.
  int? _limiteParticipantes;
  int get limiteParticipantes => _limiteParticipantes ?? 0;
  bool hasLimiteParticipantes() => _limiteParticipantes != null;

  // "estado_sorteo" field.
  bool? _estadoSorteo;
  bool get estadoSorteo => _estadoSorteo ?? false;
  bool hasEstadoSorteo() => _estadoSorteo != null;

  // "fecha_creacion" field.
  DateTime? _fechaCreacion;
  DateTime? get fechaCreacion => _fechaCreacion;
  bool hasFechaCreacion() => _fechaCreacion != null;

  // "fecha_sorteo" field.
  DateTime? _fechaSorteo;
  DateTime? get fechaSorteo => _fechaSorteo;
  bool hasFechaSorteo() => _fechaSorteo != null;

  // "ganador" field.
  DocumentReference? _ganador;
  DocumentReference? get ganador => _ganador;
  bool hasGanador() => _ganador != null;

  // "valor_sorteo" field.
  double? _valorSorteo;
  double get valorSorteo => _valorSorteo ?? 0.0;
  bool hasValorSorteo() => _valorSorteo != null;

  // "imagenRef" field.
  String? _imagenRef;
  String get imagenRef => _imagenRef ?? '';
  bool hasImagenRef() => _imagenRef != null;

  // "num_ganador" field.
  // int? _numGanador;
  // int get numGanador => _numGanador ?? 0;
  // bool hasNumGanador() => _numGanador != null;

  // "jugoSorteo" field.
  List<DocumentReference>? _jugoSorteo;
  List<DocumentReference> get jugoSorteo => _jugoSorteo ?? const [];
  bool hasJugoSorteo() => _jugoSorteo != null;

  // "selectedTickets" field.
  List<String>? _selectedTickets;
  List<String> get selectedTickets => _selectedTickets ?? const [];
  bool hasSelectedTickets() => _selectedTickets != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;


  // timer
  bool? _timer;
  bool get timer => _timer??false;
  bool hasTimer() => _timer !=null;

  // minute
  // String? _minute;
  // String get minute => _minute??"00";
  // bool hasMinute() => _minute !=null;


  // second
  // String? _second;
  // String get second => _second??"00";
  // bool hasSecond() => _second !=null;

  //timer start
  // DateTime? _timer_start;
  // DateTime get timer_start => _timer_start??DateTime.now();
  // bool hasTimerStart() => _timer_start !=null;



  //timer end
  DateTime? _timer_end;
  DateTime get timer_end => _timer_end??DateTime.now();
  bool hasTimerEnd() => _timer_end !=null;

  //Prize
  String? _prize;
  String get prize => _prize??"Cash";
  bool hasPrize() => _prize !=null;


  void _initializeFields() {
    _nombreSorteo = snapshotData['nombre_sorteo'] as String?;
    _descripcion = snapshotData['descripcion'] as String?;
    _limiteParticipantes =
        castToType<int>(snapshotData['limite_participantes']);
    _estadoSorteo = snapshotData['estado_sorteo'] as bool?;
    _fechaCreacion = snapshotData['fecha_creacion'] as DateTime?;
    _fechaSorteo = snapshotData['fecha_sorteo'] as DateTime?;
    _ganador = snapshotData['ganador'] as DocumentReference?;
    _valorSorteo = castToType<double>(snapshotData['valor_sorteo']);
    _imagenRef = snapshotData['imagenRef'] as String?;
    // _numGanador = castToType<int>(snapshotData['num_ganador']);
    _jugoSorteo = getDataList(snapshotData['jugoSorteo']);
    _selectedTickets = getDataList(snapshotData['selectedTickets']);
    _uid = snapshotData['uid'] as String?;
    _timer = snapshotData['timer'] as bool?;
    // _minute = snapshotData['minute'] as String?;
    // _second = snapshotData['second'] as String?;
    // _timer_start = snapshotData['timer_start'] as DateTime;
    _timer_end = snapshotData['timer_end'] as DateTime;
    _prize = snapshotData['prize'] as String;
    // _winnerSelected = snapshotData['winnerSelected'] as bool;

  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('sorteos');

  static Stream<SorteosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SorteosRecord.fromSnapshot(s));

  static Future<SorteosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SorteosRecord.fromSnapshot(s));

  static SorteosRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SorteosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SorteosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SorteosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SorteosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SorteosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSorteosRecordData({
  String? nombreSorteo,
  String? descripcion,
  int? limiteParticipantes,
  bool? estadoSorteo,
  DateTime? fechaCreacion,
  DateTime? fechaSorteo,
  DocumentReference? ganador,
  double? valorSorteo,
  String? imagenRef,
  // int? numGanador,
  String? uid,
  bool? timer,
  // String? minute,
  // String? second,
  // DateTime? timer_start,
  DateTime? timer_end,
  String? prize,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nombre_sorteo': nombreSorteo,
      'descripcion': descripcion,
      'limite_participantes': limiteParticipantes,
      'estado_sorteo': estadoSorteo,
      'fecha_creacion': fechaCreacion,
      'fecha_sorteo': fechaSorteo,
      'ganador': ganador,
      'valor_sorteo': valorSorteo,
      'imagenRef': imagenRef,
      // 'num_ganador': numGanador,
      'uid': uid,
      'timer': timer,
      // 'minute': minute??"00",
      // 'second': second??"00",
      // 'timer_start': timer_start??DateTime.now(),
      'timer_end': timer_end??DateTime.now(),
      'prize': prize??"Cash",


    }.withoutNulls,
  );

  return firestoreData;
}


Map<String, dynamic> createSorteoTimeData({
  String? minute,
  String? second,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'minute': minute,
      'second': second,
    }.withoutNulls,
  );

  return firestoreData;
}

class SorteosRecordDocumentEquality implements Equality<SorteosRecord> {
  const SorteosRecordDocumentEquality();

  @override
  bool equals(SorteosRecord? e1, SorteosRecord? e2) {
    const listEquality = ListEquality();
    return e1?.nombreSorteo == e2?.nombreSorteo &&
        e1?.descripcion == e2?.descripcion &&
        e1?.limiteParticipantes == e2?.limiteParticipantes &&
        e1?.estadoSorteo == e2?.estadoSorteo &&
        e1?.fechaCreacion == e2?.fechaCreacion &&
        e1?.fechaSorteo == e2?.fechaSorteo &&
        e1?.ganador == e2?.ganador &&
        e1?.valorSorteo == e2?.valorSorteo &&
        e1?.imagenRef == e2?.imagenRef &&
        // e1?.numGanador == e2?.numGanador &&
        listEquality.equals(e1?.jugoSorteo, e2?.jugoSorteo) &&
        listEquality.equals(e1?.selectedTickets, e2?.selectedTickets) &&
        e1?.uid == e2?.uid&&
        e1?.prize == e2?.prize;
  }

  @override
  int hash(SorteosRecord? e) => const ListEquality().hash([
        e?.nombreSorteo,
        e?.descripcion,
        e?.limiteParticipantes,
        e?.estadoSorteo,
        e?.fechaCreacion,
        e?.fechaSorteo,
        e?.ganador,
        e?.valorSorteo,
        e?.imagenRef,
        // e?.numGanador,
        e?.jugoSorteo,
        e?.selectedTickets,
        e?.uid,
        e?.prize
      ]);

  @override
  bool isValidKey(Object? o) => o is SorteosRecord;
}
