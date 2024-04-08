import 'package:flutter/material.dart';



class ReusableTextField extends StatefulWidget {
  const ReusableTextField({
    super.key,
    required this.onChangedFunc,
    required this.validationFunc,
    required this.hint,
    required this.isPasswordField,
    required this.textEditingController, required this.minLines, required this.maxLines,
  });
  final Function onChangedFunc;
  final Function validationFunc;
  final String hint;
  final bool isPasswordField;
  final TextEditingController textEditingController;
  final int minLines;
  final int maxLines;
  @override
  State<ReusableTextField> createState() => _ReusableTextFieldState();
}

class _ReusableTextFieldState extends State<ReusableTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: TextFormField(
        controller: widget.textEditingController,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        cursorColor: Colors.black,
        obscureText: widget.isPasswordField ? !showPassword : false,
        decoration: InputDecoration(
          hintText: widget.hint,
          labelText: widget.hint ,
          suffixIcon: widget.isPasswordField
              ? IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: Icon(
              showPassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
              size: 23,
            ),
          )
              : null,
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 25, 5),
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.black.withOpacity(0.1), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.purple.withOpacity(0.2), width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          errorStyle: const TextStyle(
            fontSize: 10.0,
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
        ),
        validator: (value) {
          return widget.validationFunc(value);
        },
        onChanged: (value) => widget.onChangedFunc(value),
      ),
    );
  }
}