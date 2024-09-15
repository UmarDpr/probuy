import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_buy/screens/products_screens/products_entry.dart';
import '../../fire_base/fire_base_controller.dart';
import '../../style/common_colors.dart';
import '../../style/common_size.dart';
import '../../style/text_style.dart';
import '../../widgets/common_button.dart';
import '../../widgets/text_field.dart';

RxList editData = [].obs;
class ProductsViewScreen extends StatefulWidget {
  const ProductsViewScreen({super.key});

  @override
  State<ProductsViewScreen> createState() => _ProductsViewScreenState();
}

class _ProductsViewScreenState extends State<ProductsViewScreen> {
  TextEditingController searchController = TextEditingController();
  Stream? productDataStream;
  bool isAddProduct = false;
  @override
  void initState() {
    super.initState();
    getProductDetails();
  }

  Future<void> getProductDetails() async {
    productDataStream = await FireStore().select("Products");
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      child: Column(
        children: [
          // Container(
          //   // height: displayHeight(context) * 0.08,
          //   decoration: BoxDecoration(
          //       border: Border(
          //           bottom: BorderSide(color: Colors.grey.shade300, width: 1))),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 22.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         SizedBox(
          //           child: Row(
          //             children: [
          //               if (isAddProduct == true)
          //                 InkWell(
          //                   onTap: () {
          //                     setState(() {
          //                       editData.clear();
          //                       isAddProduct = false;
          //                     });
          //                   },
          //                   child: const Icon(
          //                     Icons.arrow_back_ios,
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //               const SizedBox(
          //                 width: 5,
          //               ),
          //               Text(
          //                 "Products",
          //                 style: body5(Colors.black, FontWeight.w600),
          //               ),
          //             ],
          //           ),
          //         ),
          //         SizedBox(
          //           width: displayWidth(context) * 0.08,
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               const Icon(
          //                 Icons.notifications,
          //                 size: 30,
          //               ),
          //               CircleAvatar(
          //                 backgroundColor: secondary,
          //                 radius: 16,
          //                 child: Text(
          //                   "A",
          //                   style: body3(Colors.white, FontWeight.w500),
          //                 ),
          //               ),
          //               const Icon(Icons.keyboard_arrow_down_sharp),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          isAddProduct == true ?
          const ProductsEntryScreen() :
          Column(
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
                                editData.clear();
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
                      // height: displayHeight(context) * 0.76,
                      child: snapshot.hasData
                          ? GridView.builder(
                        shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: kIsWeb == true ? 5 : 4,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 24,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height / 0.34),
                          ),
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                            Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

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
                                                editData.assign(data);
                                                isAddProduct = true;
                                              });

                                            }),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            Text("₹ ${data['MRP']}",
                                                style:underLineTxt(Colors.grey.shade500, FontWeight.w400, 16)),
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
          ),
        ],
      ),
    );
  }
}
