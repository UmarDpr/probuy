import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../style/common_colors.dart';
import '../style/common_size.dart';

enum  StepperObject {first,second,third,fourth,fifth,sixth,seventh,eighth,ninth,tenth}

class StepperWidget extends StatelessWidget {
  StepperObject step =StepperObject.first;
  Widget dynamicWidget,dynamicButton;
  StepperWidget({super.key,required this.step,required this.dynamicWidget,required this.dynamicButton});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: secondary,
                radius: 15,
                child: InkWell(
                  onTap: (){

                  },
                  child: const Icon(Icons.looks_one_rounded,
                      size: 15, color: Colors.white),
                ),
              ),
              SizedBox(
                  width: displayWidth(context) * 0.15,
                  child: Divider(
                      indent: 10,
                      endIndent: 10,
                      color: step == StepperObject.first
                          ? Colors.grey.shade300
                          : secondary,
                      thickness: 0.8)),
              CircleAvatar(
                radius: 15,
                backgroundColor: step == StepperObject.second || step == StepperObject.third || step == StepperObject.fourth || step == StepperObject.fifth || step == StepperObject.sixth
                    ? secondary
                    : Colors.grey.shade300,
                child: Icon(Icons.looks_two_rounded,
                    size: 15,
                    color:
                    step == StepperObject.second || step == StepperObject.third || step == StepperObject.fourth || step == StepperObject.fifth || step == StepperObject.sixth ? Colors.white : secondary ),
              ),
              SizedBox(
                    width: displayWidth(context) * 0.15,
                    child: Divider(
                        indent: 10,
                        endIndent: 10,
                        color: step == StepperObject.third || step == StepperObject.fourth || step == StepperObject.fifth || step == StepperObject.sixth
                            ? secondary
                            : Colors.grey.shade300,
                        thickness: 0.8)),
              CircleAvatar(
                  radius: 15,
                  backgroundColor: step ==  StepperObject.third || step == StepperObject.fourth || step == StepperObject.fifth || step == StepperObject.sixth
                      ? secondary
                      : Colors.grey.shade300,
                  child: Icon(Icons.looks_3_rounded,
                      size: 15,
                      color:
                      step == StepperObject.third || step == StepperObject.fourth || step == StepperObject.fifth || step == StepperObject.sixth ? Colors.white : secondary),
                ),
            ]
        ),
        Expanded(
            child: dynamicWidget),
        Align(
            alignment: Alignment.bottomRight,
            child: dynamicButton)
      ],
    );
  }
}