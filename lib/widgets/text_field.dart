import 'package:flutter/material.dart';
import '../style/common_colors.dart';


Widget commonTextField(double?height, double?width, bool readOnly, TextEditingController ?controller, InputDecoration?decoration,void Function(String)? onChange,bool isNumberKeyBord){
  return SizedBox(
          height: height,
          width: width,
          child: TextFormField(
           readOnly: readOnly,
           controller:controller,
           onChanged:onChange,
                    keyboardType: isNumberKeyBord == true ?  TextInputType.number : TextInputType.text,
                    style: const TextStyle(
           fontSize: 14,
           overflow:
           TextOverflow.ellipsis),
           cursorColor: secondary,
           decoration: decoration,
                ),
  );
}

Widget commonSearchField(TextEditingController? controller,void Function(String)? onChange){
  return TextFormField(
    controller: controller,
    onChanged:onChange,
    style: const TextStyle(
        fontSize: 14,
        overflow:
        TextOverflow.ellipsis),
    cursorColor: secondary,
    decoration:  InputDecoration(
      prefixIcon: const Icon(Icons.search),
      prefixIconColor: Colors.grey.shade600,
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: Color(0xffeaeaea),
          width: 1,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        borderSide: BorderSide(
          color: Color(0xffeaeaea),
          width: 1,
        ),
      ),
      hintText: "Search",
      hintStyle:TextStyle(
          fontSize: 12,
          overflow: TextOverflow.clip,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade600),
    ),
  );
}

Widget commonDatePickerField(double?height, double?width, TextEditingController ?controller, InputDecoration?decoration,void Function(String)? onChange ,void Function() onTap){
  return SizedBox(
    height: height,
    width: width,
    child: TextFormField(
      readOnly: true,
      controller:controller,
      onChanged:onChange,
      onTap: onTap,
      style: const TextStyle(
          fontSize: 14,
          overflow:
          TextOverflow.ellipsis),
      cursorColor: secondary,
      decoration: decoration,
    ),
  );
}

Widget commonTimePickerField(double?height, double?width, TextEditingController ?controller, InputDecoration?decoration,void Function(String)? onChange ,void Function() onTap){
  return SizedBox(
    height: height,
    width: width,
    child: TextFormField(
      readOnly: true,
      controller:controller,
      onChanged:onChange,
      onTap: onTap,
      style: const TextStyle(
          fontSize: 14,
          overflow:
          TextOverflow.ellipsis),
      cursorColor: secondary,
      decoration: decoration,
    ),
  );
}