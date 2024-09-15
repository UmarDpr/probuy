import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:pro_buy/fire_base/fire_base_controller.dart';
import 'package:pro_buy/screens/products_screens/products_view.dart';
import 'package:pro_buy/style/common_colors.dart';
import 'package:pro_buy/style/common_size.dart';
import 'package:pro_buy/style/text_style.dart';
import 'package:pro_buy/widgets/common_button.dart';
import 'package:pro_buy/widgets/common_entry_field.dart';
import 'package:pro_buy/widgets/snack_bar.dart';
import 'package:pro_buy/widgets/text_field.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late DropzoneViewController dropzoneController;
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
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Stream? productDataStream;
  String? url;
  bool isAddProduct = false, isImageUpload = false;

  @override
  void initState() {
    super.initState();
    getProductDetails();
  }

  Future<void> getProductDetails() async {
    productDataStream = await FireStore().select("Products");
    setState(() {});
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
      updateProductDetails();
    }
  }

  Future<void> updateProductDetails() async {
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
        isAddProduct = false;
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
    return Container(
      color: Colors.grey.shade50,
      child: const ProductsViewScreen(),
    );
  }

  Widget productDetailsWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: SizedBox(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: 45,
                  width: displayWidth(context) * 0.18,
                  child: commonSearchField(searchController, (p0) {})),
              commonElevatedButton(
                  secondary,
                  primary,
                  const Row(
                    children: [Icon(Icons.add), Text("Add New")],
                  ),
                  body2(primary, FontWeight.w500), () {
                  setState(() {
                  isAddProduct = true;
                });
              }),
            ],
          )),
        ),
        StreamBuilder(
          stream: productDataStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: displayHeight(context) * 0.76,
                child: snapshot.hasData
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: kIsWeb == true ? 5 : 4,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 24,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 0.38),
                        ),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data.docs[index];
                          return Container(
                            // width: 200,
                            // height: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade200),
                                color: primary,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 2),
                                    spreadRadius: 0.0,
                                    blurRadius: 20,
                                    color: const Color(0xffffff).withOpacity(1),
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['BrandName'],
                                    style: body3(Colors.black, FontWeight.w500),
                                  ),
                                  Text(
                                    data['ProductName'],
                                    style: body2(Colors.grey, FontWeight.w400),
                                  ),
                                  Image.network(
                                    data['imageDetails'][0]['url'],
                                    height: displayHeight(context) * 0.25,
                                    fit: BoxFit.fitHeight,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      commonButton(
                                          displayWidth(context) * 0.06,
                                          40,
                                          secondary,
                                          12.0,
                                          Center(
                                            child: Text(
                                              "Edit",
                                              style: body2(Colors.white,
                                                  FontWeight.w400),
                                            ),
                                          ),
                                          () {
                                            setState(() {
                                              categoryController.text = data['Category'];
                                              subCategoryController.text = data['SubCategory'];
                                              productNameController.text = data['ProductName'];
                                              brandNameController.text = data['BrandName'];
                                              mrpController.text = data['MRP'];
                                              spController.text = data['SP'];
                                              availableCountController.text = data['AvailableCount'];
                                              descriptionController.text = data['Description'];
                                              imageDetails.addAll(data['imageDetails']);
                                             isAddProduct = true;
                                            });
                                          }),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text("₹ ${data['MRP']}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey.shade500,
                                                  decoration: TextDecoration
                                                      .lineThrough)),
                                          Text(
                                            "₹ ${data['SP']}",
                                            style: body5(
                                                Colors.black, FontWeight.w500),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                    : Center(
                        child: Text("No Products Available",
                            style: body2(Colors.grey, FontWeight.w400))),
              ),
            );
          },
        )
      ],
    );
  }

  Widget addProductWidget(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        width: double.infinity,
        height: displayHeight(context) * 0.86,
        decoration: BoxDecoration(
            color: primary, borderRadius: BorderRadius.circular(8.0)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Product",
                    style: body4(Colors.black, FontWeight.w500),
                  ),
                  commonElevatedButton(
                      secondary,
                      primary,
                      const Row(
                        children: [
                          Icon(Icons.save),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Save")
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
                            height: displayHeight(context) * 0.3,
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
        ),
      ),
    );
  }
}
