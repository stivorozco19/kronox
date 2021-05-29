import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'featured_record.g.dart';

abstract class FeaturedRecord
    implements Built<FeaturedRecord, FeaturedRecordBuilder> {
  static Serializer<FeaturedRecord> get serializer =>
      _$featuredRecordSerializer;

  @nullable
  DocumentReference get idEmpresa;

  @nullable
  Timestamp get createAt;

  @nullable
  bool get isActive;

  @nullable
  Timestamp get dateStart;

  @nullable
  Timestamp get dateEnd;

  @nullable
  String get image;

  @nullable
  String get url;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(FeaturedRecordBuilder builder) => builder
    ..isActive = false
    ..image = ''
    ..url = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('featured');

  static Stream<FeaturedRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  FeaturedRecord._();
  factory FeaturedRecord([void Function(FeaturedRecordBuilder) updates]) =
      _$FeaturedRecord;
}

Map<String, dynamic> createFeaturedRecordData({
  DocumentReference idEmpresa,
  Timestamp createAt,
  bool isActive,
  Timestamp dateStart,
  Timestamp dateEnd,
  String image,
  String url,
}) =>
    serializers.serializeWith(
        FeaturedRecord.serializer,
        FeaturedRecord((f) => f
          ..idEmpresa = idEmpresa
          ..createAt = createAt
          ..isActive = isActive
          ..dateStart = dateStart
          ..dateEnd = dateEnd
          ..image = image
          ..url = url));

FeaturedRecord get dummyFeaturedRecord {
  final builder = FeaturedRecordBuilder()
    ..createAt = dummyTimestamp
    ..isActive = dummyBoolean
    ..dateStart = dummyTimestamp
    ..dateEnd = dummyTimestamp
    ..image = dummyImagePath
    ..url = dummyString;
  return builder.build();
}

List<FeaturedRecord> createDummyFeaturedRecord({int count}) =>
    List.generate(count, (_) => dummyFeaturedRecord);
