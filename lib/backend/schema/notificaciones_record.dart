import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificacionesRecord extends FirestoreRecord {
  NotificacionesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "contenido" field.
  String? _contenido;
  String get contenido => _contenido ?? '';
  bool hasContenido() => _contenido != null;

  // "eliminado_por" field.
  List<DocumentReference>? _eliminadoPor;
  List<DocumentReference> get eliminadoPor => _eliminadoPor ?? const [];
  bool hasEliminadoPor() => _eliminadoPor != null;

  // "leido" field.
  bool? _leido;
  bool get leido => _leido ?? false;
  bool hasLeido() => _leido != null;

  // "titulo" field.
  String? _titulo;
  String get titulo => _titulo ?? '';
  bool hasTitulo() => _titulo != null;

  // "especific_user" field.
  DocumentReference? _especificUser;
  DocumentReference? get especificUser => _especificUser;
  bool hasEspecificUser() => _especificUser != null;

  // "created_date" field.
  DateTime? _createdDate;
  DateTime? get createdDate => _createdDate;
  bool hasCreatedDate() => _createdDate != null;

  // "readingByUser" field.
  List<DocumentReference>? _readingByUser;
  List<DocumentReference> get readingByUser => _readingByUser ?? const [];
  bool hasReadingByUser() => _readingByUser != null;

  // "notifiedUsersList" field.
  List<DocumentReference>? _notifiedUsersList;
  List<DocumentReference> get notifiedUsersList =>
      _notifiedUsersList ?? const [];
  bool hasNotifiedUsersList() => _notifiedUsersList != null;

  // "isCashPayment" field.
  bool? _isCashPayment;
  bool get isCashPayment => _isCashPayment ?? false;
  bool hasIsCashPayment() => _isCashPayment != null;

  // "requiredParameter" field.
  DocumentReference? _requiredParameter;
  DocumentReference? get requiredParameter => _requiredParameter;
  bool hasRequiredParameter() => _requiredParameter != null;

  void _initializeFields() {
    _contenido = snapshotData['contenido'] as String?;
    _eliminadoPor = getDataList(snapshotData['eliminado_por']);
    _leido = snapshotData['leido'] as bool?;
    _titulo = snapshotData['titulo'] as String?;
    _especificUser = snapshotData['especific_user'] as DocumentReference?;
    _createdDate = snapshotData['created_date'] as DateTime?;
    _readingByUser = getDataList(snapshotData['readingByUser']);
    _notifiedUsersList = getDataList(snapshotData['notifiedUsersList']);
    _isCashPayment = snapshotData['isCashPayment'] as bool?;
    _requiredParameter =
        snapshotData['requiredParameter'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notificaciones');

  static Stream<NotificacionesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotificacionesRecord.fromSnapshot(s));

  static Future<NotificacionesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotificacionesRecord.fromSnapshot(s));

  static NotificacionesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      NotificacionesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotificacionesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotificacionesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotificacionesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotificacionesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotificacionesRecordData({
  String? contenido,
  bool? leido,
  String? titulo,
  DocumentReference? especificUser,
  DateTime? createdDate,
  bool? isCashPayment,
  DocumentReference? requiredParameter,
}) {
  print("createNotif++");
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'contenido': contenido,
      'leido': leido,
      'titulo': titulo,
      'especific_user': especificUser,
      'created_date': createdDate,
      'isCashPayment': isCashPayment,
      'requiredParameter': requiredParameter,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotificacionesRecordDocumentEquality
    implements Equality<NotificacionesRecord> {
  const NotificacionesRecordDocumentEquality();

  @override
  bool equals(NotificacionesRecord? e1, NotificacionesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.contenido == e2?.contenido &&
        listEquality.equals(e1?.eliminadoPor, e2?.eliminadoPor) &&
        e1?.leido == e2?.leido &&
        e1?.titulo == e2?.titulo &&
        e1?.especificUser == e2?.especificUser &&
        e1?.createdDate == e2?.createdDate &&
        listEquality.equals(e1?.readingByUser, e2?.readingByUser) &&
        listEquality.equals(e1?.notifiedUsersList, e2?.notifiedUsersList) &&
        e1?.isCashPayment == e2?.isCashPayment &&
        e1?.requiredParameter == e2?.requiredParameter;
  }

  @override
  int hash(NotificacionesRecord? e) => const ListEquality().hash([
        e?.contenido,
        e?.eliminadoPor,
        e?.leido,
        e?.titulo,
        e?.especificUser,
        e?.createdDate,
        e?.readingByUser,
        e?.notifiedUsersList,
        e?.isCashPayment,
        e?.requiredParameter
      ]);

  @override
  bool isValidKey(Object? o) => o is NotificacionesRecord;
}
