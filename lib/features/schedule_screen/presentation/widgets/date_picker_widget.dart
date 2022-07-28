import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2_algoriza/core/util/cubit/cubit.dart';
import 'package:task2_algoriza/core/util/cubit/states.dart';

class DatePickerWidget extends StatelessWidget {
   DatePickerWidget({Key? key,}) : super(key: key);
  DatePickerController _controller = DatePickerController();
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocProvider(create: (context) => AppCubit(),
    child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
      return DatePicker(
        DateTime.now(),
        width: 40,
        height: 70,
        controller: _controller,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.green,
        selectedTextColor: Colors.white,
        monthTextStyle: const TextStyle(
            fontSize: 0
        ),
        dateTextStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold
        ),
        dayTextStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold
        ),

        onDateChange: (date) {
         cubit.ChangeDatePickerSelectedItem(date);
        },
      );
    }),);
  }
}
