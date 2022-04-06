import 'package:app/controller/board_controller.dart';
import 'package:app/domain/kanban/facades/i_board_facade.dart';
import 'package:app/impl/kanban/facade_impl/board_facade_impl.dart';
import 'package:app/impl/kanban/facade_impl/noco_db_connector.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoardController>(() => BoardController());
    Get.lazyPut<IBoardFacade>(() => BoardFacadeImpl());
    Get.lazyPut<NocoDBConnector>(() => NocoDBConnector());
  }
}
