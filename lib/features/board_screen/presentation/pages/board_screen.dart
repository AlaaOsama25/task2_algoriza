import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2_algoriza/core/util/cubit/cubit.dart';
import 'package:task2_algoriza/core/util/cubit/states.dart';
import 'package:task2_algoriza/features/board_screen/presentation/pages/favorite_task_screen.dart';
import 'package:task2_algoriza/features/board_screen/presentation/pages/uncompleted_task_screen.dart';
import 'package:task2_algoriza/features/schedule_screen/presentation/pages/schedule_screen.dart';

import '../../../add_task_screen/presentation/pages/add_task_screen.dart';
import 'all_task_screen.dart';
import 'completed_task_screen.dart';

class BoardScreen extends StatelessWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
         return DefaultTabController(
           length: 4,
           child: Scaffold(
             appBar: AppBar(
               title: Padding(
                 padding: const EdgeInsets.only(left: 16.0),
                 child: Text('Board',style: TextStyle(
                   fontSize: 23,
                 ),),
               ),
               actions: [
                 Padding(
                   padding: const EdgeInsets.only(right: 16.0),
                   child: IconButton(
                       onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleScreen()));

                       },
                       icon: Icon(Icons.calendar_today)
                   ),
                 )
               ],
             ),
             body: Column(
               children: [
                 Divider(
                   color: Colors.grey.shade300,
                   thickness: 2,
                 ),
                 Container(
                   decoration: BoxDecoration(
                     border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 2)),
                   ),
                   child: TabBar(
                     unselectedLabelColor: Colors.grey,
                     labelColor: Colors.black,
                     isScrollable: true,
                     indicatorColor: Colors.black,
                     tabs: [
                       Tab(
                         child: Text(
                           'All',

                         ),
                       ),
                       Tab(
                         child:
                         Text('Completed',),
                       ),
                       Tab(
                         child: Text(
                           'Uncompleted',

                         ),
                       ),
                       Tab(
                         child:
                         Text('Favorite', ),
                       ),
                     ],

                   ),

                 ),
                 Expanded(
                   child:
                   TabBarView(
                       children: [
                         AllTasksScreen(),
                         CompletedTasksScreen(),
                         UnCompletedTasksScreen(),
                         FavoriteTasksScreen(),


                       ]),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Container(
                     width: double.infinity,
                     height: 50,
                     child: MaterialButton(
                         color: Colors.green,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(16),

                         ),
                         // padding:EdgeInsetsDirectional.all(13),
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
                         },
                         child: Text(
                           'Add a task',
                           style: TextStyle(
                               fontWeight: FontWeight.bold,
                               color: Colors.white,
                               fontSize: 20),
                         )),
                   ),
                 )
               ],
             ),
           ),
         );
        },
    );
  }
}
