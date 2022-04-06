import 'package:app/domain/kanban/facades/i_board_facade.dart';
import 'package:app/domain/kanban/model/board.dart';
import 'package:app/domain/kanban/model/item.dart';
import 'package:app/domain/kanban/model/list.dart';
import 'package:app/domain/misc/value_objects.dart';
import 'package:get/get.dart';

class BoardController extends GetxController {
  static const String kStateLoading = 'loading';
  static const String kStateLoadingCompleted = 'loadingCompleted';

  final board = KanbanBoardEO(HeadlineVO('Kanban - Hacon')).obs;

  final state = kStateLoading.obs;

  final IBoardFacade _boardFacade = Get.find();

  @override
  void onInit() {
    loadBoardData();
    super.onInit();
  }

  ///
  ///
  ///
  Future<void> loadBoardData() async {
    state.value = kStateLoading;
    state.refresh();

    final newBoard = await _boardFacade.getKanbanBoard();

    board.value = newBoard;
    board.refresh();

    state.value = kStateLoadingCompleted;
    state.refresh();
  }

  ///
  ///
  ///
  void dragList(KanbanListEO list, KanbanListEO other) {
    print(list);
    print(other);
    board.value.dragList(list, other);
    board.refresh();
  }

  ///
  ///
  ///
  void moveItem(KanbanListEO list, ItemEO item, PositionVO targetPosition) {
    item.removeFromList();

    if (list.items.length >
        targetPosition.value.fold((l) => 10000000000, (r) => r)) {
      list.insertItem(item, targetPosition);
    } else {
      list.addItem(item);
    }

    board.refresh();
  }
}
