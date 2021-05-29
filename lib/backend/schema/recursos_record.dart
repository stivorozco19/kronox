import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'recursos_record.g.dart';

abstract class RecursosRecord
    implements Built<RecursosRecord, RecursosRecordBuilder> {
  static Serializer<RecursosRecord> get serializer =>
      _$recursosRecordSerializer;

  @nullable
  String get name;

  @nullable
  DocumentReference get owner;

  @nullable
  DocumentReference get idEmpresa;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(RecursosRecordBuilder builder) =>
      builder..name = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('recursos');

  static Stream<RecursosRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  RecursosRecord._();
  factory RecursosRecord([void Function(RecursosRecordBuilder) updates]) =
      _$RecursosRecord;
}

Map<String, dynamic> createRecursosRecordData({
  String name,
  DocumentReference owner,
  DocumentReference idEmpresa,
}) =>
    serializers.serializeWith(
        RecursosRecord.serializer,
        RecursosRecord((r) => r
          ..name = name
          ..owner = owner
          ..idEmpresa = idEmpresa));

RecursosRecord get dummyRecursosRecord {
  final builder = RecursosRecordBuilder()..name = dummyString;
  return builder.build();
}

List<RecursosRecord> createDummyRecursosRecord({int count}) =>
    List.generate(count, (_) => dummyRecursosRecord);
