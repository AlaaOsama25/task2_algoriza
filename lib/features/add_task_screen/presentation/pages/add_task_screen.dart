import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:task2_algoriza/core/util/cubit/cubit.dart';
import 'package:task2_algoriza/core/util/cubit/states.dart';

import '../../../../core/util/widgets/default_textformfield.dart';
import '../widgets/default_dropdownbutton.dart';

class AddTaskScreen extends StatelessWidget {
   AddTaskScreen({Key? key}) : super(key: key);


  DateTime date= DateTime.now();

  TextEditingController _titleController = TextEditingController();
   TextEditingController _DateController = TextEditingController();
   TextEditingController _StartTimeController = TextEditingController();
   TextEditingController _EndTimeController = TextEditingController();
   final GlobalKey<FormState> formKey = new GlobalKey<FormState>();


   @override
  Widget build(BuildContext context) {
     return BlocConsumer<AppCubit,AppStates>(
       listener: (context, state) {},
       builder: (context, state) {
         AppCubit cubit = AppCubit.get(context);
         return Scaffold(
          appBar: AppBar(
            title: Text('Add task',style: TextStyle(
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
          body: Form(
            key: formKey,
            child: Column(
              children: [
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Title',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            DefaultFormField(
                              keyType: null,
                              title: 'Design team meeting',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter task name';
                                }
                                return null;
                              },
                              paddingHorizontal: 20,
                              paddingVertical: 20,
                              Controller: _titleController,
                              onpressed: (){},),
                            SizedBox(height: 20,),
                            Text('Date',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            DefaultFormField(keyType: TextInputType.datetime, title: '2021-02-28',paddingHorizontal: 20,paddingVertical: 20,
                              Controller: _DateController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Assign Date';
                                }
                                return null;
                              },
                              SuffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
                              onpressed: (){

                                print('pressed');
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2022,12,30)
                                ).then((value) {
                                  _DateController.text='${value?.year.toString()}'+'-'+'${value!.month.toString()}'+'-'+'${value.day.toString()}';
                                  print('${value?.year.toString()}'+'-'+'${value!.month.toString()}'+'-'+'${value!.day.toString()}');
                                });
                              },

                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Start time',style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      DefaultFormField(keyType: TextInputType.datetime,
                                        title: '11:00 am',paddingHorizontal: 20,paddingVertical: 20,
                                        SuffixIcon: Icon(Icons.watch_later_outlined),
                                        Controller: _StartTimeController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Assign Start Date';
                                          }
                                          return null;
                                        },
                                        onpressed: (){

                                          print('pressed');
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),

                                          ).then((value) {
                                            _StartTimeController.text=value!.format(context).toString();
                                            print(value!.format(context).toString());
                                          });
                                        },

                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('End time',style: TextStyle(fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      DefaultFormField(keyType: TextInputType.datetime,
                                        title: '14:00 pm',paddingHorizontal: 20,paddingVertical: 20,
                                        SuffixIcon: Icon(Icons.watch_later_outlined),
                                        Controller: _EndTimeController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Assign End Date';
                                          }
                                          return null;
                                        },
                                        onpressed: (){
                                          print('pressed');
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),

                                          ).then((value) {
                                            _EndTimeController.text=value!.format(context).toString();
                                            print(value!.format(context).toString());
                                          });
                                        },

                                      ),



                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Text('Remind',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            DefaultDropDownButton(
                              InitialValue: '${cubit.RemindSelectedValue.toString()}',
                              Data: cubit.RemindDropDownMenuItem,
                              WhenChange: cubit.ChangeRemindSelectedValue,
                              hint: '10 minutes early',),
                            SizedBox(height: 20,),
                            Text('Repeat',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            DefaultDropDownButton(
                              InitialValue: '${cubit.RepeatSelectedValue.toString()}',
                              Data: cubit.RepeatDropDownMenuItem,
                              WhenChange: cubit.ChangeRepeatSelectedValue,
                              hint: 'Weekly',),
                            SizedBox(height: 20,),
                            Text('Color',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                           InkWell(
                             onTap: (){
                               showDialog(
                                   context: context,
                                   builder: (BuildContext context){
                                     return AlertDialog(
                                       title: Text('Pick a color!'),
                                       content: SingleChildScrollView(
                                         child: BlockPicker(
                                           pickerColor: cubit.mycolor, //default color
                                           onColorChanged: (Color color){ //on color picked
                                             cubit.ChangeTaskColor(color);
                                           },
                                         ),
                                       ),
                                       actions: <Widget>[
                                         ElevatedButton(
                                           child: const Text('DONE'),
                                           onPressed: () {
                                             Navigator.of(context).pop(); //dismiss the color picker
                                           },
                                         ),
                                       ],
                                     );
                                   }
                               );
                             },
                             child: Container(
                          color: cubit.mycolor, //background color of app from color picker
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20),
                          child:Text("Click to choose color",style: TextStyle(color: Colors.white),),
                             ),
                           )
                             ],
                        ),
                      ),
                    ),
                  ),
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
                          final FormState? form = formKey.currentState;
                          if(form!.validate()){
                            cubit.InsertToDatabase(
                                title: '${_titleController.text}',
                                date: '${_DateController.text}',
                                starttime: '${_StartTimeController.text}',
                                endtime: '${_EndTimeController.text}',
                                remind: '${cubit.RemindSelectedValue}',
                                repeat: '${cubit.RepeatSelectedValue}',
                                completed: 'false',
                                favorite: 'false',
                                color: '${cubit.mycolor.value}'

                            );
                            print(cubit.mycolor.value);


                            Navigator.pop(context);
                          }

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
                        },
                        child: Text(
                          'Create a task',
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
