import 'package:app/domain/kanban/model/item.dart';
import 'package:app/domain/kanban/model/list.dart';
import 'package:app/domain/misc/value_objects.dart';

class KanbanBoardEO {
  final HeadlineVO title;
  final List<KanbanListEO> lists = [];

  KanbanBoardEO(this.title);

  ///
  ///
  ///
  void dragList(KanbanListEO sourceList, KanbanListEO targetList) {
    final sourceIndex = lists.indexOf(sourceList);
    final targetIndex = lists.indexOf(targetList);

    lists.replaceRange(sourceIndex, sourceIndex + 1, [targetList]);
    lists.replaceRange(targetIndex, targetIndex + 1, [sourceList]);
  }

  ///
  ///
  ///
  void addList(KanbanListEO list) {
    insertList(list, PositionVO(lists.length));
  }

  ///
  ///
  ///
  void insertList(KanbanListEO list, PositionVO position) {
    lists.insert(position.getOrElse(lists.length), list);

    list.board = this;
  }

  ///
  ///
  ///
  void addItems(List<ItemEO> items) {
    for (var item in items) {
      final listTitle = item.status.getOrElse('none');
      if (lists.any((list) => list.title.getOrCrash() == listTitle)) {
        lists
            .firstWhere((list) => list.title.getOrCrash() == listTitle)
            .addItem(item);
      } else {
        final newList = KanbanListEO(UniqueIdVO(), HeadlineVO(listTitle));
        newList.addItem(item);
        addList(newList);
      }
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KanbanBoardEO && other.title == title;
  }

  @override
  int get hashCode => title.hashCode;

  @override
  String toString() => 'KanbanBoard($title)';
}
