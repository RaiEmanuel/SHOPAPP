// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductSqlite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSqlite _$ProductSqliteFromJson(Map<String, dynamic> json) =>
    ProductSqlite(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String,
      description: json['description'] as String,
      value: (json['value'] as num).toDouble(),
      picture: json['picture'] as String,
    );

Map<String, dynamic> _$ProductSqliteToJson(ProductSqlite instance) =>
    <String, dynamic>{
      //'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'value': instance.value,
      'picture': instance.picture,
    };
