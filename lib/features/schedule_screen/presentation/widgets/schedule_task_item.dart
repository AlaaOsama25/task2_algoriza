import 'package:flutter/material.dart';
import 'package:task2_algoriza/core/util/cubit/cubit.dart';

class ScheduleTaskItem extends StatelessWidget {
  ScheduleTaskItem({Key? key,required this.cubit,required this.model}) : super(key: key);
  AppCubit cubit;
  Map model;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        checkboxTheme: CheckboxThemeData(
           side: AlwaysActiveBorderSide()
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: Color(int.parse(model['color'])),
          ),
          child: CheckboxListTile(
              title: Text('${model['starttime']}',style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),),
              subtitle: Text('${model['title']}',style: TextStyle(color: Colors.white)),
              controlAffinity: ListTileControlAffinity.trailing,
              //activeColor: Colors.green,
              checkColor: Colors.white,
              activeColor: Colors.transparent,
              value: model['completed']=='true',
              checkboxShape: CircleBorder(),
              onChanged:(value){
                cubit.ChangeScheduleCheckBox(value,model);
                print('ely mb3ot ${value}');

              }
          ),
        ),
      ),
    );
  }

}
class AlwaysActiveBorderSide extends MaterialStateBorderSide {
  @override
  BorderSide? resolve(_) => const BorderSide(color: Colors.white,width: 1);
}

