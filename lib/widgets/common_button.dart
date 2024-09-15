import 'package:flutter/material.dart';
import '../style/common_colors.dart';

gradientButton(double width, double height, double borderRadius,Widget child,void Function() onTap){
  return InkWell(
    onTap: onTap,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius:  BorderRadius.all(Radius.circular(borderRadius)),
          gradient:const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xff00B4DB),
              Color(0xff0083B0),
            ],
            stops: <double>[0.1, 0.8],
            tileMode: TileMode.clamp,
          )
      ),
      child:  child,
    ),
  );
}

commonButton(double width, double height,Color btnColor,double borderRadius,Widget child,void Function() onTap){
  return InkWell(
    onTap: onTap,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius:  BorderRadius.all(Radius.circular(borderRadius)),
         color: btnColor
      ),
      child:  child,
    ),
  );
}

commonElevatedButton(Color fillColor, Color btnTextColor, Widget labelChild,
        TextStyle labelStyle,void Function() onPressed,) =>
    ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          surfaceTintColor: fillColor,
          backgroundColor: fillColor,
          disabledBackgroundColor: fillColor,
          //button's fill color
          foregroundColor: btnTextColor,
          //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
          disabledForegroundColor: secondary,
          //specify the button's disabled text, icon, and fill color
          shadowColor: Colors.grey.shade50,
          //specify the button's elevation color
          elevation: 4.0,
          //buttons Material shadow
          textStyle: labelStyle,
          //specify the button's text TextStyle
          // padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 8.0, left: 8.0), //specify the button's Padding
          // minimumSize: const Size(20, 40), //specify the button's first: width and second: height
          // side: const BorderSide(color: Colors.yellow, width: 2.0, style: BorderStyle.solid), //set border for the button
          enabledMouseCursor: MouseCursor.defer,
          //used to construct ButtonStyle.mouseCursor
          disabledMouseCursor: MouseCursor.uncontrolled,
          //used to construct ButtonStyle.mouseCursor
          visualDensity: const VisualDensity(horizontal: 0.0, vertical: 0.0),
          //set the button's visual density
          tapTargetSize: MaterialTapTargetSize.padded,
          // set the MaterialTapTarget size. can set to: values, padded and shrinkWrap properties
          animationDuration: const Duration(milliseconds: 100),
          //the buttons animations duration
          enableFeedback: true,
          //to set the feedback to true or false
          alignment: Alignment.center, //set the button's child Alignment
        ),
        onPressed: onPressed,
        //set both onPressed and onLongPressed to null to see the disabled properties
        onLongPress: () => {},
        //set both onPressed and onLongPressed to null to see the disabled properties
        child: labelChild);
