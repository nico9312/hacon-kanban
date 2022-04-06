import 'package:app/controller/board_controller.dart';
import 'package:app/domain/kanban/model/item.dart';
import 'package:app/domain/kanban/model/list.dart';
import 'package:app/domain/misc/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/floating_widget.dart';
import 'widgets/item_widget.dart';
import 'widgets/list_header_widget.dart';

class BoardView extends GetView<BoardController> {
  final double tileHeight = 100;
  final double headerHeight = 80;
  final double tileWidth = 300;

  const BoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Widget body = const SizedBox();

      if (controller.state.value == BoardController.kStateLoading) {
        body = const Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.state.value ==
          BoardController.kStateLoadingCompleted) {
        body = SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.board.value.lists.map((list) {
                return SizedBox(
                  width: tileWidth,
                  child: buildKanbanList(list),
                );
              }).toList()),
        );
      }

      return Scaffold(
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text(
            controller.board.value.title.value.fold(
              (l) => '',
              (r) => r,
            ),
          ),
        ),
        body: body,
      );
    });
  }

  ///
  ///
  ///
  buildKanbanList(KanbanListEO list) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          buildHeader(list),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: list.items.length,
            itemBuilder: (BuildContext context, int index) {
              // A stack that provides:
              // * A draggable object
              // * An area for incoming draggables
              return Stack(
                children: [
                  Draggable<ItemEO>(
                    data: list.items[index],
                    child: ItemWidget(
                      item: list.items[index],
                    ), // A card waiting to be dragged
                    childWhenDragging: Opacity(
                      // The card that's left behind
                      opacity: 0.2,
                      child: ItemWidget(item: list.items[index]),
                    ),
                    feedback: SizedBox(
                      // A card floating around
                      height: tileHeight,
                      width: tileWidth,
                      child: FloatingWidget(
                          child: ItemWidget(
                        item: list.items[index],
                      )),
                    ),
                  ),
                  buildItemDragTarget(list, PositionVO(index), tileHeight),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  buildHeader(KanbanListEO list) {
    Widget header = SizedBox(
      height: headerHeight,
      child: HeaderWidget(title: list.title),
    );

    return Stack(
      // The header
      children: [
        Draggable<String>(
          data: list.title.value.fold((l) => '', (r) => r),
          child: header, // A header waiting to be dragged
          childWhenDragging: Opacity(
            // The header that's left behind
            opacity: 0.2,
            child: header,
          ),
          feedback: FloatingWidget(
            child: SizedBox(
              // A header floating around
              width: tileWidth,
              child: header,
            ),
          ),
        ),
        buildItemDragTarget(list, PositionVO(0), headerHeight),
        DragTarget<KanbanListEO>(
          // Will accept others, but not himself
          onWillAccept: (KanbanListEO? incomingList) =>
              list.uniqueId != incomingList?.uniqueId,
          // Moves the card into the position
          onAccept: (KanbanListEO incomingList) =>
              controller.dragList(list, incomingList),

          builder: (BuildContext context, List<KanbanListEO?> data,
              List<dynamic> rejectedData) {
            if (data.isEmpty) {
              // The area that accepts the draggable
              return SizedBox(
                height: headerHeight,
                width: tileWidth,
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.blueAccent,
                  ),
                ),
                height: headerHeight,
                width: tileWidth,
              );
            }
          },
        )
      ],
    );
  }

  ///
  ///
  ///
  buildItemDragTarget(
      KanbanListEO list, PositionVO targetPosition, double height) {
    return DragTarget<ItemEO>(
      // Will accept others, but not himself
      onWillAccept: (ItemEO? data) {
        return list.items.isEmpty ||
            data?.uniqueId != list.items[targetPosition.getOrElse(0)].uniqueId;
      },
      // Moves the card into the position
      onAccept: (ItemEO data) =>
          controller.moveItem(list, data, targetPosition),
      builder: (BuildContext context, List<ItemEO?> data,
          List<dynamic> rejectedData) {
        if (data.isEmpty) {
          // The area that accepts the draggable
          return Container(
            height: height,
          );
        } else {
          return Column(
            // What's shown when hovering on it
            children: [
              Container(
                height: height,
              ),
              ...data.map((ItemEO? item) {
                return Opacity(
                  opacity: 0.5,
                  child: ItemWidget(item: item),
                );
              }).toList()
            ],
          );
        }
      },
    );
  }
}
