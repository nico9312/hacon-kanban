import 'package:app/domain/kanban/model/item.dart';
import 'package:app/domain/misc/value_objects.dart';

class ItemDTO {
  final String uniqueId;
  final String? description;
  final String? status;
  final String title;

  ItemDTO({
    required this.uniqueId,
    this.description,
    this.status,
    required this.title,
  });

  ///
  ///
  ///
  factory ItemDTO.fromJson(Map<String, dynamic> json) => ItemDTO(
        uniqueId: json['id'].toString(),
        title: json['title'],
        description: json['description'],
        status: json['Status'],
      );

  ///
  ///
  ///
  Map<String, dynamic> toJson() {
    return {
      'id': int.parse(uniqueId),
      'title': title,
      'description': description,
      'Status': status
    };
  }

  ///
  ///
  ///
  ItemEO toDomain() {
    return ItemEO(
      HeadlineVO(title),
      DescriptionVO(description),
      UniqueIdVO.fromUniqueString(uniqueId),
      StatusVO(status),
    );
  }

  ///
  ///
  ///
  factory ItemDTO.fromDomain(ItemEO item) => ItemDTO(
        uniqueId: item.uniqueId.getOrCrash(),
        title: item.title.getOrCrash(),
        description: item.description.getOrElse(''),
        status: item.status!.getOrElse(''),
      );
}
