import 'dart:convert';

import 'package:app/impl/kanban/model/item_dto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_connect/connect.dart';

class NocoDBConnector extends GetConnect {
  static final kBaseUrl = dotenv.get('NOCODB_BASE_URL');
  static final Map<String, String> headers = {
    'accept': 'accept: application/json',
    'xc-auth': dotenv.get('NOCODB_TOKEN'),
  };

  Future<List<ItemDTO>> getAllItems() async {
    final requestUrl = '$kBaseUrl?where=~not(Status%2Clike%2C%Archived%)';

    final response = await get(requestUrl, headers: headers);

    if (response.bodyString == null || !response.isOk) {
      throw Exception();
    }
    final List<ItemDTO> returnList = [];
    final decoded = jsonDecode(response.bodyString!);

    if (decoded is List) {
      List<dynamic> decodedList = decoded;
      returnList.addAll(
        decodedList.map(
          (json) => ItemDTO.fromJson(json),
        ),
      );
    } else {
      returnList.add(ItemDTO.fromJson(decoded));
    }

    return returnList;
  }

  ///
  ///
  ///
  Future<void> updateItem(ItemDTO item) async {
    final id = item.uniqueId;
    final requestUrl = '$kBaseUrl/$id';

    final response =
        await put(requestUrl, jsonEncode(item.toJson()), headers: headers);

    if (response.bodyString == null || !response.isOk) {
      throw Exception();
    }
  }
}
