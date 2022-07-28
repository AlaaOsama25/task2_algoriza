import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task2_algoriza/core/util/cubit/cubit.dart';

import '../../../../core/util/cubit/states.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/schedule_task_item.dart';


class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
    listener: (context, state) {},
    builder: (context, state) {
      AppCubit cubit = AppCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text('Schedule',style: TextStyle(
            fontSize: 23,
          ),),
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 15,

              ),
            ),
          ),

        ),
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DatePickerWidget()
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
                Padding(
                  padding:  EdgeInsets.all(20.0),
                  child: Row(children: [

                    Text( DateFormat('EEEE').format(cubit.selectedValue),style: TextStyle(fontWeight: FontWeight.bold),),
                    Spacer(),
                    Text(DateFormat('d MMM, yyyy').format(cubit.selectedValue),style: TextStyle(
                        fontWeight: FontWeight.w500,color: Colors.grey
                    ), // prints Tuesday, 10 Dec, 2019
                    )
                  ],),
                ),

              ],
            ),
            Expanded(
              child:ConditionalBuilder(
                condition: cubit.tasks.length>0,
                builder: (context) =>  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cubit.tasks.length,
                    itemBuilder: (context, index) => ConditionalBuilder(
                      condition: DateFormat("yyyy-M-d").format(cubit.selectedValue)==cubit.tasks[index]['date'],
                        builder:(context) =>  ScheduleTaskItem(cubit: cubit,model: cubit.tasks[index],),
                fallback: (BuildContext context){return Visibility(visible:false,child: Center(child: Text("")));},),
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              )
            )

          ],
        ),
      );
    });
  }
}
