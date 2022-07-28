import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/cubit/cubit.dart';
import '../../../../core/util/cubit/states.dart';
import '../widgets/board_task_item.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.completedTasks.length>0,
            builder: (context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: cubit.completedTasks.length,
                    itemBuilder: (context, index) => BoardTaskItem(cubit: cubit,model: cubit.completedTasks[index],)
                )
            ),
            fallback: (context) => Center(child:Text("Complete Some Tasks! ")),
          );
        }
    );
  }
}
