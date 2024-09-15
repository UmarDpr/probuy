import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_buy/screens/dashboard.dart';
import 'package:pro_buy/screens/home_screens/home_main.dart';
import 'package:pro_buy/screens/orders.dart';
import 'package:pro_buy/screens/products_screens/products_view.dart';
import 'package:pro_buy/style/common_colors.dart';
import 'package:pro_buy/style/common_size.dart';
import 'package:pro_buy/style/text_style.dart';

import '../style/responsive.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  String menuName = "Home";
  List<bool>? _isHovering;

  final List<Map<String, dynamic>> menus = [
    {"id":1,"name":"Dashboard","icon":"Icons.dashboard_customize_outlined"},
    {"id":2,"name":"Home","icon":"Icons.home_outlined"},
    {"id":3,"name":"Products","icon":"Icons.shopping_cart_outlined"},
    {"id":4,"name":"Orders","icon":"Icons.shopping_bag_outlined"},
  ];

  IconData getIconData(String iconName) {
    switch (iconName) {
      case "Icons.dashboard_customize_outlined":
        return Icons.dashboard_customize_outlined;
      case "Icons.home_outlined":
        return Icons.home_outlined;
      case "Icons.shopping_cart_outlined":
        return Icons.shopping_cart_outlined;
      case "Icons.shopping_bag_outlined":
        return Icons.shopping_bag_outlined;
      default:
        return Icons.help_outline;
    }
  }

  IconData getIconDataHovered(String iconName) {
    switch (iconName) {
      case "Icons.dashboard_customize_outlined":
        return Icons.dashboard_customize;
      case "Icons.home_outlined":
        return Icons.home;
      case "Icons.shopping_cart_outlined":
        return Icons.shopping_cart;
      case "Icons.shopping_bag_outlined":
        return Icons.shopping_bag;
      default:
        return Icons.help;
    }
  }

  Widget? menuRouting(){
    switch (menuName) {
      case "Dashboard":
        return const Dashboard();
      case "Home":
        return const HomeMainScreen();
      case "Products":
        return const ProductsViewScreen();
      case "Orders":
        return const Orders();
      default:
        return const Dashboard();
    }

  }

  @override
  void initState() {
    super.initState();
    _isHovering = List.filled(menus.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return  Responsive(
      mobile: mobileView(context),
      desktop:  webView(context),
    );
  }

  Widget mobileView(context){
    return const Scaffold();
  }
  Widget webView(context){
    return Scaffold(
     body: Container(
       color: Colors.white,
       child: Row(
         children: [
           Container(
             decoration: BoxDecoration(
                 color: Colors.grey.shade50,
                 border: Border(right: BorderSide(color: Colors.grey.shade300,width: 1))
             ),
             width: displayWidth(context) * 0.13,
             height: double.infinity,
             child: Column(
               children: [

                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 20.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(
                         Icons.category,color: secondary,
                       ),
                       const SizedBox(width: 5,),
                       Text('ProBuy',
                           style: GoogleFonts.pacifico(
                               textStyle:  TextStyle(
                                 fontSize: 20,
                                   color: secondary, fontWeight: FontWeight.w500))),
                     ], 
                   ),
                 ),

                 Expanded(
                   child: ListView.builder(
                       itemCount: menus.length,
                       itemBuilder: (context,index){
                       final data = menus[index];
                     return MouseRegion(
                       onEnter: (_) {
                         setState(() {
                           _isHovering![index] = true;
                         });
                       },
                       onExit: (_) {
                         setState(() {
                           _isHovering![index] = false;
                         });
                       },
                       child: InkWell(
                         onTap: (){
                           setState(() {
                             menuName = data['name'];
                           });
                           menuRouting();
                         },
                         child: Container(
                           color: _isHovering![index] ?  secondary : Colors.transparent,
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 14),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 Icon(_isHovering![index] == true ? getIconDataHovered(data['icon']) : getIconData(data['icon'])   ,color: _isHovering![index] == true ? primary : Colors.black,),
                                 const SizedBox(width: 10,),
                                 Text("${data['name']}",style: body3(_isHovering![index] == true ? primary : Colors.black, FontWeight.w500),)
                               ],
                             ),
                           ),
                         ),
                       ),
                     );
                   }),
                 )
               ],
             ),
           ),
           Expanded(
             child: Column(
               children: [
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                   // height: displayHeight(context) * 0.08,
                   decoration: BoxDecoration(
                       border: Border(
                           bottom: BorderSide(color: Colors.grey.shade300, width: 1))),
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 22.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           "Home",
                           style: body5(Colors.black, FontWeight.w600),
                         ),
                         SizedBox(
                           width: displayWidth(context) * 0.08,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               const Icon(
                                 Icons.notifications,
                                 size: 30,
                               ),
                               CircleAvatar(
                                 backgroundColor: secondary,
                                 radius: 16,
                                 child: Text(
                                   "A",
                                   style: body3(Colors.white, FontWeight.w500),
                                 ),
                               ),
                               const Icon(Icons.keyboard_arrow_down_sharp),
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
                 Expanded(
                   // flex: 6,6
                   child: SingleChildScrollView(
                     child: Container(
                       child: menuRouting(),
                     ),
                   ),
                 ),
               ],
             ),
           )
         ],
       ),
     ),
    );
  }
}
