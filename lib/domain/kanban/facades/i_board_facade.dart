import 'package:app/domain/kanban/model/board.dart';
import 'package:get/get.dart';

abstract class IBoardFacade extends GetxService {
  ///
  ///
  ///
  Future<KanbanBoardEO> getKanbanBoard();
}
