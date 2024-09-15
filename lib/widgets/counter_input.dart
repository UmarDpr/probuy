import 'package:flutter/material.dart';
import 'package:pro_buy/widgets/snack_bar.dart';

import '../style/text_style.dart';

class CounterInputWidget extends StatefulWidget {
  final Function(int) onChange;
  const CounterInputWidget({super.key, required this.onChange});

  @override
  State<CounterInputWidget> createState() => _CounterInputWidgetState();
}

class _CounterInputWidgetState extends State<CounterInputWidget> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: Colors.grey.shade200)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: (){
                if(count > 1){
                  setState(() {
                    count --;
                  });
                  widget.onChange(count);
                }
                else{
                  StackDialog.show("Need at least 1 qty to place your order  ", "Cannot decrease", Icons.add_alert, Colors.orange);
                }
              },
              child: const Icon(Icons.remove,size: 20,)),
          const SizedBox(width: 8,),
          Text("$count",style: body3(Colors.black, FontWeight.w500),),
          const SizedBox(width: 8,),
          InkWell(
              onTap: (){
                setState(() {
                  count ++;
                });
                widget.onChange(count);
              },
              child: const Icon(Icons.add,size: 20)),
        ],
      ),
    );
  }
}
