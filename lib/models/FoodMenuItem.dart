/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the FoodMenuItem type in your schema. */
@immutable
class FoodMenuItem extends Model {
  static const classType = const _FoodMenuItemModelType();
  final String id;
  final String food_name;
  final String food_price;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const FoodMenuItem._internal(
      {@required this.id, @required this.food_name, @required this.food_price});

  factory FoodMenuItem(
      {String id, @required String food_name, @required String food_price}) {
    return FoodMenuItem._internal(
        id: id == null ? UUID.getUUID() : id,
        food_name: food_name,
        food_price: food_price);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FoodMenuItem &&
        id == other.id &&
        food_name == other.food_name &&
        food_price == other.food_price;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("FoodMenuItem {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("food_name=" + "$food_name" + ", ");
    buffer.write("food_price=" + "$food_price");
    buffer.write("}");

    return buffer.toString();
  }

  FoodMenuItem copyWith({String id, String food_name, String food_price}) {
    return FoodMenuItem(
        id: id ?? this.id,
        food_name: food_name ?? this.food_name,
        food_price: food_price ?? this.food_price);
  }

  FoodMenuItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        food_name = json['food_name'],
        food_price = json['food_price'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'food_name': food_name, 'food_price': food_price};

  static final QueryField ID = QueryField(fieldName: "foodMenuItem.id");
  static final QueryField FOOD_NAME = QueryField(fieldName: "food_name");
  static final QueryField FOOD_PRICE = QueryField(fieldName: "food_price");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "FoodMenuItem";
    modelSchemaDefinition.pluralName = "FoodMenuItems";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: FoodMenuItem.FOOD_NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: FoodMenuItem.FOOD_PRICE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _FoodMenuItemModelType extends ModelType<FoodMenuItem> {
  const _FoodMenuItemModelType();

  @override
  FoodMenuItem fromJson(Map<String, dynamic> jsonData) {
    return FoodMenuItem.fromJson(jsonData);
  }
}
