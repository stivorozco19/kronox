import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'images_empresas_record.g.dart';

abstract class ImagesEmpresasRecord
    implements Built<ImagesEmpresasRecord, ImagesEmpresasRecordBuilder> {
  static Serializer<ImagesEmpresasRecord> get serializer =>
      _$imagesEmpresasRecordSerializer;

  @nullable
  String get image;

  @nullable
  DocumentReference get createBy;

  @nullable
  Timestamp get createAt;

  @nullable
  DocumentReference get idEmpresa;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ImagesEmpresasRecordBuilder builder) =>
      builder..image = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('images_empresas');

  static Stream<ImagesEmpresasRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ImagesEmpresasRecord._();
  factory ImagesEmpresasRecord(
          [void Function(ImagesEmpresasRecordBuilder) updates]) =
      _$ImagesEmpresasRecord;
}

Map<String, dynamic> createImagesEmpresasRecordData({
  String image,
  DocumentReference createBy,
  Timestamp createAt,
  DocumentReference idEmpresa,
}) =>
    serializers.serializeWith(
        ImagesEmpresasRecord.serializer,
        ImagesEmpresasRecord((i) => i
          ..image = image
          ..createBy = createBy
          ..createAt = createAt
          ..idEmpresa = idEmpresa));

ImagesEmpresasRecord get dummyImagesEmpresasRecord {
  final builder = ImagesEmpresasRecordBuilder()
    ..image = dummyImagePath
    ..createAt = dummyTimestamp;
  return builder.build();
}

List<ImagesEmpresasRecord> createDummyImagesEmpresasRecord({int count}) =>
    List.generate(count, (_) => dummyImagesEmpresasRecord);
