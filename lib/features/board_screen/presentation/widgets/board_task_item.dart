import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2_algoriza/core/util/cubit/cubit.dart';
import 'package:task2_algoriza/core/util/cubit/states.dart';

class BoardTaskItem extends StatelessWidget {
   BoardTaskItem({Key? key,required this.cubit,required this.model}) : super(key: key);
  AppCubit cubit;
  Map model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {
        return Theme(
          data: ThemeData(
              unselectedWidgetColor: Color(int.parse(model['color']))
          ),
          child: CheckboxListTile(
              title: Text('${model['title']}'),
              secondary: PopupMenuButton(
                  color: Colors.white,
                  onSelected: (String value){
                    cubit.ChoiceAction(value, model);

                  },
                  itemBuilder: (context) =>  cubit.TaskOptions.map(( String options) {
                    return new PopupMenuItem<String >(
                        value: options,
                        child: Text('${options}')
                    );
                  }).toList()



              ),
              controlAffinity: ListTileControlAffinity.leading,
              //activeColor: Colors.green,
              checkColor: Colors.white,
              activeColor: Color(int.parse(model['color'])),
              value: model['completed']=='true',
              checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onChanged:(value){
                cubit.ChangeBoardCheckBox(value,model);
              }
          ),
        );
      },

    );
  }
}
