import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'citas_record.g.dart';

abstract class CitasRecord implements Built<CitasRecord, CitasRecordBuilder> {
  static Serializer<CitasRecord> get serializer => _$citasRecordSerializer;

  @nullable
  DocumentReference get idUser;

  @nullable
  DocumentReference get idEmpresa;

  @nullable
  @BuiltValueField(wireName: 'IdServicio')
  DocumentReference get idServicio;

  @nullable
  DocumentReference get idRecurso;

  @nullable
  @BuiltValueField(wireName: 'date_time_start')
  Timestamp get dateTimeStart;

  @nullable
  @BuiltValueField(wireName: 'date_time_end')
  Timestamp get dateTimeEnd;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CitasRecordBuilder builder) => builder;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('citas');

  static Stream<CitasRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  CitasRecord._();
  factory CitasRecord([void Function(CitasRecordBuilder) updates]) =
      _$CitasRecord;
}

Map<String, dynamic> createCitasRecordData({
  DocumentReference idUser,
  DocumentReference idEmpresa,
  DocumentReference idServicio,
  DocumentReference idRecurso,
  Timestamp dateTimeStart,
  Timestamp dateTimeEnd,
}) =>
    serializers.serializeWith(
        CitasRecord.serializer,
        CitasRecord((c) => c
          ..idUser = idUser
          ..idEmpresa = idEmpresa
          ..idServicio = idServicio
          ..idRecurso = idRecurso
          ..dateTimeStart = dateTimeStart
          ..dateTimeEnd = dateTimeEnd));

CitasRecord get dummyCitasRecord {
  final builder = CitasRecordBuilder()
    ..dateTimeStart = dummyTimestamp
    ..dateTimeEnd = dummyTimestamp;
  return builder.build();
}

List<CitasRecord> createDummyCitasRecord({int count}) =>
    List.generate(count, (_) => dummyCitasRecord);
