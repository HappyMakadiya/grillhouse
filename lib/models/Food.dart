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

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Food type in your schema. */
@immutable
class Food extends Model {
  static const classType = const _FoodModelType();
  final String id;
  final String food_name;
  final String food_price;
  final String food_quantity;
  final String total_price;
  final Order order;
  final String orderCartId;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Food._internal(
      {@required this.id,
      @required this.food_name,
      @required this.food_price,
      @required this.food_quantity,
      @required this.total_price,
      @required this.order,
      this.orderCartId});

  factory Food(
      {String id,
      @required String food_name,
      @required String food_price,
      @required String food_quantity,
      @required String total_price,
      @required Order order,
      String orderCartId}) {
    return Food._internal(
        id: id == null ? UUID.getUUID() : id,
        food_name: food_name,
        food_price: food_price,
        food_quantity: food_quantity,
        total_price: total_price,
        order: order,
        orderCartId: orderCartId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Food &&
        id == other.id &&
        food_name == other.food_name &&
        food_price == other.food_price &&
        food_quantity == other.food_quantity &&
        total_price == other.total_price &&
        order == other.order &&
        orderCartId == other.orderCartId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Food {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("food_name=" + "$food_name" + ", ");
    buffer.write("food_price=" + "$food_price" + ", ");
    buffer.write("food_quantity=" + "$food_quantity" + ", ");
    buffer.write("total_price=" + "$total_price" + ", ");
    buffer.write("order=" + (order != null ? order.toString() : "null") + ", ");
    buffer.write("orderCartId=" + "$orderCartId");
    buffer.write("}");

    return buffer.toString();
  }

  Food copyWith(
      {String id,
      String food_name,
      String food_price,
      String food_quantity,
      String total_price,
      Order order,
      String orderCartId}) {
    return Food(
        id: id ?? this.id,
        food_name: food_name ?? this.food_name,
        food_price: food_price ?? this.food_price,
        food_quantity: food_quantity ?? this.food_quantity,
        total_price: total_price ?? this.total_price,
        order: order ?? this.order,
        orderCartId: orderCartId ?? this.orderCartId);
  }

  Food.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        food_name = json['food_name'],
        food_price = json['food_price'],
        food_quantity = json['food_quantity'],
        total_price = json['total_price'],
        order = json['order'] != null
            ? Order.fromJson(new Map<String, dynamic>.from(json['order']))
            : null,
        orderCartId = json['orderCartId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'food_name': food_name,
        'food_price': food_price,
        'food_quantity': food_quantity,
        'total_price': total_price,
        'order': order?.toJson(),
        'orderCartId': orderCartId
      };

  static final QueryField ID = QueryField(fieldName: "food.id");
  static final QueryField FOOD_NAME = QueryField(fieldName: "food_name");
  static final QueryField FOOD_PRICE = QueryField(fieldName: "food_price");
  static final QueryField FOOD_QUANTITY =
      QueryField(fieldName: "food_quantity");
  static final QueryField TOTAL_PRICE = QueryField(fieldName: "total_price");
  static final QueryField ORDER = QueryField(
      fieldName: "order",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Order).toString()));
  static final QueryField ORDERCARTID = QueryField(fieldName: "orderCartId");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Food";
    modelSchemaDefinition.pluralName = "Foods";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Food.FOOD_NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Food.FOOD_PRICE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Food.FOOD_QUANTITY,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Food.TOTAL_PRICE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Food.ORDER,
        isRequired: true,
        targetName: "foodOrderId",
        ofModelName: (Order).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Food.ORDERCARTID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _FoodModelType extends ModelType<Food> {
  const _FoodModelType();

  @override
  Food fromJson(Map<String, dynamic> jsonData) {
    return Food.fromJson(jsonData);
  }
}
