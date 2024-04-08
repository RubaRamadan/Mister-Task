import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton({super.key, required this.btnText, required this.onTapFunction});
  final String btnText;
  final Function onTapFunction;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:(){
      onTapFunction();
    } , child: Text(btnText));
  }
}


class ReusableDeleteButton extends StatelessWidget {
  const ReusableDeleteButton({super.key, required this.btnText, required this.onTapFunction});
  final String btnText;
  final Function onTapFunction;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red,),
        onPressed:(){
      onTapFunction();
    } , child: Text(btnText,style: const TextStyle(color: Colors.white)));
  }
}
