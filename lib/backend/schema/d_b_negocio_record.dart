import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DBNegocioRecord extends FirestoreRecord {
  DBNegocioRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "nombre_negocio" field.
  String? _nombreNegocio;
  String get nombreNegocio => _nombreNegocio ?? '';
  bool hasNombreNegocio() => _nombreNegocio != null;

  // "instagram_negocio" field.
  String? _instagramNegocio;
  String get instagramNegocio => _instagramNegocio ?? '';
  bool hasInstagramNegocio() => _instagramNegocio != null;

  // "whatsapp" field.
  String? _whatsapp;
  String get whatsapp => _whatsapp ?? '';
  bool haswhatsapp() => _whatsapp != null;

  // "facebook_negocio" field.
  String? _facebookNegocio;
  String get facebookNegocio => _facebookNegocio ?? '';
  bool hasFacebookNegocio() => _facebookNegocio != null;

  // "tel_negocio" field.
  String? _telNegocio;
  String get telNegocio => _telNegocio ?? '';
  bool hasTelNegocio() => _telNegocio != null;

  // "logo_negocio" field.
  String? _logoNegocio;
  String get logoNegocio => _logoNegocio ?? '';
  bool hasLogoNegocio() => _logoNegocio != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  void _initializeFields() {
    _nombreNegocio = snapshotData['nombre_negocio'] as String?;
    _instagramNegocio = snapshotData['instagram_negocio'] as String?;
    _whatsapp = snapshotData['whatsapp'] as String?;
    _facebookNegocio = snapshotData['facebook_negocio'] as String?;
    _telNegocio = snapshotData['tel_negocio'] as String?;
    _logoNegocio = snapshotData['logo_negocio'] as String?;
    _rating = castToType<double>(snapshotData['rating']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('DB_negocio');

  static Stream<DBNegocioRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DBNegocioRecord.fromSnapshot(s));

  static Future<DBNegocioRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DBNegocioRecord.fromSnapshot(s));

  static DBNegocioRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DBNegocioRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DBNegocioRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DBNegocioRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DBNegocioRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DBNegocioRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDBNegocioRecordData({
  String? nombreNegocio,
  String? instagramNegocio,
  String? facebookNegocio,
  String? telNegocio,
  String? logoNegocio,
  double? rating,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nombre_negocio': nombreNegocio,
      'instagram_negocio': instagramNegocio,
      'facebook_negocio': facebookNegocio,
      'tel_negocio': telNegocio,
      'logo_negocio': logoNegocio,
      'rating': rating,
    }.withoutNulls,
  );

  return firestoreData;
}

class DBNegocioRecordDocumentEquality implements Equality<DBNegocioRecord> {
  const DBNegocioRecordDocumentEquality();

  @override
  bool equals(DBNegocioRecord? e1, DBNegocioRecord? e2) {
    return e1?.nombreNegocio == e2?.nombreNegocio &&
        e1?.instagramNegocio == e2?.instagramNegocio &&
        e1?.whatsapp == e2?.whatsapp &&
        e1?.facebookNegocio == e2?.facebookNegocio &&
        e1?.telNegocio == e2?.telNegocio &&
        e1?.logoNegocio == e2?.logoNegocio &&
        e1?.rating == e2?.rating;
  }

  @override
  int hash(DBNegocioRecord? e) => const ListEquality().hash([
        e?.nombreNegocio,
        e?.instagramNegocio,
        e?.whatsapp,
        e?.facebookNegocio,
        e?.telNegocio,
        e?.logoNegocio,
        e?.rating
      ]);

  @override
  bool isValidKey(Object? o) => o is DBNegocioRecord;
}
