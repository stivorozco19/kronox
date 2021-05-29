import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'servicios_empresa_record.g.dart';

abstract class ServiciosEmpresaRecord
    implements Built<ServiciosEmpresaRecord, ServiciosEmpresaRecordBuilder> {
  static Serializer<ServiciosEmpresaRecord> get serializer =>
      _$serviciosEmpresaRecordSerializer;

  @nullable
  String get name;

  @nullable
  double get price;

  @nullable
  bool get isActive;

  @nullable
  String get descripcion;

  @nullable
  DocumentReference get idEmpresa;

  @nullable
  DocumentReference get idRecurso;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ServiciosEmpresaRecordBuilder builder) =>
      builder
        ..name = ''
        ..price = 0.0
        ..isActive = false
        ..descripcion = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('servicios_empresa');

  static Stream<ServiciosEmpresaRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  ServiciosEmpresaRecord._();
  factory ServiciosEmpresaRecord(
          [void Function(ServiciosEmpresaRecordBuilder) updates]) =
      _$ServiciosEmpresaRecord;
}

Map<String, dynamic> createServiciosEmpresaRecordData({
  String name,
  double price,
  bool isActive,
  String descripcion,
  DocumentReference idEmpresa,
  DocumentReference idRecurso,
}) =>
    serializers.serializeWith(
        ServiciosEmpresaRecord.serializer,
        ServiciosEmpresaRecord((s) => s
          ..name = name
          ..price = price
          ..isActive = isActive
          ..descripcion = descripcion
          ..idEmpresa = idEmpresa
          ..idRecurso = idRecurso));

ServiciosEmpresaRecord get dummyServiciosEmpresaRecord {
  final builder = ServiciosEmpresaRecordBuilder()
    ..name = dummyString
    ..price = dummyDouble
    ..isActive = dummyBoolean
    ..descripcion = dummyString;
  return builder.build();
}

List<ServiciosEmpresaRecord> createDummyServiciosEmpresaRecord({int count}) =>
    List.generate(count, (_) => dummyServiciosEmpresaRecord);
