import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  String name;
  Color color;
  double size;
  Function callBack;
  CustomButton({ required this.name, this.color=Colors.blueGrey,required this.callBack,this.size=23});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: ()=>callBack(name),
        child: Text(name,
          style: TextStyle(fontSize: size),
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
            backgroundColor: MaterialStateProperty.all(color),
            fixedSize: MaterialStateProperty.all(Size(70,70)),
          elevation: MaterialStateProperty.all(20)
        ),
      ),
    );
  }
}