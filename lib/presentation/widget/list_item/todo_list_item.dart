import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/todo_controller.dart';

class TodoListItem extends StatelessWidget {
  final String text;
  final String date;
  final bool checkBoxStatus;
  final Function onClickCheckBox;

  const TodoListItem({super.key,
    required this.text,
    required this.date,
    required this.checkBoxStatus,
    required this.onClickCheckBox});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: (){
       onClickCheckBox();
     },
      child: AbsorbPointer(absorbing: true,
        child: Row(
          children: [
            Checkbox(
              value: checkBoxStatus,
              onChanged: (value) {
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text.rich(TextSpan(
                  children: [TextSpan(text: "Date:\t",
                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                    TextSpan(text: "${date}", style: TextStyle(fontSize: 10,))],))
              ],
            )
          ],
        ),
      ),
    );

    return ListTile(
      leading: Checkbox(
        value: checkBoxStatus,
        onChanged: (value) {
          if (value == true) {
            onClickCheckBox();
          }
        },
      ),
      title: Text(
        text,
        style: TextStyle(
            decoration: TextDecoration.lineThrough,
            fontSize: 12,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
