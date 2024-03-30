import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "online" field.
  bool? _online;
  bool get online => _online ?? false;
  bool hasOnline() => _online != null;

  // "online" field.
  DateTime? _lastseen;
  DateTime get lastseen => _lastseen ?? DateTime(2023,1,1,12,0,1,30,0);
  bool hasLastSeen() => _lastseen != null;

  // "lat" field.
  num? _lat;
  num get lat => _lat ?? 37.4219983;
  bool hasLat() => _lat != null;

  // "lat" field.
  num? _long;
  num get long => _long ?? -122.084;
  bool hasLong() => _long != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;



  // "level" field.
  int? _level;
  int get level => _level ?? 0;
  bool hasLevel() => _level != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "mis_sorteos" field.
  List<DocumentReference>? _misSorteos;
  List<DocumentReference> get misSorteos => _misSorteos ?? const [];
  bool hasMisSorteos() => _misSorteos != null;

  // "isAdmin" field.
  bool? _isAdmin;
  bool get isAdmin => _isAdmin ?? false;
  bool hasIsAdmin() => _isAdmin != null;

  // "puntos" field.
  int? _puntos;
  int get puntos => _puntos ?? 0;
  bool hasPuntos() => _puntos != null;

  // "activo" field.
  bool? _activo;
  bool get activo => _activo ?? false;
  bool hasActivo() => _activo != null;

  // "completeProfile" field.
  bool? _completeProfile;
  bool get completeProfile => _completeProfile ?? false;
  bool hasCompleteProfile() => _completeProfile != null;

  // "inactiveByAdmin" field.
  bool? _inactiveByAdmin;
  bool get inactiveByAdmin => _inactiveByAdmin ?? false;
  bool hasInactiveByAdmin() => _inactiveByAdmin != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _misSorteos = getDataList(snapshotData['mis_sorteos']);
    _isAdmin = snapshotData['isAdmin'] as bool?;
    _puntos = castToType<int>(snapshotData['puntos']);
    _activo = snapshotData['activo'] as bool?;
    _completeProfile = snapshotData['completeProfile'] as bool?;
    _inactiveByAdmin = snapshotData['inactiveByAdmin'] as bool?;
    _online = snapshotData['online'] as bool?;
    _lastseen = snapshotData['lastseen'] as DateTime?;
    _lat = snapshotData['lat'] as num?;
    _long = snapshotData['long'] as num?;
    _level = snapshotData['level'] as int?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  bool? isAdmin,
  int? puntos,
  bool? activo,
  bool? completeProfile,
  bool? inactiveByAdmin,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'isAdmin': isAdmin,
      'puntos': puntos,
      'activo': activo,
      'completeProfile': completeProfile,
      'inactiveByAdmin': inactiveByAdmin,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        listEquality.equals(e1?.misSorteos, e2?.misSorteos) &&
        e1?.isAdmin == e2?.isAdmin &&
        e1?.puntos == e2?.puntos &&
        e1?.activo == e2?.activo &&
        e1?.completeProfile == e2?.completeProfile &&
        e1?.inactiveByAdmin == e2?.inactiveByAdmin &&
        e1?.online == e2?.online&&
        e1?.lastseen == e2?.lastseen&&
        e1?.lat == e2?.lat&&
        e1?.level == e2?.level&&
        e1?.long == e2?.long;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.misSorteos,
        e?.isAdmin,
        e?.puntos,
        e?.activo,
        e?.completeProfile,
        e?.inactiveByAdmin,
        e?.online,
        e?.lastseen,
        e?.lat,
        e?.level,
        e?.long
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
