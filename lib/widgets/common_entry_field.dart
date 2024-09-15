import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../style/common_colors.dart';
import '../style/text_style.dart';
import 'entry.dart';

class CommonEntryField extends StatefulWidget {
  const CommonEntryField({super.key,
    required this.fieldName,
    required this.readOnly,
    required this.isMandatory,
    required this.isNumeric,
    required this.isEmail,
    required this.controller,
  });
  final String fieldName;
  final bool readOnly;
  final bool isMandatory;
  final bool isNumeric;
  final bool isEmail;
  final TextEditingController controller;
  @override
  State<CommonEntryField> createState() => _CommonEntryFieldState();
}

class _CommonEntryFieldState extends State<CommonEntryField> {
  final _emailRegex = RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
  bool _isValidEmail = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isMandatory == true
              ? mandatoryHeader(widget.fieldName, body2(Colors.black, FontWeight.w400))
              : nonMandatoryHeader(widget.fieldName, body2(Colors.black, FontWeight.w400)),

          const SizedBox(height: 5,),
          TextFormField(
              keyboardType: widget.isNumeric == true ? TextInputType.number : TextInputType.multiline,
              controller: widget.controller,
              readOnly: widget.readOnly,
              style: const TextStyle(
                  fontSize: 14, overflow: TextOverflow.ellipsis),
              cursorColor: secondary,
              decoration:  InputDecoration(
                // suffixIcon: const Icon(Icons.arrow_drop_down_circle_rounded,color: Colors.white,),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:  Colors.grey.shade200)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:  Colors.grey.shade200)),
                  hintStyle: TextStyle(
                      letterSpacing: 0.6,
                      color: Colors.grey.shade400,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  hintText: "Enter ${widget.fieldName}",
              ),
              onChanged: (String value) {
                widget.isEmail == true ?
                setState(() {
                  _isValidEmail = _emailRegex.hasMatch(value);
                }) : null;
              },
              ),
          if(widget.isEmail == true )
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
            child: Text( _isValidEmail ? "" : 'Enter a valid email',style: const TextStyle(
              fontSize: 12,
              color: Colors.redAccent,
              fontWeight: FontWeight.w400,
            ),),
          )
        ],
      ),
    );
  }
}

