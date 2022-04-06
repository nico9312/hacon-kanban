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

    final response = await _boardFacade.getKanbanBoard();

    response.fold(
      (l) => Get.snackbar('Failure', 'Not able to fetch Data'),
      (newBoard) {
        board.value = newBoard;
        board.refresh();
      },
    );

    state.value = kStateLoadingCompleted;
    state.refresh();
  }

  ///
  ///
  ///
  void dragList(KanbanListEO list, KanbanListEO other) {
    board.value.dragList(list, other);
    board.refresh();
  }

  ///
  ///
  ///
  Future<void> moveItem(
      KanbanListEO list, ItemEO item, PositionVO targetPosition) async {
    bool saveBecauseOfNewList = list.uniqueId != item.uniqueId;

    item.removeFromList();

    if (list.items.length >
        targetPosition.value.fold((l) => 10000000000, (r) => r)) {
      list.insertItem(item, targetPosition);
    } else {
      list.addItem(item);
    }

    if (saveBecauseOfNewList) {
      final response = await _boardFacade.updateItem(item);

      final itemtitle = item.title.getOrCrash();

      response.fold(
        (l) =>
            Get.snackbar('Failure', 'Was not able to update Item $itemtitle'),
        (r) => Get.snackbar('Success', 'Successfully updated Item $itemtitle'),
      );
      board.refresh();
    }
  }
}
