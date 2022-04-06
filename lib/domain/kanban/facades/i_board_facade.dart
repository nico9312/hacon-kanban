import 'package:app/domain/kanban/model/board.dart';
import 'package:app/domain/kanban/model/item.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

abstract class IBoardFacade extends GetxService {
  ///
  ///
  ///
  Future<Either<BoardFacadeFailure, KanbanBoardEO>> getKanbanBoard();

  ///
  ///
  ///
  Future<Either<BoardFacadeFailure, Unit>> updateItem(ItemEO item);
}

class BoardFacadeFailure {}
