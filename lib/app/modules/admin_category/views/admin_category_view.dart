import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rental/app/components/mybutton.dart';
import 'package:rental/app/modules/vehicle/controllers/vehicle_controller.dart';
import '../controllers/admin_category_controller.dart';

class AdminCategoryView extends GetView<AdminCategoryController> {
  const AdminCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AdminCategoryController());
    Get.put(VehicleController());
    var categoryController = Get.put(AdminCategoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: GetBuilder<VehicleController>(
        builder: (controller) {
          if (controller.categoriesResponse == null ||
              controller.categoriesResponse!.categories == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var categories = controller.categoriesResponse!.categories!;

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              var category = categories[index];
              var isDeleted = category.isDeleted == '1';
              return ListTile(
                title: Text(category.category ?? ''),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(isDeleted
                              ? 'Restore Confirmation'
                              : 'Delete Confirmation'),
                          content: Text(isDeleted
                              ? 'Are you sure you want to restore this category?'
                              : 'Are you sure you want to delete this category?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Get.close(1);
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                categoryController.updateCategoryStatus(
                                    category.categoryId!, !isDeleted);
                                Get.close(1);
                              },
                              child: Text('Confirm'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    isDeleted ? Icons.restore : Icons.delete,
                    color: isDeleted ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2E9E95),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AddCategoryDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AdminCategoryController>();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.categoryTitle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category Title',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                onPressed: controller.addCategory,
                text: 'Add Category',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
