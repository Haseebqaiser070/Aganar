import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SelectedTicketsRecord extends FirestoreRecord {
  SelectedTicketsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "imagen" field.
  String? _imagen;
  String get imagen => _imagen ?? "";
  bool hasImagen() => _imagen != null;

  // "usuario" field.
  DocumentReference? _usuario;
  DocumentReference? get usuario => _usuario;
  bool hasUsuario() => _usuario != null;

  // "idBoleto" field.
  int? _idBoleto;
  int get idBoleto => _idBoleto ?? 0;
  bool hasIdBoleto() => _idBoleto != null;

  // "numTicket" field.
  int? _numTicket;
  int get numTicket => _numTicket ?? 0;
  bool hasNumTicket() => _numTicket != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _imagen = snapshotData['imagen'] as String?;
    _usuario = snapshotData['usuario'] as DocumentReference?;
    _idBoleto = castToType<int>(snapshotData['idBoleto']);
    _numTicket = castToType<int>(snapshotData['numTicket']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('selectedTickets')
          : FirebaseFirestore.instance.collectionGroup('selectedTickets');

  static DocumentReference createDoc(DocumentReference parent) =>
      parent.collection('selectedTickets').doc();

  static Stream<SelectedTicketsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SelectedTicketsRecord.fromSnapshot(s));

  static Future<SelectedTicketsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SelectedTicketsRecord.fromSnapshot(s));

  static SelectedTicketsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SelectedTicketsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SelectedTicketsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SelectedTicketsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SelectedTicketsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SelectedTicketsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSelectedTicketsRecordData({
  String? imagen,
  DocumentReference? usuario,
  int? idBoleto,
  int? numTicket,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'imagen': imagen,
      'usuario': usuario,
      'idBoleto': idBoleto,
      'numTicket': numTicket,
    }.withoutNulls,
  );

  return firestoreData;
}

class SelectedTicketsRecordDocumentEquality
    implements Equality<SelectedTicketsRecord> {
  const SelectedTicketsRecordDocumentEquality();

  @override
  bool equals(SelectedTicketsRecord? e1, SelectedTicketsRecord? e2) {
    return e1?.imagen == e2?.imagen &&
        e1?.usuario == e2?.usuario &&
        e1?.idBoleto == e2?.idBoleto &&
        e1?.numTicket == e2?.numTicket;
  }

  @override
  int hash(SelectedTicketsRecord? e) => const ListEquality()
      .hash([e?.imagen, e?.usuario, e?.idBoleto, e?.numTicket]);

  @override
  bool isValidKey(Object? o) => o is SelectedTicketsRecord;
}
