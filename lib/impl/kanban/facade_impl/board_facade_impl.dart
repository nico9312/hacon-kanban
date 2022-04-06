import 'package:app/domain/kanban/facades/i_board_facade.dart';
import 'package:app/domain/kanban/model/board.dart';
import 'package:app/domain/kanban/model/item.dart';
import 'package:app/domain/misc/value_objects.dart';
import 'package:app/impl/kanban/facade_impl/noco_db_connector.dart';
import 'package:app/impl/kanban/model/item_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class BoardFacadeImpl extends IBoardFacade {
  final NocoDBConnector dbConnector = Get.find();

  @override
  Future<Either<BoardFacadeFailure, KanbanBoardEO>> getKanbanBoard() async {
    try {
      final items = await dbConnector.getAllItems();

      final board = KanbanBoardEO(HeadlineVO('Kanban'));
      board.addItems(items.map((item) => item.toDomain()).toList());

      return right(board);
    } catch (e) {
      return left(BoardFacadeFailure());
    }
  }

  @override
  Future<Either<BoardFacadeFailure, Unit>> updateItem(ItemEO item) async {
    try {
      await dbConnector.updateItem(ItemDTO.fromDomain(item));
      return right(unit);
    } catch (e) {
      return left(BoardFacadeFailure());
    }
  }
}
