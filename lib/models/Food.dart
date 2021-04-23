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
  final String orderID;
  final Order order;
  final String foodMenuItemID;
  final FoodMenuItem foodMenuItem;
  final String food_quantity;
  final String total_price;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Food._internal(
      {@required this.id,
      @required this.orderID,
      this.order,
      @required this.foodMenuItemID,
      this.foodMenuItem,
      @required this.food_quantity,
      @required this.total_price});

  factory Food(
      {String id,
      @required String orderID,
      Order order,
      @required String foodMenuItemID,
      FoodMenuItem foodMenuItem,
      @required String food_quantity,
      @required String total_price}) {
    return Food._internal(
        id: id == null ? UUID.getUUID() : id,
        orderID: orderID,
        order: order,
        foodMenuItemID: foodMenuItemID,
        foodMenuItem: foodMenuItem,
        food_quantity: food_quantity,
        total_price: total_price);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Food &&
        id == other.id &&
        orderID == other.orderID &&
        order == other.order &&
        foodMenuItemID == other.foodMenuItemID &&
        foodMenuItem == other.foodMenuItem &&
        food_quantity == other.food_quantity &&
        total_price == other.total_price;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Food {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("orderID=" + "$orderID" + ", ");
    buffer.write("order=" + (order != null ? order.toString() : "null") + ", ");
    buffer.write("foodMenuItemID=" + "$foodMenuItemID" + ", ");
    buffer.write("food_quantity=" + "$food_quantity" + ", ");
    buffer.write("total_price=" + "$total_price");
    buffer.write("}");

    return buffer.toString();
  }

  Food copyWith(
      {String id,
      String orderID,
      Order order,
      String foodMenuItemID,
      FoodMenuItem foodMenuItem,
      String food_quantity,
      String total_price}) {
    return Food(
        id: id ?? this.id,
        orderID: orderID ?? this.orderID,
        order: order ?? this.order,
        foodMenuItemID: foodMenuItemID ?? this.foodMenuItemID,
        foodMenuItem: foodMenuItem ?? this.foodMenuItem,
        food_quantity: food_quantity ?? this.food_quantity,
        total_price: total_price ?? this.total_price);
  }

  Food.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        orderID = json['orderID'],
        order = json['order'] != null
            ? Order.fromJson(new Map<String, dynamic>.from(json['order']))
            : null,
        foodMenuItemID = json['foodMenuItemID'],
        foodMenuItem = json['foodMenuItem'] != null
            ? FoodMenuItem.fromJson(
                new Map<String, dynamic>.from(json['foodMenuItem']))
            : null,
        food_quantity = json['food_quantity'],
        total_price = json['total_price'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderID': orderID,
        'order': order?.toJson(),
        'foodMenuItemID': foodMenuItemID,
        'foodMenuItem': foodMenuItem?.toJson(),
        'food_quantity': food_quantity,
        'total_price': total_price
      };

  static final QueryField ID = QueryField(fieldName: "food.id");
  static final QueryField ORDERID = QueryField(fieldName: "orderID");
  static final QueryField ORDER = QueryField(
      fieldName: "order",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Order).toString()));
  static final QueryField FOODMENUITEMID =
      QueryField(fieldName: "foodMenuItemID");
  static final QueryField FOODMENUITEM = QueryField(
      fieldName: "foodMenuItem",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (FoodMenuItem).toString()));
  static final QueryField FOOD_QUANTITY =
      QueryField(fieldName: "food_quantity");
  static final QueryField TOTAL_PRICE = QueryField(fieldName: "total_price");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Food";
    modelSchemaDefinition.pluralName = "Foods";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Food.ORDERID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Food.ORDER,
        isRequired: false,
        targetName: "foodOrderId",
        ofModelName: (Order).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Food.FOODMENUITEMID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: Food.FOODMENUITEM,
        isRequired: false,
        ofModelName: (FoodMenuItem).toString(),
        associatedKey: FoodMenuItem.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Food.FOOD_QUANTITY,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Food.TOTAL_PRICE,
        isRequired: true,
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
