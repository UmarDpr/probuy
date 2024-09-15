import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:pro_buy/screens/products_screens/products_view.dart';
import '../../fire_base/fire_base_controller.dart';
import '../../style/common_colors.dart';
import '../../style/common_size.dart';
import '../../style/text_style.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_entry_field.dart';
import '../../widgets/snack_bar.dart';

class ProductsEntryScreen extends StatefulWidget {
  final String? productName,brandName,category,subCategory,mrp,sp,description,availableCount;
  const ProductsEntryScreen({super.key, this.productName, this.brandName, this.category, this.subCategory, this.mrp, this.sp, this.description, this.availableCount});

  @override
  State<ProductsEntryScreen> createState() => _ProductsEntryScreenState();
}

class _ProductsEntryScreenState extends State<ProductsEntryScreen> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late DropzoneViewController dropzoneController;
  bool isImageUpload = false,isAddProduct = true;
  List<dynamic> imageDetails = [];
  TextEditingController searchController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  TextEditingController spController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController availableCountController = TextEditingController();

  @override
  void initState() {
  super.initState();
  if(editData.isNotEmpty) {
    setState(() {
      categoryController.text = editData[0]['Category'] ?? "";
      subCategoryController.text = editData[0]['SubCategory'] ?? "";
      productNameController.text = editData[0]['ProductName'] ?? "";
      brandNameController.text = editData[0]['BrandName'] ?? "";
      mrpController.text = editData[0]['MRP'] ?? "";
      spController.text = editData[0]['SP'] ?? "";
      descriptionController.text = editData[0]['Description'] ?? "";
      availableCountController.text = editData[0]['AvailableCount'] ?? "";
      imageDetails.addAll(editData[0]['imageDetails']);
    });
  }
  }

  void clearFun() {
    setState(() {
      categoryController.text = "";
      subCategoryController.text = "";
      productNameController.text = "";
      brandNameController.text = "";
      mrpController.text = "";
      spController.text = "";
      availableCountController.text = "";
      descriptionController.text = "";
      imageDetails.clear();
    });
  }

  void validationFun() {
    if (categoryController.text.isEmpty ||
        subCategoryController.text.isEmpty ||
        productNameController.text.isEmpty ||
        brandNameController.text.isEmpty ||
        mrpController.text.isEmpty ||
        spController.text.isEmpty ||
        availableCountController.text.isEmpty ||
        imageDetails.isEmpty) {
      StackDialog.show(
          "Required field is missing",
          "Please fill all mandatory fields",
          Icons.warning_amber,
          Colors.orange);
    } else {
      if(editData.isNotEmpty ){
        updateProductDetails();
    }else{
        saveProductDetails();
      }
    }
  }

  Future<void> updateProductDetails() async {
    Map<String, dynamic> productData = {
      "Id": editData[0]['Id'],
      "Category": categoryController.text,
      "SubCategory": subCategoryController.text,
      "ProductName": productNameController.text,
      "BrandName": brandNameController.text,
      "MRP": mrpController.text,
      "SP": spController.text,
      "AvailableCount": availableCountController.text,
      "Description": descriptionController.text,
      "imageDetails": imageDetails,
    };
    await FireStore().update("Products", editData[0]['Id'], productData).then((value) {
      StackDialog.show("Success", "Your product updated successfully",
          Icons.verified, Colors.greenAccent);
      clearFun();
      setState(() {
        // isAddProduct = false;
      });
    });
  }

  Future<void> saveProductDetails() async {
    QuerySnapshot snapshot = await _fireStore.collection('Products').get();
    int docCount = snapshot.size;
    String newDocId = 'P_${docCount + 1}';

    Map<String, dynamic> productData = {
      "Id": newDocId,
      "Category": categoryController.text,
      "SubCategory": subCategoryController.text,
      "ProductName": productNameController.text,
      "BrandName": brandNameController.text,
      "MRP": mrpController.text,
      "SP": spController.text,
      "AvailableCount": availableCountController.text,
      "Description": descriptionController.text,
      "imageDetails": imageDetails,
    };

    await FireStore().save("Products", newDocId, productData).then((value) {
      StackDialog.show("Success", "Your product added successfully",
          Icons.verified, Colors.greenAccent);
      clearFun();
      setState(() {
        // isAddProduct = false;
      });
    });
  }

  Future acceptFile(dynamic event) async {
    final name = event.name;
    final bytes = await dropzoneController.getFileSize(event);
    final size = bytes / 1024;
    setState(() {
      isImageUpload = true;
    });

    /// Upload To FireStore
    Uint8List fileData = await dropzoneController.getFileData(event);
    String filePath = 'products/${DateTime.now().millisecondsSinceEpoch}_$name';
    FireStore().uploadFileFromFireStorage(filePath, fileData).then((url) {
      setState(() {
        imageDetails.add(
          {
            "url": url,
            "name": name,
            "size": "${size.toStringAsFixed(2)} KB",
            "path": filePath
          },
        );
        isImageUpload = false;
      });
    });
  }

  Future<void> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (result != null && result.files.isNotEmpty) {
      Uint8List fileData = result.files.first.bytes!;
      String fileName = result.files.first.name;
      int size = result.files.first.size;
      final size1 = size / 1024;
      setState(() {
        isImageUpload = true;
      });

      /// Upload To FireStore
      String filePath =
          'products/${DateTime.now().millisecondsSinceEpoch}_$fileName';
      FireStore().uploadFileFromFireStorage(filePath, fileData).then((url) {
        setState(() {
          imageDetails.add(
            {
              "url": url,
              "name": fileName,
              "size": "${size1.toStringAsFixed(2)} KB",
              "path": filePath,
            },
          );
          isImageUpload = false;
        });
      });
    }
  }

  Future<void> deleteImage(int index) async {
    String filePath = imageDetails[index]["path"]!;
    FireStore()
        .deleteFileFromFireStorage(filePath)
        .then((value) => setState(() {
      imageDetails.removeAt(index);
    }));

  }

  @override
  Widget build(BuildContext context) {
    return     isAddProduct == false ?
    const ProductsViewScreen() :  Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: (){
                        setState(() {
                          isAddProduct = false;
                        });
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  const SizedBox(width: 5,),
                  Text(
                    "Add Product",
                    style: body4(Colors.black, FontWeight.w500),
                  ),
                ],
              ),
              commonElevatedButton(
                  secondary,
                  primary,
                   Row(
                    children: [
                      const Icon(Icons.save),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(editData.isNotEmpty ? "Update" : "Save")
                    ],
                  ),
                  body2(primary, FontWeight.w500), () {
                validationFun();
              }),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: Colors.grey.shade200)),
                width: displayWidth(context) * 0.4,
                child: Column(children: [
                  CommonEntryField(
                    fieldName: "Category",
                    readOnly: false,
                    isMandatory: true,
                    isNumeric: false,
                    isEmail: false,
                    controller: categoryController,
                  ),
                  CommonEntryField(
                    fieldName: "Sub Category",
                    readOnly: false,
                    isMandatory: true,
                    isNumeric: false,
                    isEmail: false,
                    controller: subCategoryController,
                  ),
                  CommonEntryField(
                    fieldName: "Product Name",
                    readOnly: false,
                    isMandatory: true,
                    isNumeric: false,
                    isEmail: false,
                    controller: productNameController,
                  ),
                  CommonEntryField(
                    fieldName: "Brand Name",
                    readOnly: false,
                    isMandatory: true,
                    isNumeric: false,
                    isEmail: false,
                    controller: brandNameController,
                  ),
                  CommonEntryField(
                    fieldName: "MRP",
                    readOnly: false,
                    isMandatory: true,
                    isNumeric: true,
                    isEmail: false,
                    controller: mrpController,
                  ),
                  CommonEntryField(
                    fieldName: "Selling Price",
                    readOnly: false,
                    isMandatory: true,
                    isNumeric: true,
                    isEmail: false,
                    controller: spController,
                  ),
                  CommonEntryField(
                    fieldName: "Available Count",
                    readOnly: false,
                    isMandatory: true,
                    isNumeric: true,
                    isEmail: false,
                    controller: availableCountController,
                  ),
                  CommonEntryField(
                    fieldName: "Description",
                    readOnly: false,
                    isMandatory: false,
                    isNumeric: false,
                    isEmail: false,
                    controller: descriptionController,
                  ),
                ]),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: Colors.grey.shade200)),
                width: displayWidth(context) * 0.4,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Image",
                        style: body3(Colors.black, FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        // height: displayHeight(context) * 0.3,
                        child: DottedBorder(
                          color: secondaryLight,
                          radius: const Radius.circular((8.0)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 150,
                                child: Stack(
                                  children: [
                                    DropzoneView(
                                      operation: DragOperation.copy,
                                      cursor: CursorType.grab,
                                      onCreated: (dropzoneController) =>
                                      this.dropzoneController =
                                          dropzoneController,
                                      onDrop: acceptFile,
                                    ),
                                    isImageUpload == false
                                        ? SizedBox(
                                        width: double.infinity,
                                        child: Image.asset(
                                          "assets/images/image.png",
                                          height: 150,
                                        ))
                                        : const Center(
                                        child:
                                        CircularProgressIndicator()),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (isImageUpload == false)
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      color: secondary,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Drop files here OR",
                                      style: body3(
                                          Colors.grey, FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        uploadFile();
                                      },
                                      child: Text("Browse",
                                          style: body3(
                                              secondary, FontWeight.w500)),
                                    )
                                  ],
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (imageDetails.isNotEmpty)
                        SingleChildScrollView(
                          child: SizedBox(
                            height: displayHeight(context) * 0.65,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: imageDetails.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                final data = imageDetails[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      border: Border.all(
                                          color: Colors.grey.shade200),
                                    ),
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width:
                                              70, // Adjust width as needed
                                              child: Image.network(
                                                data['url'],
                                                loadingBuilder: (BuildContext
                                                context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                    loadingProgress) {
                                                  if (loadingProgress ==
                                                      null) return child;
                                                  return Center(
                                                    child:
                                                    CircularProgressIndicator(
                                                      value: loadingProgress
                                                          .expectedTotalBytes !=
                                                          null
                                                          ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (context,
                                                    error, stackTrace) {
                                                  print(
                                                      "Error loading image: $error");
                                                  return const Center(
                                                    child: Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Text(
                                                  data['name'],
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                                Text(
                                                  data['size'],
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            deleteImage(index);
                                          },
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                    ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
