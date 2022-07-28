import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task2_algoriza/core/util/cubit/states.dart';
import 'package:path/path.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialBoardState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  Color mycolor = Colors.green;

  void ChangeTaskColor(Color color){

        mycolor = color;
        print(color);
    emit(ChangeTaskColorState());

  }


  void ChangeScheduleCheckBox( value,Map model){
    print('fl awl value ely gya ${value}');
    bool checked = value;
    emit(CheckBoxChangeState());
    print('3ks el  value ely gya ${checked}');


    UpdataDataBase(completed: '${checked.toString()}', favorite: model['favorite'], id: model['id']);


    emit(CheckBoxChangeState());


  }


  void ChangeBoardCheckBox( value,Map model){

    print('fl awl value ely gya ${value}');
    bool checked = value;
    emit(CheckBoxChangeState());
    print('3ks el  value ely gya ${checked}');
    print(model['completed']=='true');


    UpdataDataBase(completed: '${checked.toString()}', favorite: model['favorite'], id: model['id']);


    emit(CheckBoxChangeState());

  }


  void ChoiceAction(String option,Map model){
    String toogle;
    if(option == 'favorite'){
      (model['favorite'] == 'true')? toogle='false':toogle='true';
      UpdataDataBase(completed: '${model['completed']}', favorite: '${toogle}', id: model['id']);
    }
    if(option == 'delete'){
      DeleteRawInDataBase(id: model['id']);

    }

  }

  int TaskOptionIndex = 0;
  List<String> TaskOptions = ['favorite','delete'];
  DateTime selectedValue = DateTime.now();

  void ChangeDatePickerSelectedItem( date){
    selectedValue = date;

    emit(ChangeDatePickerSelectedItemState());

  }

  List<String> RemindDropDownMenuItem = ['none','10 min early','30 min early','1 hour early','1 day early'];
   String RemindSelectedValue='none';

  void ChangeRemindSelectedValue( value){
    RemindSelectedValue = value;

    emit(ChangeRemindDropDownMenuItemState());

  }

  List<String> RepeatDropDownMenuItem = ['none','Weekly','Monthly'];
  String RepeatSelectedValue='none';

  void ChangeRepeatSelectedValue( value){
    RepeatSelectedValue = value;

    emit(ChangeRepeatDropDownMenuItemState());

  }

   late Database database;
  List<Map> tasks=[];
  List<Map> favorites=[];
  List<Map> completedTasks=[];
  List<Map> uncompleted=[];



  void CreateDataBase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');

     openDatabase(path,version: 1,
        onCreate: (database,version)  {
              print('database created');
             database.execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT,starttime TEXT,endtime TEXT,remind TEXT,repeat TEXT , completed TEXT, favorite TEXT,color TEXT)').
            then((value) {
                print('tables created');
            }).catchError((onError){
              print('error when creating table ${onError.toString()}');
              });
        },
      onOpen: (Database db){

      print('database opened');
      emit(DataBaseOpenedState());
      }
    ).then((value) {
      database = value;
      GetFromDataBase(database);
      emit(GetFromDataBaseState());

     });
  }

  void InsertToDatabase({
     required String title,
    required String date,
    required String starttime,
    required String endtime,
    required String remind,
    required String repeat,
    required String completed,
    required String favorite,
    required String color,

  })  async {
    await database.transaction((txn) async {
        txn.rawInsert('INSERT INTO tasks(title, date, starttime,endtime,remind,repeat,completed,favorite,color) VALUES("${title}", "${date}", "${starttime}","${endtime}","${remind} ","${repeat}","${completed}","${favorite}","${color}")').
      then((value) {
         print('${value} inserted successfully');
         emit(InsertToDataBaseState());

         GetFromDataBase(database);
           emit(GetFromDataBaseState());
       }).catchError((error){
        print('error when creating table ${error.toString()}');
      });

    });
  }

  void GetFromDataBase(database)  {
      database.rawQuery('SELECT * FROM tasks').then((value) {

       tasks=value;
       print(tasks);
       value.forEach((element) {
         if(element['favorite'] == 'true'){
           favorites.add(element);
           print(' fav ====>${favorites}');
         }
          if(element['completed'] =='true'){
           completedTasks.add(element);
           print(' com ====>${completedTasks}');

          }
          if(element['completed']=='false'){
           uncompleted.add(element);
         }
       });


       emit(GetFromDataBaseState());
    });

  }
  void UpdataDataBase({ required String completed,required String favorite, required int id}) async {
    database.rawUpdate('UPDATE tasks SET completed = ?, favorite = ? WHERE id = ?',
    ['${completed}', '${favorite}', id]).then((value) {
      print("updated");
      emit(UpdateDataBaseState());
      tasks=[];
      favorites=[];
      completedTasks=[];
      uncompleted=[];
      GetFromDataBase(database);
      emit(GetFromDataBaseState());
    }).catchError((error){
      print(error.toString());
    });

  }

  void DeleteRawInDataBase({  required int id}) async {
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      print("deleted");
      emit(DeleteRawFromDataBaseState());
      tasks=[];
      favorites=[];
      completedTasks=[];
      uncompleted=[];
      GetFromDataBase(database);
      emit(GetFromDataBaseState());
    }).catchError((error){
      print(error.toString());
    });

  }


}