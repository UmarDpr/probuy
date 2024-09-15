import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pro_buy/screens/home_screens/home_main.dart';
import 'package:pro_buy/widgets/counter_input.dart';
import 'package:pro_buy/widgets/stepper_widget.dart';
import '../../fire_base/fire_base_controller.dart';
import '../../style/common_colors.dart';
import '../../style/common_size.dart';
import '../../style/text_style.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_entry_field.dart';
import '../../widgets/snack_bar.dart';

class HomeDetailScreen extends StatefulWidget {

  const HomeDetailScreen({super.key});

  @override
  State<HomeDetailScreen> createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends State<HomeDetailScreen> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController doorNoController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  StepperObject step = StepperObject.first;
  bool isFirstEntry = true,isBuyDetails = true;

  final List<String> items = [
    'S',
    'M',
    'XL',
    'XXL',
  ];

  String? selectedSize,quantity;

  @override
  void initState() {
    super.initState();
  }

  void validationFun() {
    if (nameController.text.isEmpty ||
        phoneNoController.text.isEmpty ||
        doorNoController.text.isEmpty ||
        streetController.text.isEmpty ||
        areaController.text.isEmpty ||
        cityController.text.isEmpty ||
        pinCodeController.text.isEmpty) {
      StackDialog.show(
          "Required field is missing",
          "Please fill all mandatory fields",
          Icons.warning_amber,
          Colors.orange);
    } else {
      saveCustomerDetails();
    }
  }

  Future<void> saveCustomerDetails() async {
    QuerySnapshot snapshot = await _fireStore.collection('Customer_Details').get();
    int docCount = snapshot.size;
    String newDocId = 'Cus_${docCount + 1}';

    Map<String, dynamic> customerData = {
      "Id": newDocId,
      "Name": nameController.text,
      "PhoneNo": phoneNoController.text,
      "DoorNo": doorNoController.text,
      "Street": streetController.text,
      "Area": areaController.text,
      "City": cityController.text,
      "Pin": pinCodeController.text,
    };

    await FireStore().save("Customer_Details", newDocId, customerData).then((value) {
      StackDialog.show("Success", "Address saved successfully", Icons.verified, Colors.greenAccent);
      setState(() {
        // step = StepperObject.second;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return isBuyDetails == false ? const HomeMainScreen() :
    Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: (){
                          setState(() {
                            isBuyDetails = false;
                          });
                        },
                        child: const Icon(Icons.arrow_back_ios,size: 20,)),
                    const SizedBox(width: 5,),
                    Text(
                      "Product Details",
                      style: body4(Colors.black, FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: Colors.grey.shade200)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: displayWidth(context) * 0.06,
                              height: displayHeight(context) * 0.6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: displayHeight(context) * 0.13,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(8.0)),
                                        border: Border.all(color: Colors.grey.shade200)),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                        child: Image.network(buyData[0]['imageDetails'][0]['url'],fit: BoxFit.fitHeight,)),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: displayHeight(context) * 0.13,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(8.0)),
                                        border: Border.all(color: Colors.grey.shade200)),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                        child: Image.network(buyData[0]['imageDetails'][0]['url'],fit: BoxFit.fitHeight,)),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: displayHeight(context) * 0.13,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(8.0)),
                                        border: Border.all(color: Colors.grey.shade200)),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                        child: Image.network(buyData[0]['imageDetails'][0]['url'],fit: BoxFit.fitHeight,)),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: displayHeight(context) * 0.13,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        const BorderRadius.all(Radius.circular(8.0)),
                                        border: Border.all(color: Colors.grey.shade200)),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                        child: Image.network(buyData[0]['imageDetails'][0]['url'],fit: BoxFit.fitHeight,)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              width: displayWidth(context) * 0.3,
                              height: displayHeight(context) * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                                  border: Border.all(color: Colors.grey.shade200)),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                  child: Image.network(buyData[0]['imageDetails'][0]['url'],fit: BoxFit.fitHeight,)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        flex: 1,
                        // height: displayHeight(context) * 0.4,
                        child: SizedBox(
                          height: displayHeight(context) * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(buyData[0]['BrandName'] ?? "" ,style: body3(Colors.black, FontWeight.w500),),
                              Text(buyData[0]['ProductName'] ?? "" ,style: body4(Colors.black, FontWeight.w600),),
                              Text(buyData[0]['Description'] ?? "" ,style: body3(Colors.grey, FontWeight.w500),),
                              Row(
                                children: [
                                  Text("Price : " ,style: body4(Colors.black, FontWeight.w600),),
                                  Text("₹ ${buyData[0]['SP'] ?? ""}" ,style: body4(Colors.black, FontWeight.w600),),
                                  const SizedBox(width: 5,),
                                  Text("₹ ${buyData[0]['MRP'] ?? " " }",style: underLineTxt(Colors.grey.shade500, FontWeight.w500, 14),),
                                ],
                              ),
                              SizedBox(
                                width: displayWidth(context) * 0.2,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex : 1,
                                            child: Text("Select Size" ,style: body3(Colors.black, FontWeight.w500),)),
                                        Expanded(
                                          flex: 2,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2<String>(
                                              isExpanded: true,
                                              hint: Text(
                                                'Choose your Size',
                                                style: body1(Colors.grey, FontWeight.w500),
                                              ),
                                              items: items
                                                  .map((String item) => DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                                  .toList(),
                                              value: selectedSize,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedSize = value;
                                                });
                                              },
                                              buttonStyleData:  ButtonStyleData(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    const BorderRadius.all(Radius.circular(8.0)),
                                                    border: Border.all(color: Colors.grey.shade200)
                                                ),
                                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                                height: 32,
                                                width: 140,
                                              ),
                                              dropdownStyleData: DropdownStyleData(
                                                maxHeight: 200,
                                                width: 140,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14),
                                                    color: Colors.white
                                                ),
                                                scrollbarTheme: ScrollbarThemeData(
                                                  radius: const Radius.circular(40),
                                                  thickness: MaterialStateProperty.all(6),
                                                  thumbVisibility: MaterialStateProperty.all(true),
                                                ),
                                              ),
                                              menuItemStyleData: const MenuItemStyleData(
                                                height: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15,),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex : 1,
                                            child: Text("Quantity" ,style: body3(Colors.black, FontWeight.w500),)),
                                        Expanded(
                                          flex : 2,
                                          child: CounterInputWidget(onChange: (val) {
                                            setState(() {
                                              quantity = val.toString();
                                            });
                                          },),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  commonButton(
                                      displayWidth(context) * 0.08,
                                      40,
                                      secondary,
                                      8.0,
                                      Center(
                                        child: Text(
                                          "Buy Now",
                                          style: body2(Colors.white,
                                              FontWeight.w400),
                                        ),
                                      ),
                                          () async{
                                        stepperDialog();
                                      }),
                                  const SizedBox(width: 15,),
                                  commonButton(
                                      displayWidth(context) * 0.08,
                                      40,
                                      secondaryLight,
                                      8.0,
                                      Center(
                                        child: Text(
                                          "Add to cart",
                                          style: body2(Colors.black,
                                              FontWeight.w400),
                                        ),
                                      ),
                                          () async{

                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              ]),
            ),
          ),
        ],
      );
  }

  Future stepperDialog() async {
    return  await showDialog(context: context, builder: (BuildContext context){
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            content: SizedBox(
                width: displayHeight(context) * 1,
                // height: displayHeight(context) * 0.7,
                child:  StepperWidget(
                    step: step,
                    dynamicWidget: step == StepperObject.first ? addressDetails() : productSummary(),
                    dynamicButton: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(step != StepperObject.first)
                      commonButton( displayWidth(context) * 0.08,
                          40,
                          secondary,
                          8.0,
                          Center(
                            child: Text(
                              "Back",
                              style: body2(Colors.white,
                                  FontWeight.w400),
                            ),
                          ), () {
                            if (step == StepperObject.second) {
                              setState(() {
                                step = StepperObject.first;
                              });
                            } else if (step == StepperObject.third) {
                              setState(() {
                                step = StepperObject.second;
                              });
                            }
                          }),
                    const SizedBox(width: 10,),
                    commonButton( displayWidth(context) * 0.08,
                        40,
                        secondary,
                        8.0,
                        Center(
                          child: Text(
                            "Next",
                            style: body2(Colors.white,
                                FontWeight.w400),
                          ),
                        ), () async{
                          if (step == StepperObject.first  ) {
                            // if (nameController.text.isEmpty ||
                            //     phoneNoController.text.isEmpty ||
                            //     doorNoController.text.isEmpty ||
                            //     streetController.text.isEmpty ||
                            //     areaController.text.isEmpty ||
                            //     cityController.text.isEmpty ||
                            //     pinCodeController.text.isEmpty) {
                            //   StackDialog.show(
                            //       "Required field is missing",
                            //       "Please fill all mandatory fields",
                            //       Icons.warning_amber,
                            //       Colors.orange);
                            // } else {
                            //   if(isFirstEntry == true){
                            //     QuerySnapshot snapshot = await _fireStore.collection('Customer_Details').get();
                            //     int docCount = snapshot.size;
                            //     String newDocId = 'Cus_${docCount + 1}';
                            //     Map<String, dynamic> customerData = {
                            //       "Id": newDocId,
                            //       "Name": nameController.text,
                            //       "PhoneNo": phoneNoController.text,
                            //       "DoorNo": doorNoController.text,
                            //       "Street": streetController.text,
                            //       "Area": areaController.text,
                            //       "City": cityController.text,
                            //       "Pin": pinCodeController.text,
                            //     };
                            //     await FireStore().save("Customer_Details", newDocId, customerData).then((value) {
                            //       StackDialog.show("Success", "Address saved successfully", Icons.verified, Colors.greenAccent);
                            //       setState(() {
                            //         step = StepperObject.second;
                            //       });
                            //     });
                            //   }
                            //   else{
                            //     print(FireStore().select("Customer_Details"));
                            //   }
                            // }
                                  setState(() {
                                    step = StepperObject.second;
                                  });
                          } else if (step == StepperObject.second) {
                            setState(() {
                              isFirstEntry = false;
                              step = StepperObject.third;
                            });
                          }
                        })
                  ],)
                )
            ),
          );
        },

      );
    });

  }

  Widget addressDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Text("Enter Address Details" ,style: body4(Colors.black, FontWeight.w500),),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: displayWidth(context) * 0.2,
                child: Column(
                  children: [
                    CommonEntryField(
                      fieldName: "Name",
                      readOnly: false,
                      isMandatory: true,
                      isNumeric: false,
                      isEmail: false,
                      controller: nameController,
                    ),
                    CommonEntryField(
                      fieldName: "Door Number",
                      readOnly: false,
                      isMandatory: true,
                      isNumeric: false,
                      isEmail: false,
                      controller: doorNoController,
                    ),
                    CommonEntryField(
                      fieldName: "Area/LandMark",
                      readOnly: false,
                      isMandatory: true,
                      isNumeric: false,
                      isEmail: false,
                      controller: areaController,
                    ),
                    CommonEntryField(
                      fieldName: "Pin Code",
                      readOnly: false,
                      isMandatory: true,
                      isNumeric: false,
                      isEmail: false,
                      controller: pinCodeController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: displayWidth(context) * 0.2,
                child: Column(
                  children: [
                    CommonEntryField(
                      fieldName: "Phone Number",
                      readOnly: false,
                      isMandatory: true,
                      isNumeric: false,
                      isEmail: false,
                      controller: phoneNoController,
                    ),
                    CommonEntryField(
                      fieldName: "Street Name",
                      readOnly: false,
                      isMandatory: true,
                      isNumeric: false,
                      isEmail: false,
                      controller: streetController,
                    ),

                    CommonEntryField(
                      fieldName: "City Name",
                      readOnly: false,
                      isMandatory: true,
                      isNumeric: false,
                      isEmail: false,
                      controller: cityController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget productSummary() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          Text("Product Summary" ,style: body4(Colors.black, FontWeight.w500),),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8.0,),
                width: displayWidth(context) * 0.45,
                height: displayHeight(context) * 0.4,
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: Colors.grey.shade200)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: displayWidth(context) * 0.15,
                      height: displayHeight(context) * 0.35,
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(color: Colors.grey.shade200)),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          child: Image.network(buyData[0]['imageDetails'][0]['url'],fit: BoxFit.cover,)),
                    ),
                    const SizedBox(width: 10,),
                    SizedBox(
                      width: displayWidth(context) * 0.25,
                      height: displayHeight(context) * 0.35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text("Brand Name" ,style: body2(Colors.black, FontWeight.w500),)),
                              Text(" : " ,style: body2(Colors.black, FontWeight.w500),),
                              Expanded(
                                  flex: 1,
                                  child: Text(buyData[0]['BrandName'] ?? "" ,style: body2(Colors.black, FontWeight.w600),)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text("Product Name" ,style: body2(Colors.black, FontWeight.w500),)),
                              Text(" : " ,style: body2(Colors.black, FontWeight.w500),),
                              Expanded(
                                  flex: 1,
                                  child: Text(buyData[0]['ProductName'] ?? "" ,style: body2(Colors.black, FontWeight.w600),)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text("Size" ,style: body2(Colors.black, FontWeight.w500),)),
                              Text(" : " ,style: body2(Colors.black, FontWeight.w500),),
                              Expanded(
                                  flex: 1,
                                  child: Text(selectedSize ?? "" ,style: body2(Colors.black, FontWeight.w600),)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text("Quantity" ,style: body2(Colors.black, FontWeight.w500),)),
                              Text(" : " ,style: body2(Colors.black, FontWeight.w500),),
                              Expanded(
                                  flex: 1,
                                  child: Text(quantity ?? "1" ,style: body2(Colors.black, FontWeight.w600),)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text("Brand Name" ,style: body2(Colors.black, FontWeight.w500),)),
                              Text(" : " ,style: body2(Colors.black, FontWeight.w500),),
                              Expanded(
                                  flex: 1,
                                  child: Text(buyData[0]['BrandName'] ?? "" ,style: body2(Colors.black, FontWeight.w600),)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Text("Delivery Address" ,style: body4(Colors.black, FontWeight.w500),),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.all(8.0),
            width: displayWidth(context) * 0.3,
            decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(color: Colors.grey.shade200)),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person,color: secondary,),
                        const SizedBox(width: 5,),
                        Text(nameController.text ,style: body2(Colors.black, FontWeight.w500),),
                      ],
                    ),
                    const SizedBox(width: 10,),
                    Row(
                      children: [
                        Icon(Icons.phone_android,color: secondary,),
                        const SizedBox(width: 5,),
                        Text(phoneNoController.text ,style: body2(Colors.black, FontWeight.w500),),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.home,color: secondary,),
                    const SizedBox(width: 5,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("${doorNoController.text}, " ,style: body2(Colors.black, FontWeight.w500),),
                            Text("${streetController.text}, " ,style: body2(Colors.black, FontWeight.w500),),
                            Text("${areaController.text}, " ,style: body2(Colors.black, FontWeight.w500),),
                          ],
                        ),
                        Row(
                          children: [
                            Text("${cityController.text}, " ,style: body2(Colors.black, FontWeight.w500),),
                            Text("${pinCodeController.text}. " ,style: body2(Colors.black, FontWeight.w500),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

