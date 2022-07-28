import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/states.dart';
import '../widgets/board_task_item.dart';

class UnCompletedTasksScreen extends StatelessWidget {
  const UnCompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.uncompleted.length>0,
            builder: (context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cubit.uncompleted.length,
                    itemBuilder: (context, index) => BoardTaskItem(cubit: cubit,model: cubit.uncompleted[index],)
                )
            ),
            fallback: (context) => Center(child:Text("No Uncompleted Tasks ")),
          );
        }
    );
  }
}
