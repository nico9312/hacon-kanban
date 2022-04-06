import 'package:app/domain/kanban/model/list.dart';
import 'package:app/domain/misc/value_objects.dart';

class ItemEO {
  final HeadlineVO title;
  final DescriptionVO description;
  final UniqueIdVO uniqueId;
  KanbanListEO? list;
  StatusVO? status;

  ItemEO(this.title, this.description, this.uniqueId, this.status);

  ///
  ///
  ///
  removeFromList() {
    list?.removeItem(this);
    list = null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KanbanListEO && other.uniqueId == uniqueId;
  }

  @override
  int get hashCode => uniqueId.hashCode;

  @override
  String toString() => 'Item($title)';
}
