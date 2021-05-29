import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'empresas_record.g.dart';

abstract class EmpresasRecord
    implements Built<EmpresasRecord, EmpresasRecordBuilder> {
  static Serializer<EmpresasRecord> get serializer =>
      _$empresasRecordSerializer;

  @nullable
  String get address;

  @nullable
  Timestamp get createAt;

  @nullable
  DocumentReference get createBy;

  @nullable
  String get description;

  @nullable
  String get name;

  @nullable
  int get quantityVoting;

  @nullable
  double get rating;

  @nullable
  BuiltList<String> get location;

  @nullable
  String get logo;

  @nullable
  BuiltList<String> get id;

  @nullable
  BuiltList<String> get images;

  @nullable
  DocumentReference get category;

  @nullable
  String get longitude;

  @nullable
  String get latitude;

  @nullable
  String get phone;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(EmpresasRecordBuilder builder) => builder
    ..address = ''
    ..description = ''
    ..name = ''
    ..quantityVoting = 0
    ..rating = 0.0
    ..location = ListBuilder()
    ..logo = ''
    ..id = ListBuilder()
    ..images = ListBuilder()
    ..longitude = ''
    ..latitude = ''
    ..phone = ''
    ..email = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('empresas');

  static Stream<EmpresasRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  EmpresasRecord._();
  factory EmpresasRecord([void Function(EmpresasRecordBuilder) updates]) =
      _$EmpresasRecord;
}

Map<String, dynamic> createEmpresasRecordData({
  String address,
  Timestamp createAt,
  DocumentReference createBy,
  String description,
  String name,
  int quantityVoting,
  double rating,
  String logo,
  DocumentReference category,
  String longitude,
  String latitude,
  String phone,
  String email,
}) =>
    serializers.serializeWith(
        EmpresasRecord.serializer,
        EmpresasRecord((e) => e
          ..address = address
          ..createAt = createAt
          ..createBy = createBy
          ..description = description
          ..name = name
          ..quantityVoting = quantityVoting
          ..rating = rating
          ..location = null
          ..logo = logo
          ..id = null
          ..images = null
          ..category = category
          ..longitude = longitude
          ..latitude = latitude
          ..phone = phone
          ..email = email));

EmpresasRecord get dummyEmpresasRecord {
  final builder = EmpresasRecordBuilder()
    ..address = dummyString
    ..createAt = dummyTimestamp
    ..description = dummyString
    ..name = dummyString
    ..quantityVoting = dummyInteger
    ..rating = dummyDouble
    ..location = ListBuilder([dummyString, dummyString])
    ..logo = dummyImagePath
    ..id = ListBuilder([dummyString, dummyString])
    ..images = ListBuilder([dummyImagePath, dummyImagePath])
    ..longitude = dummyString
    ..latitude = dummyString
    ..phone = dummyString
    ..email = dummyString;
  return builder.build();
}

List<EmpresasRecord> createDummyEmpresasRecord({int count}) =>
    List.generate(count, (_) => dummyEmpresasRecord);
