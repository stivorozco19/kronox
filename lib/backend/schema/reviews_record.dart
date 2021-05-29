import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'reviews_record.g.dart';

abstract class ReviewsRecord
    implements Built<ReviewsRecord, ReviewsRecordBuilder> {
  static Serializer<ReviewsRecord> get serializer => _$reviewsRecordSerializer;

  @nullable
  DocumentReference get idUser;

  @nullable
  Timestamp get createAt;

  @nullable
  DocumentReference get idEmpresa;

  @nullable
  double get rating;

  @nullable
  String get review;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ReviewsRecordBuilder builder) => builder
    ..rating = 0.0
    ..review = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('reviews');

  static Stream<ReviewsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ReviewsRecord._();
  factory ReviewsRecord([void Function(ReviewsRecordBuilder) updates]) =
      _$ReviewsRecord;
}

Map<String, dynamic> createReviewsRecordData({
  DocumentReference idUser,
  Timestamp createAt,
  DocumentReference idEmpresa,
  double rating,
  String review,
}) =>
    serializers.serializeWith(
        ReviewsRecord.serializer,
        ReviewsRecord((r) => r
          ..idUser = idUser
          ..createAt = createAt
          ..idEmpresa = idEmpresa
          ..rating = rating
          ..review = review));

ReviewsRecord get dummyReviewsRecord {
  final builder = ReviewsRecordBuilder()
    ..createAt = dummyTimestamp
    ..rating = dummyDouble
    ..review = dummyString;
  return builder.build();
}

List<ReviewsRecord> createDummyReviewsRecord({int count}) =>
    List.generate(count, (_) => dummyReviewsRecord);
