import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'categories_record.g.dart';

abstract class CategoriesRecord
    implements Built<CategoriesRecord, CategoriesRecordBuilder> {
  static Serializer<CategoriesRecord> get serializer =>
      _$categoriesRecordSerializer;

  @nullable
  String get name;

  @nullable
  String get image;

  @nullable
  bool get isActive;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CategoriesRecordBuilder builder) => builder
    ..name = ''
    ..image = ''
    ..isActive = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('categories');

  static Stream<CategoriesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  CategoriesRecord._();
  factory CategoriesRecord([void Function(CategoriesRecordBuilder) updates]) =
      _$CategoriesRecord;
}

Map<String, dynamic> createCategoriesRecordData({
  String name,
  String image,
  bool isActive,
}) =>
    serializers.serializeWith(
        CategoriesRecord.serializer,
        CategoriesRecord((c) => c
          ..name = name
          ..image = image
          ..isActive = isActive));

CategoriesRecord get dummyCategoriesRecord {
  final builder = CategoriesRecordBuilder()
    ..name = dummyString
    ..image = dummyImagePath
    ..isActive = dummyBoolean;
  return builder.build();
}

List<CategoriesRecord> createDummyCategoriesRecord({int count}) =>
    List.generate(count, (_) => dummyCategoriesRecord);
