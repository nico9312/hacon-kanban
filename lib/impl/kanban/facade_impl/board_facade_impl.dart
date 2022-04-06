import 'package:app/domain/kanban/facades/i_board_facade.dart';
import 'package:app/domain/kanban/model/board.dart';
import 'package:app/domain/misc/value_objects.dart';
import 'package:app/impl/kanban/facade_impl/noco_db_connector.dart';
import 'package:get/get.dart';

class BoardFacadeImplFake extends IBoardFacade {
  final NocoDBConnector dbConnector = Get.find();

  @override
  Future<KanbanBoardEO> getKanbanBoard() async {
    final items = await dbConnector.getAllItems();

    final board = KanbanBoardEO(HeadlineVO('test'));
    board.addItems(items.map((item) => item.toDomain()).toList());

    return board;
  }
}
