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
  final String dayeTime;
  final String userID;
  final User user;
  final List<Food> cart;
  final String totalAmount;
  final String status;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Order._internal(
      {@required this.id,
      @required this.dayeTime,
      this.userID,
      this.user,
      this.cart,
      this.totalAmount,
      this.status});

  factory Order(
      {String id,
      @required String dayeTime,
      String userID,
      User user,
      List<Food> cart,
      String totalAmount,
      String status}) {
    return Order._internal(
        id: id == null ? UUID.getUUID() : id,
        dayeTime: dayeTime,
        userID: userID,
        user: user,
        cart: cart != null ? List.unmodifiable(cart) : cart,
        totalAmount: totalAmount,
        status: status);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Order &&
        id == other.id &&
        dayeTime == other.dayeTime &&
        userID == other.userID &&
        user == other.user &&
        DeepCollectionEquality().equals(cart, other.cart) &&
        totalAmount == other.totalAmount &&
        status == other.status;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Order {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("dayeTime=" + "$dayeTime" + ", ");
    buffer.write("userID=" + "$userID" + ", ");
    buffer.write("user=" + (user != null ? user.toString() : "null") + ", ");
    buffer.write("totalAmount=" + "$totalAmount" + ", ");
    buffer.write("status=" + "$status");
    buffer.write("}");

    return buffer.toString();
  }

  Order copyWith(
      {String id,
      String dayeTime,
      String userID,
      User user,
      List<Food> cart,
      String totalAmount,
      String status}) {
    return Order(
        id: id ?? this.id,
        dayeTime: dayeTime ?? this.dayeTime,
        userID: userID ?? this.userID,
        user: user ?? this.user,
        cart: cart ?? this.cart,
        totalAmount: totalAmount ?? this.totalAmount,
        status: status ?? this.status);
  }

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        dayeTime = json['dayeTime'],
        userID = json['userID'],
        user = json['user'] != null
            ? User.fromJson(new Map<String, dynamic>.from(json['user']))
            : null,
        cart = json['cart'] is List
            ? (json['cart'] as List)
                .map((e) => Food.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        totalAmount = json['totalAmount'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'dayeTime': dayeTime,
        'userID': userID,
        'user': user?.toJson(),
        'cart': cart?.map((e) => e?.toJson())?.toList(),
        'totalAmount': totalAmount,
        'status': status
      };

  static final QueryField ID = QueryField(fieldName: "order.id");
  static final QueryField DAYETIME = QueryField(fieldName: "dayeTime");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField USER = QueryField(
      fieldName: "user",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (User).toString()));
  static final QueryField CART = QueryField(
      fieldName: "cart",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Food).toString()));
  static final QueryField TOTALAMOUNT = QueryField(fieldName: "totalAmount");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Order";
    modelSchemaDefinition.pluralName = "Orders";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.DAYETIME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.USERID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: Order.USER,
        isRequired: false,
        targetName: "orderUserId",
        ofModelName: (User).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Order.CART,
        isRequired: false,
        ofModelName: (Food).toString(),
        associatedKey: Food.ORDER));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.TOTALAMOUNT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Order.STATUS,
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
