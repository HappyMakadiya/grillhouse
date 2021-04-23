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

/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String cognito_user_id;
  final String name;
  final String email;
  final String phonr_number;
  final List<Order> orders;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const User._internal(
      {@required this.id,
      this.cognito_user_id,
      @required this.name,
      @required this.email,
      this.phonr_number,
      this.orders});

  factory User(
      {String id,
      String cognito_user_id,
      @required String name,
      @required String email,
      String phonr_number,
      List<Order> orders}) {
    return User._internal(
        id: id == null ? UUID.getUUID() : id,
        cognito_user_id: cognito_user_id,
        name: name,
        email: email,
        phonr_number: phonr_number,
        orders: orders != null ? List.unmodifiable(orders) : orders);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        cognito_user_id == other.cognito_user_id &&
        name == other.name &&
        email == other.email &&
        phonr_number == other.phonr_number &&
        DeepCollectionEquality().equals(orders, other.orders);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("cognito_user_id=" + "$cognito_user_id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("email=" + "$email" + ", ");
    buffer.write("phonr_number=" + "$phonr_number");
    buffer.write("}");

    return buffer.toString();
  }

  User copyWith(
      {String id,
      String cognito_user_id,
      String name,
      String email,
      String phonr_number,
      List<Order> orders}) {
    return User(
        id: id ?? this.id,
        cognito_user_id: cognito_user_id ?? this.cognito_user_id,
        name: name ?? this.name,
        email: email ?? this.email,
        phonr_number: phonr_number ?? this.phonr_number,
        orders: orders ?? this.orders);
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        cognito_user_id = json['cognito_user_id'],
        name = json['name'],
        email = json['email'],
        phonr_number = json['phonr_number'],
        orders = json['orders'] is List
            ? (json['orders'] as List)
                .map((e) => Order.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'cognito_user_id': cognito_user_id,
        'name': name,
        'email': email,
        'phonr_number': phonr_number,
        'orders': orders?.map((e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField COGNITO_USER_ID =
      QueryField(fieldName: "cognito_user_id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PHONR_NUMBER = QueryField(fieldName: "phonr_number");
  static final QueryField ORDERS = QueryField(
      fieldName: "orders",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Order).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.COGNITO_USER_ID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.EMAIL,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: User.PHONR_NUMBER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: User.ORDERS,
        isRequired: false,
        ofModelName: (Order).toString(),
        associatedKey: Order.USER));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();

  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}
