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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Order type in your schema. */
@immutable
class Order extends Model {
  static const classType = const _OrderModelType();
  final String id;
  final String user_id;
  final String createdAt;
  final User user;
  final List<Food> cart;
  final String userOrdersId;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Order._internal(
      {@required this.id,
      @required this.user_id,
      this.createdAt,
      @required this.user,
      @required this.cart,
      this.userOrdersId});

  factory Order(
      {String id,
      @required String user_id,
      String createdAt,
      @required User user,
      @required List<Food> cart,
      String userOrdersId}) {
    return Order._internal(
        id: id == null ? UUID.getUUID() : id,
        user_id: user_id,
        createdAt: createdAt,
        user: user,
        cart: cart != null ? List.unmodifiable(cart) : cart,
        userOrdersId: userOrdersId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Order &&
        id == other.id &&
        user_id == other.user_id &&
        createdAt == other.createdAt &&
        user == other.user &&
        DeepCollectionEquality().equals(cart, other.cart) &&
        userOrdersId == other.userOrdersId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Order {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user_id=" + "$user_id" + ", ");
    buffer.write("createdAt=" + "$createdAt" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("userOrdersId=" + "$userOrdersId");
    buffer.write("}");

    return buffer.toString();
  }

  Order copyWith(
      {String id,
      String user_id,
      String createdAt,
      User user,
      List<Food> cart,
      String userOrdersId}) {
    return Order(
        id: id ?? this.id,
        user_id: user_id ?? this.user_id,
        createdAt: createdAt ?? this.createdAt,
        user: user ?? this.user,
        cart: cart ?? this.cart,
        userOrdersId: userOrdersId ?? this.userOrdersId);
  }

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user_id = json['user_id'],
        createdAt = json['createdAt'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        cart = json['cart'] is List
            ? (json['cart'] as List)
                .map((e) => Food.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        userOrdersId = json['userOrdersId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': user_id,
        'createdAt': createdAt,
        'user': user?.toJson(),
        'cart': cart?.map((e) => e?.toJson())?.toList(),
        'userOrdersId': userOrdersId
      };

  static final QueryField ID = QueryField(fieldName: "order.id");
  static final QueryField USER_ID = QueryField(fieldName: "user_id");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField CART = QueryField(
      fieldName: "cart",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Food).toString()));
  static final QueryField USERORDERSID = QueryField(fieldName: "userOrdersId");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Order";
    modelSchemaDefinition.pluralName = "Orders";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.USER_ID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Order.USER,
        isRequired: true,
        targetName: "orderUserId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Order.CART,
        isRequired: false,
        ofModelName: (Food).toString(),
        associatedKey: Food.ORDERCARTID));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.USERORDERSID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _OrderModelType extends ModelType<Order> {
  const _OrderModelType();

  @override
  Order fromJson(Map<String, dynamic> jsonData) {
    return Order.fromJson(jsonData);
  }
}
