import 'package:todo_app/widgets/inputfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

final _formKey = GlobalKey<FormState>();
TimeOfDay timeOfDay = TimeOfDay.now();

Widget bottomSheet({
  required cubit,
  required TextEditingController title,
  required TextEditingController time,
  required TextEditingController date,
  required scaffoldKey,
  required BuildContext context,
}){
  return FloatingActionButton(
    mini: true,
    onPressed: () async{
      //

      if(cubit.open){

        if(_formKey.currentState!.validate()){
          cubit.insertToDatabase(
            title: title.text,
            time: time.text,
            date: date.text,
          );
          scaffoldKey.currentState!.showBottomSheet((context) => Container(height: 0,width: 0,));
          cubit.changeOpenBottomSheet();
        }

      }else{
        time.value = TextEditingValue(text: timeOfDay.format(context));
        String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
        date.value = TextEditingValue(text: formattedDate);
        scaffoldKey.currentState!.showBottomSheet((context) => Container(
          color: Colors.grey[200],
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                inputFormField(
                  validator: (String? value) {
                    if(value!.isEmpty){
                      return "title must be not empty";
                    }
                    return null;
                  },
                  controller: title,
                  hintText: "Task title",
                  prefixIcon: Icons.title,
                  onTap: (){

                  },
                  onFieldSubmitted: (value){
                  }, textInputType: TextInputType.text,

                ),
                inputFormField(
                  validator: (String? value) {
                    if(value!.isEmpty){
                      return "TIME must be not empty";
                    }
                    return null;
                  },
                  controller: time,
                  hintText: "Task time",
                  prefixIcon: Icons.lock_clock,
                  onTap: () async{
                    await showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value){
                      time.value = TextEditingValue(text: value!.format(context));
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onFieldSubmitted: (value){
                    print(value);
                  },
                  textInputType: TextInputType.datetime,
                ),
                inputFormField(
                  validator: (String? value) {
                    if(value!.isEmpty){
                      return "DATE must be not empty";
                    }
                    return null;
                  },
                  controller: date,
                  hintText: "Task Date",
                  prefixIcon: Icons.date_range,
                  onTap: () async{
                    await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2050)).then((value){
                      String formattedDate = DateFormat('dd/MM/yyyy').format(value!);
                      date.value = TextEditingValue(text: formattedDate);
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onFieldSubmitted: (value){
                    print(value);
                  },
                  textInputType: TextInputType.datetime,
                ),
              ],
            ),
          ),
        )).closed.then((value){
          scaffoldKey.currentState!.showBottomSheet((context) => Container(height: 0,width: 0,));
          cubit.changeOpenBottomSheet();
        });
        cubit.changeOpenBottomSheet();
      }

    },
    child: cubit.open ?const Text("+",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),):Icon(Icons.edit),
  );
}