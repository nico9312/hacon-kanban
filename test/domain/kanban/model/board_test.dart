import 'package:app/domain/kanban/model/board.dart';
import 'package:app/domain/kanban/model/list.dart';
import 'package:app/domain/misc/value_objects.dart';
import 'package:test/test.dart';

void main() {
  test('add list to board', () {
    //Testdata
    final board = KanbanBoardEO(HeadlineVO('Headline'));
    final list = KanbanListEO(UniqueIdVO(), HeadlineVO('Headline - List'));

    //PreTest
    expect(board.lists.length, 0);

    //Test
    board.addList(list);

    //Assert
    expect(board.lists.length, 1);
    expect(board.lists.first.uniqueId, list.uniqueId);
  });
}
