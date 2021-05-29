import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'favorites_record.g.dart';

abstract class FavoritesRecord
    implements Built<FavoritesRecord, FavoritesRecordBuilder> {
  static Serializer<FavoritesRecord> get serializer =>
      _$favoritesRecordSerializer;

  @nullable
  DocumentReference get idEmpresa;

  @nullable
  DocumentReference get idUser;

  @nullable
  bool get isActive;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(FavoritesRecordBuilder builder) =>
      builder..isActive = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('favorites');

  static Stream<FavoritesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  FavoritesRecord._();
  factory FavoritesRecord([void Function(FavoritesRecordBuilder) updates]) =
      _$FavoritesRecord;
}

Map<String, dynamic> createFavoritesRecordData({
  DocumentReference idEmpresa,
  DocumentReference idUser,
  bool isActive,
}) =>
    serializers.serializeWith(
        FavoritesRecord.serializer,
        FavoritesRecord((f) => f
          ..idEmpresa = idEmpresa
          ..idUser = idUser
          ..isActive = isActive));

FavoritesRecord get dummyFavoritesRecord {
  final builder = FavoritesRecordBuilder()..isActive = dummyBoolean;
  return builder.build();
}

List<FavoritesRecord> createDummyFavoritesRecord({int count}) =>
    List.generate(count, (_) => dummyFavoritesRecord);
