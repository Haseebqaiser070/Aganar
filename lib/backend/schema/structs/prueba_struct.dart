// ignore_for_file: unnecessary_getters_setters
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PruebaStruct extends FFFirebaseStruct {
  PruebaStruct({
    String? imagen,
    DocumentReference? usuario,
    int? idBoleto,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _imagen = imagen,
        _usuario = usuario,
        _idBoleto = idBoleto,
        super(firestoreUtilData);

  // "imagen" field.
  String? _imagen;
  String get imagen => _imagen ?? '';
  set imagen(String? val) => _imagen = val;
  bool hasImagen() => _imagen != null;

  // "usuario" field.
  DocumentReference? _usuario;
  DocumentReference? get usuario => _usuario;
  set usuario(DocumentReference? val) => _usuario = val;
  bool hasUsuario() => _usuario != null;

  // "idBoleto" field.
  int? _idBoleto;
  int get idBoleto => _idBoleto ?? 0;
  set idBoleto(int? val) => _idBoleto = val;
  void incrementIdBoleto(int amount) => _idBoleto = idBoleto + amount;
  bool hasIdBoleto() => _idBoleto != null;

  static PruebaStruct fromMap(Map<String, dynamic> data) => PruebaStruct(
        imagen: data['imagen'] as String?,
        usuario: data['usuario'] as DocumentReference?,
        idBoleto: castToType<int>(data['idBoleto']),
      );

  static PruebaStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? PruebaStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'imagen': _imagen,
        'usuario': _usuario,
        'idBoleto': _idBoleto,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => toMap();
  static PruebaStruct fromSerializableMap(Map<String, dynamic> data) =>
      fromMap(data);

  @override
  String toString() => 'PruebaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PruebaStruct &&
        imagen == other.imagen &&
        usuario == other.usuario &&
        idBoleto == other.idBoleto;
  }

  @override
  int get hashCode => const ListEquality().hash([imagen, usuario, idBoleto]);
}

PruebaStruct createPruebaStruct({
  String? imagen,
  DocumentReference? usuario,
  int? idBoleto,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PruebaStruct(
      imagen: imagen,
      usuario: usuario,
      idBoleto: idBoleto,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PruebaStruct? updatePruebaStruct(
  PruebaStruct? prueba, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    prueba
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPruebaStructData(
  Map<String, dynamic> firestoreData,
  PruebaStruct? prueba,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (prueba == null) {
    return;
  }
  if (prueba.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && prueba.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final pruebaData = getPruebaFirestoreData(prueba, forFieldValue);
  final nestedData = pruebaData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = prueba.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPruebaFirestoreData(
  PruebaStruct? prueba, [
  bool forFieldValue = false,
]) {
  if (prueba == null) {
    return {};
  }
  final firestoreData = mapToFirestore(prueba.toMap());

  // Add any Firestore field values
  prueba.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPruebaListFirestoreData(
  List<PruebaStruct>? pruebas,
) =>
    pruebas?.map((e) => getPruebaFirestoreData(e, true)).toList() ?? [];
