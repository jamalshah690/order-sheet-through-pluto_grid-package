import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderapp/model/order_model.dart';
import 'package:pluto_grid/pluto_grid.dart'; 
 

class OrderSheetController extends GetxController {
  PlutoGridStateManager? stateManager;
  RxList<OrderModel> orders = <OrderModel>[].obs;

  void initializeStateManager(PlutoGridStateManager manager) {
    stateManager = manager;
    update();
  }

  String generateRandomId(int length) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();

    return List.generate(length, (index) {
      return characters[random.nextInt(characters.length)];
    }).join();
  }

  void addOrder() {
    String id = generateRandomId(2);

    final newOrder = OrderModel(
      customerId: 'GLJN-${id}',
      customerName: 'Gloria Jeans',
      branchName: 'Head Office',
      trip: '-',
      quantity: 100,
    );

    orders.add(newOrder);

    if (stateManager != null) {
      stateManager!.appendRows([orderToPlutoRow(newOrder)]);
      orders.refresh();
    } else {
      orders.refresh();
    }
  }

// update the current row
  void updateOrder(int index, OrderModel updatedOrder) {
    orders[index] = updatedOrder; // Update the order in the orders list

    if (stateManager != null) {
      // Convert the updated OrderModel to a PlutoRow
      final updatedRow = orderToPlutoRow(updatedOrder);

      // Remove the old row and insert the updated row at the same index
      stateManager!.removeRows([stateManager!.rows[index]]);
      stateManager!.insertRows(index, [updatedRow]);
    }

    orders.refresh(); // Refresh the orders list to notify the UI
  }

// convert order model into PlutoRow and return it
  PlutoRow orderToPlutoRow(OrderModel order) {
    return PlutoRow(cells: {
      'customerID': PlutoCell(value: order.customerId),
      'customerName': PlutoCell(value: order.customerName),
      'branchName': PlutoCell(value: order.branchName),
      'trip': PlutoCell(value: order.trip),
      'quantity': PlutoCell(value: order.quantity.toString()),
    });
  }

// convert  PlutoRow into order model and return it
  OrderModel plutoRowToOrder(PlutoRow row) {
    return OrderModel(
      customerId: row.cells['customerID']!.value,
      customerName: row.cells['customerName']!.value,
      branchName: row.cells['branchName']!.value,
      trip: row.cells['trip']!.value,
      quantity: int.parse(row.cells['quantity']!.value),
    );
  }
   final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      width: 150,
      titlePadding: EdgeInsets.all(8),
      title: 'Customer ID',
      field: 'customerID',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      width: 150,
      titlePadding: EdgeInsets.all(8),
      title: 'Customer Name',
      field: 'customerName',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      width: 150,
      titlePadding: EdgeInsets.all(8),
      title: 'Branch Name',
      field: 'branchName',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      width: 100,
      titlePadding: EdgeInsets.all(8),
      title: 'Trip',
      field: 'trip',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      width: 150,
      titlePadding: EdgeInsets.all(8),
      title: 'Quantity (kg)',
      field: 'quantity',
      type: PlutoColumnType.text(),
    ),
  ];
}
