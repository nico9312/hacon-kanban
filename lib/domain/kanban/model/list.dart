import 'package:app/domain/kanban/model/board.dart';
import 'package:app/domain/kanban/model/item.dart';
import 'package:app/domain/misc/value_objects.dart';

class KanbanListEO {
  final UniqueIdVO uniqueId;
  final HeadlineVO title;
  final List<ItemEO> items = [];
  KanbanBoardEO? board;

  KanbanListEO(this.uniqueId, this.title);

  ///
  ///
  ///
  void removeItem(ItemEO item) {
    items.remove(item);
  }

  ///
  ///
  ///
  void addItem(ItemEO item) {
    insertItem(item, PositionVO(items.length));
  }

  ///
  ///
  ///
  void insertItem(ItemEO item, PositionVO position) {
    items.insert(position.getOrElse(items.length), item);

    item.list = this;
    item.status = StatusVO(title.getOrCrash());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KanbanListEO && other.uniqueId == uniqueId;
  }

  @override
  int get hashCode => uniqueId.hashCode;

  @override
  String toString() => 'KanbanList($title)';
}
