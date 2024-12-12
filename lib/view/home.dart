import 'view_export.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(OrderSheetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.kWhiteColor,
        elevation: 0,
        surfaceTintColor: AppColor.kWhiteColor,
        toolbarHeight: 60,
        title: TextComponents(
          title: 'Pending  Work  Orders',
          size: 30.sp,
          weight: FontWeight.w600,
          color: AppColor.KBlacks,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(6),
        child: FloatingActionButton(
          backgroundColor: AppColor.KBlacks,
          onPressed: () => controller.addOrder(),
          child: const Icon(
            Icons.add,
            color: AppColor.kWhiteColor,
          ),
        ),
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlutoGrid(
              mode: PlutoGridMode.select,
              columns: controller.columns,
              rows: controller.orders
                  .map((order) => controller.orderToPlutoRow(order))
                  .toList(),
              onRowDoubleTap: (event) async {
                //we get here current row which is selected by user
                final selectedRow = controller.stateManager?.currentRow;
                // here we check if it's not null
                if (selectedRow != null) {
                  // we Convert the selected row to OrderModel
                  final selectedOrder = controller.plutoRowToOrder(selectedRow);

                  // Find the index of the order based on a unique field (like customerId)
                  final index = controller.orders.indexWhere((order) =>
                      order.customerId ==
                      selectedOrder
                          .customerId); // Use customerId for uniqueness

                  // Navigate to the EditView and await the updated order
                  OrderModel? updatedOrder =
                      await Get.to(() => EditView(order: selectedOrder));

                  print('after return data ${updatedOrder?.quantity}');

                  if (updatedOrder != null && index != -1) {
                    controller.updateOrder(index, updatedOrder);
                  }
                }
              },
              onChanged: (PlutoGridOnChangedEvent event) {
                print(event);
              },
              configuration: PlutoGridConfiguration(
                  scrollbar:
                      PlutoGridScrollbarConfig(scrollBarColor: AppColor.KBody),
                  style: PlutoGridStyleConfig(
                    columnTextStyle: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    cellTextStyle: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    defaultCellPadding: EdgeInsets.zero,
                    defaultColumnFilterPadding: EdgeInsets.zero,
                    defaultColumnTitlePadding: EdgeInsets.zero,
                    enableCellBorderHorizontal: false,
                    enableCellBorderVertical: false,
                    enableColumnBorderHorizontal: false,
                    activatedColor: AppColor.kWhiteColor,
                    oddRowColor: AppColor.klightBlue,
                    evenRowColor: AppColor.KBody,
                    enableColumnBorderVertical: false,
                  )),
              onLoaded: (PlutoGridOnLoadedEvent event) {
                controller.initializeStateManager(event.stateManager);
                print('StateManager initialized successfully');
              },
            ),
          )),
    );
  }
}
