import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DefaultDropDownButton extends StatelessWidget {
   DefaultDropDownButton({Key? key,required this.InitialValue,required this.Data,required this.WhenChange,required this.hint}) : super(key: key);
   final List<String> Data;
  late String InitialValue;
  late Function WhenChange;
  late String hint;


  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children:  [
            Expanded(
              child: Text(
                '${hint}',
                // style: TextStyle(
                //   fontSize: 14,
                //   fontWeight: FontWeight.bold,
                //   color: Colors.grey,
                // ),
                //overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: Data
            .map(( String item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            ("${item}"),
            style: const TextStyle(
              // fontSize: 14,
              // fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )).toList(),
        value: InitialValue,
        onChanged: (value) {
          WhenChange(value);
        },
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Colors.grey,
        ),
        //iconSize: 14,
        //iconEnabledColor: Colors.green,
        //iconDisabledColor: Colors.grey,
        buttonHeight: 60,
        buttonWidth: double.infinity,
        buttonPadding: const EdgeInsets.only(
            left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade100,
          ),
          color: Colors.grey.shade100,
        ),
        buttonElevation: 0,
        itemHeight: 50,
        itemPadding: const EdgeInsets.only(
            left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownWidth: 350,
        dropdownPadding:
        EdgeInsets.symmetric(horizontal: 20),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),
      ),
    );
  }
}
