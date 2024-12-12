 

import 'view_export.dart';
class EditView extends StatelessWidget {
  final OrderModel order;

  const EditView({required this.order});

  @override
  Widget build(BuildContext context) {
    final TextEditingController customerIdController =
        TextEditingController(text: order.customerId);
    final TextEditingController customerNameController =
        TextEditingController(text: order.customerName);
    final TextEditingController branchNameController =
        TextEditingController(text: order.branchName);
    final TextEditingController tripController =
        TextEditingController(text: order.trip);
    final TextEditingController quantityController =
        TextEditingController(text: order.quantity.toString());

    return Scaffold(
      backgroundColor: AppColor.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.kWhiteColor,
        elevation: 0,
        surfaceTintColor: AppColor.kWhiteColor,
        title: TextComponents(
          title: 'Edit Current Order',
          size: 15.sp,
          weight: FontWeight.w600,
          color: AppColor.KBlacks,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              CustomFieldComponents(
                  hint: 'Customer ID', controller: customerIdController),
              SizedBox(
                height: 14.h,
              ),
              CustomFieldComponents(
                  hint: 'Customer Name', controller: customerNameController),
              SizedBox(
                height: 14.h,
              ),
              CustomFieldComponents(
                  hint: 'Branch Name', controller: branchNameController),
              SizedBox(
                height: 14.h,
              ),
              CustomFieldComponents(hint: 'Trip', controller: tripController),
              SizedBox(
                height: 14.h,
              ),
              CustomFieldComponents(
                hint: 'Quantity',
                controller: quantityController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 30.h,
              ),
              PrimaryButton(
                  onTap: () {
                    final updatedOrder = OrderModel(
                      customerId: customerIdController.text,
                      customerName: customerNameController.text,
                      branchName: branchNameController.text,
                      trip: tripController.text,
                      quantity: int.parse(quantityController.text),
                    );
                    Get.back(result: updatedOrder);
                  },
                  childWidget: TextComponents(
                    title: 'Update',
                    size: 15.sp,
                    weight: FontWeight.w600,
                    color: AppColor.kWhiteColor,
                  ),
                  bgColor: AppColor.KBlacks)
            ],
          ),
        ),
      ),
    );
  }
}
