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
import 'Food.dart';
import 'FoodMenuItem.dart';
import 'Order.dart';
import 'Todo.dart';
import 'User.dart';

export 'Food.dart';
export 'FoodMenuItem.dart';
export 'Order.dart';
export 'Todo.dart';
export 'User.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "7e5fe9725df76cc7693f3a1d5e012f9b";
  @override
  List<ModelSchema> modelSchemas = [
    Food.schema,
    FoodMenuItem.schema,
    Order.schema,
    Todo.schema,
    User.schema
  ];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;

  ModelType getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "Food":
        {
          return Food.classType;
        }
        break;
      case "FoodMenuItem":
        {
          return FoodMenuItem.classType;
        }
        break;
      case "Order":
        {
          return Order.classType;
        }
        break;
      case "Todo":
        {
          return Todo.classType;
        }
        break;
      case "User":
        {
          return User.classType;
        }
        break;
      default:
        {
          throw Exception(
              "Failed to find model in model provider for model name: " +
                  modelName);
        }
    }
  }
}
