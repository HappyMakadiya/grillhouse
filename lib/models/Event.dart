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

/** This is an auto generated class representing the Event type in your schema. */
@immutable
class Event extends Model {
  static const classType = const _EventModelType();
  final String id;
  final String name;
  final String queryName;
  final String createdAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const Event._internal(
      {@required this.id,
      @required this.name,
      @required this.queryName,
      @required this.createdAt});

  factory Event(
      {String id,
      @required String name,
      @required String queryName,
      @required String createdAt}) {
    return Event._internal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        queryName: queryName,
        createdAt: createdAt);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Event &&
        id == other.id &&
        name == other.name &&
        queryName == other.queryName &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Event {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$name" + ", ");
    buffer.write("queryName=" + "$queryName" + ", ");
    buffer.write("createdAt=" + "$createdAt");
    buffer.write("}");

    return buffer.toString();
  }

  Event copyWith({String id, String name, String queryName, String createdAt}) {
    return Event(
        id: id ?? this.id,
        name: name ?? this.name,
        queryName: queryName ?? this.queryName,
        createdAt: createdAt ?? this.createdAt);
  }

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        queryName = json['queryName'],
        createdAt = json['createdAt'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'queryName': queryName, 'createdAt': createdAt};

  static final QueryField ID = QueryField(fieldName: "event.id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField QUERYNAME = QueryField(fieldName: "queryName");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Event";
    modelSchemaDefinition.pluralName = "Events";

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.NAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.QUERYNAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Event.CREATEDAT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _EventModelType extends ModelType<Event> {
  const _EventModelType();

  @override
  Event fromJson(Map<String, dynamic> jsonData) {
    return Event.fromJson(jsonData);
  }
}
