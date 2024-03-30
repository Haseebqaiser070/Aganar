import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PaymentsHystoryRecord extends FirestoreRecord {
  PaymentsHystoryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "sorteo" field.
  DocumentReference? _sorteo;
  DocumentReference? get sorteo => _sorteo;
  bool hasSorteo() => _sorteo != null;

  // "usuario" field.
  DocumentReference? _usuario;
  DocumentReference? get usuario => _usuario;
  bool hasUsuario() => _usuario != null;

  // "paymentID" field.
  String? _paymentID;
  String get paymentID => _paymentID ?? '';
  bool hasPaymentID() => _paymentID != null;

  // "fecha_pago" field.
  DateTime? _fechaPago;
  DateTime? get fechaPago => _fechaPago;
  bool hasFechaPago() => _fechaPago != null;

  void _initializeFields() {
    _sorteo = snapshotData['sorteo'] as DocumentReference?;
    _usuario = snapshotData['usuario'] as DocumentReference?;
    _paymentID = snapshotData['paymentID'] as String?;
    _fechaPago = snapshotData['fecha_pago'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('paymentsHystory');

  static Stream<PaymentsHystoryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PaymentsHystoryRecord.fromSnapshot(s));

  static Future<PaymentsHystoryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PaymentsHystoryRecord.fromSnapshot(s));

  static PaymentsHystoryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PaymentsHystoryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PaymentsHystoryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PaymentsHystoryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PaymentsHystoryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PaymentsHystoryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPaymentsHystoryRecordData({
  DocumentReference? sorteo,
  DocumentReference? usuario,
  String? paymentID,
  DateTime? fechaPago,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'sorteo': sorteo,
      'usuario': usuario,
      'paymentID': paymentID,
      'fecha_pago': fechaPago,
    }.withoutNulls,
  );

  return firestoreData;
}

class PaymentsHystoryRecordDocumentEquality
    implements Equality<PaymentsHystoryRecord> {
  const PaymentsHystoryRecordDocumentEquality();

  @override
  bool equals(PaymentsHystoryRecord? e1, PaymentsHystoryRecord? e2) {
    return e1?.sorteo == e2?.sorteo &&
        e1?.usuario == e2?.usuario &&
        e1?.paymentID == e2?.paymentID &&
        e1?.fechaPago == e2?.fechaPago;
  }

  @override
  int hash(PaymentsHystoryRecord? e) => const ListEquality()
      .hash([e?.sorteo, e?.usuario, e?.paymentID, e?.fechaPago]);

  @override
  bool isValidKey(Object? o) => o is PaymentsHystoryRecord;
}
