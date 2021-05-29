import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'products_record.g.dart';

abstract class ProductsRecord
    implements Built<ProductsRecord, ProductsRecordBuilder> {
  static Serializer<ProductsRecord> get serializer =>
      _$productsRecordSerializer;

  @nullable
  String get name;

  @nullable
  double get price;

  @nullable
  int get quantity;

  @nullable
  String get image;

  @nullable
  bool get isActive;

  @nullable
  String get description;

  @nullable
  DocumentReference get idEmpresa;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ProductsRecordBuilder builder) => builder
    ..name = ''
    ..price = 0.0
    ..quantity = 0
    ..image = ''
    ..isActive = false
    ..description = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('products');

  static Stream<ProductsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ProductsRecord._();
  factory ProductsRecord([void Function(ProductsRecordBuilder) updates]) =
      _$ProductsRecord;
}

Map<String, dynamic> createProductsRecordData({
  String name,
  double price,
  int quantity,
  String image,
  bool isActive,
  String description,
  DocumentReference idEmpresa,
}) =>
    serializers.serializeWith(
        ProductsRecord.serializer,
        ProductsRecord((p) => p
          ..name = name
          ..price = price
          ..quantity = quantity
          ..image = image
          ..isActive = isActive
          ..description = description
          ..idEmpresa = idEmpresa));

ProductsRecord get dummyProductsRecord {
  final builder = ProductsRecordBuilder()
    ..name = dummyString
    ..price = dummyDouble
    ..quantity = dummyInteger
    ..image = dummyImagePath
    ..isActive = dummyBoolean
    ..description = dummyString;
  return builder.build();
}

List<ProductsRecord> createDummyProductsRecord({int count}) =>
    List.generate(count, (_) => dummyProductsRecord);
